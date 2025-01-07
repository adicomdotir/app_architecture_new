// TODO Implement this library.
import 'package:app_architecture_new/ui/theme_config/viewmodel/theme_switch_viewmodel.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    required this.viewmodel,
    super.key,
  });

  final ThemeSwitchViewModel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Text('Dark Mode'),
          ListenableBuilder(
            listenable: viewmodel,
            builder: (context, _) {
              return Switch(
                value: viewmodel.isDarkMode,
                onChanged: (_) {
                  viewmodel.toggle.execute();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
