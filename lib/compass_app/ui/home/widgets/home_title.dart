import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/localization/applocalization.dart';
import '../../core/themes/dimens.dart';
import '../view_models/home_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.viewModel,
    super.key,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final user = viewModel.user;
    if (user == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                user.picture,
                width: Dimens.of(context).profilePictureSize,
                height: Dimens.of(context).profilePictureSize,
              ),
            ),
            const Text('LogoutButton'),
            // LogoutButton(
            //   viewModel: LogoutViewModel(
            //     authRepository: context.read(),
            //     itineraryConfigRepository: context.read(),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: Dimens.paddingVertical),
        _Title(
          text: AppLocalization.of(context).nameTrips(user.name),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomLeft,
        radius: 2,
        colors: [
          Colors.purple.shade700,
          Colors.purple.shade400,
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: GoogleFonts.rubik(
          textStyle: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
