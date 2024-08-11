import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:flutter/material.dart';

void main() {
  generateAppIcon(
    onBuildIcon: (size) => AppIcon(
      size: size,
    ),
  );

  generateAppIconAndroidForeground(
    onBuildIcon: (size) => AppIcon(
      size: size,
      hasTransparentBackground: true,
    ),
  );

  generateAppIconMacOS(
    onBuildIcon: (size) => AppIcon(
      size: size,
    ),
  );
}

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.size,
    this.hasTransparentBackground = false,
  });

  final double size;
  final bool hasTransparentBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: hasTransparentBackground ? Colors.transparent : Colors.green,
      child: Center(
        child: Icon(
          Icons.flutter_dash,
          color: Colors.white,
          size: size * 0.6,
        ),
      ),
    );
  }
}
