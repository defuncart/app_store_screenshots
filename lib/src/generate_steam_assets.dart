import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'generate_custom_asset.dart';
import 'models.dart';

/// Generates a 256x icon for a program in steam launcher
@isTest
void generateSteamIcon({
  required AssetBuilder onBuildIcon,
  bool? skip,
}) {
  const size = Size(256, 256);
  const filename = 'steam/icon';
  const outputDirectory = 'steam';

  generateCustomAsset(
    'Generate Steam icon',
    size: size,
    content: onBuildIcon(size),
    filename: filename,
    outputDirectory: outputDirectory,
    replaceAllFiles: false,
    skip: skip,
  );
}

/// Generates a 600x900 cover art for a program in steam launcher
@isTest
void generateSteamCover({
  required AssetBuilder onBuildCover,
  bool? skip,
}) {
  const size = Size(600, 900);
  const filename = 'steam/cover';
  const outputDirectory = 'steam';

  generateCustomAsset(
    'Generate Steam cover',
    size: size,
    content: onBuildCover(size),
    filename: filename,
    outputDirectory: outputDirectory,
    replaceAllFiles: false,
    skip: skip,
  );
}

/// Generates a 650x248 logo art for a program in steam launcher
@isTest
void generateSteamLogo({
  required AssetBuilder onBuildLogo,
  bool? skip,
}) {
  const size = Size(650, 248);
  const filename = 'steam/logo';
  const outputDirectory = 'steam';

  generateCustomAsset(
    'Generate Steam logo',
    size: size,
    content: onBuildLogo(size),
    filename: filename,
    outputDirectory: outputDirectory,
    replaceAllFiles: false,
    skip: skip,
  );
}

/// Generates a 1290x620 hero background art for a program in steam launcher
@isTest
void generateSteamHero({
  required AssetBuilder onBuildHero,
  bool? skip,
}) {
  const size = Size(1290, 620);
  const filename = 'steam/hero';
  const outputDirectory = 'steam';

  generateCustomAsset(
    'Generate Steam hero',
    size: size,
    content: onBuildHero(size),
    filename: filename,
    outputDirectory: outputDirectory,
    replaceAllFiles: false,
    skip: skip,
  );
}

/// Generates a 920x430 banner for last opened program in steam launcher
@isTest
void generateSteamBanner({
  required AssetBuilder onBuildBanner,
  bool? skip,
}) {
  const size = Size(920, 430);
  const filename = 'steam/banner';
  const outputDirectory = 'steam';

  generateCustomAsset(
    'Generate Steam banner',
    size: size,
    content: onBuildBanner(size),
    filename: filename,
    outputDirectory: outputDirectory,
    replaceAllFiles: false,
    skip: skip,
  );
}
