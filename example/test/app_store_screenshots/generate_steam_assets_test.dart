import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:example/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  generateSteamIcon(
    onBuildIcon: (size) => SteamAsset(
      size: size,
    ),
  );

  generateSteamCover(
    onBuildCover: (size) => SteamAsset(
      size: size,
    ),
  );

  generateSteamLogo(
    onBuildLogo: (size) => SteamAsset(
      size: size,
      isTransparent: true,
    ),
  );

  generateSteamHero(
    onBuildHero: (size) => SteamAsset(
      size: size,
    ),
  );

  generateSteamBanner(
    onBuildBanner: (size) => SteamAsset(
      size: size,
    ),
  );
}

class SteamAsset extends StatelessWidget {
  const SteamAsset({
    super.key,
    required this.size,
    this.isTransparent = false,
  });

  final Size size;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme,
      child: Container(
        width: size.width,
        height: size.height,
        color: isTransparent ? Colors.transparent : Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Icon(
            Icons.flutter_dash,
            color: Theme.of(context).iconTheme.color,
            size: size.shortestSide * 0.6,
          ),
        ),
      ),
    );
  }
}
