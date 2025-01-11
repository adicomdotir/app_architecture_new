import 'dart:convert';
import 'dart:io';

import 'package:app_architecture_new/result/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile {
  UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
    );
  }

  final int id;
  final String name;
  final String username;
  final String email;
}

class ApiClientService {
  ApiClientService();

  final client = http.Client();

  Future<Result<UserProfile>> getUserProfile() async {
    try {
      final response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
      await Future.delayed(const Duration(seconds: 1));
      if (response.statusCode == 200) {
        return Result.ok(UserProfile.fromJson(jsonDecode(response.body)));
      } else {
        return Result.error(const HttpException('Invalid response'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }
}

class UserProfileRepository {
  UserProfileRepository({required ApiClientService apiClientService})
      : _apiClientService = apiClientService;

  final ApiClientService _apiClientService;

  Future<Result<UserProfile>> getUserProfile() async {
    return await _apiClientService.getUserProfile();
  }
}

class UserProfileViewModel extends ChangeNotifier {
  UserProfileViewModel({required this.userProfileRepository});

  final UserProfileRepository userProfileRepository;

  UserProfile? userProfile;

  Exception? error;

  Future<void> load() async {
    final result = await userProfileRepository.getUserProfile();
    switch (result) {
      case Ok<UserProfile>():
        userProfile = result.value;
      case Error<UserProfile>():
        error = result.error;
    }
    notifyListeners();
  }
}

void main() {
  runApp(
    MaterialApp(
      home: HomePage(
        viewModel: UserProfileViewModel(
          userProfileRepository: UserProfileRepository(
            apiClientService: ApiClientService(),
          ),
        ),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({required this.viewModel, super.key});

  final UserProfileViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          if (widget.viewModel.error != null) {
            return Center(child: Text('${widget.viewModel.error}'));
          }

          if (widget.viewModel.userProfile != null) {
            return Center(child: Text('${widget.viewModel.userProfile?.name}'));
          }

          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
