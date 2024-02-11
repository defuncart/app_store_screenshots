import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:flutter/material.dart';

void main() {
  final theme = ThemeData.light();

  generateStreamIcon(
    onBuildIcon: (size) => Theme(
      data: theme,
      child: SteamAsset(
        size: size,
      ),
    ),
  );

  generateStreamCover(
    onBuildCover: (size) => Theme(
      data: theme,
      child: SteamAsset(
        size: size,
      ),
    ),
  );

  generateStreamLogo(
    onBuildLogo: (size) => Theme(
      data: theme,
      child: SteamAsset(
        size: size,
        isTransparent: true,
      ),
    ),
  );

  generateStreamBackground(
    onBuildBackground: (size) => Theme(
      data: theme,
      child: SteamAsset(
        size: size,
      ),
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
    return Container(
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
    );
  }
}
