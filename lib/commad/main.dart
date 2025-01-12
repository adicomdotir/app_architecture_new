import 'package:flutter/material.dart';

import 'command.dart';
import 'result.dart';

void main(List<String> args) {
  runApp(MainApp(viewModel: HomeViewModel()));
}

class MainApp extends StatefulWidget {
  const MainApp({
    required this.viewModel,
    super.key,
  });

  final HomeViewModel viewModel;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (widget.viewModel.load.error) {
              return Center(
                child: Text('Error: ${widget.viewModel.load.error}'),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              if (widget.viewModel.user == null) {
                return const Center(
                  child: Text('No user'),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${widget.viewModel.user!.name}'),
                    Text('Email: ${widget.viewModel.user!.email}'),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onViewModelChanged() {
    widget.viewModel.load.clearResult();
    // Show Snackbar
  }
}

class User {
  User({required this.name, required this.email});

  final String name;
  final String email;
}

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command0<void>(_load)..execute();
    delete = Command1(_delete);
  }

  User? get user => null;

  late final Command0<void> load;

  late final Command1<void, int> delete;

  Future<Result<void>> _load() async {
    // load user
    return const Result.ok(null);
  }

  Future<Result<void>> _delete(int id) async {
    // delete user
    return const Result.ok(null);
  }
}
