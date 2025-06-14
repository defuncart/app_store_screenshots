# app_store_screenshots

A flutter tool to generate screenshots and other assets for app stores.

<table>
<tr>
<td><img src="example/assets_dev/screenshots/androidPhonePortrait/en/screenshot_1.png" alt="image" width="320" height="auto"></td>
<td><img src="example/assets_dev/screenshots/androidPhonePortrait/en/screenshot_2.png" alt="image" width="320" height="auto"></td>
</tr>
<tr>
<td><img src="example/assets_dev/screenshots/androidPhonePortrait/en/screenshot_3.png" alt="image" width="320" height="auto"></td>
<td><img src="example/assets_dev/screenshots/androidPhonePortrait/en/screenshot_4.png" alt="image" width="320" height="auto"></td>
</tr>
</table>

## About

*app_store_screenshots* utilizes goldens, a Flutter testing tool, to generate assets:

```sh
flutter test --update-goldens --tags app_store_screenshots
```

To ensure that these tests do not interfere with your testing pipeline, exclude the tag `app_store_screenshots`:

```sh
flutter test --exclude-tags app_store_screenshots
```

## Getting Started

Add dependency:

```yaml
dev_dependency:
  app_store_screenshots:
      git: https://github.com/defuncart/app_store_screenshots
```

### Screenshots

`generateAppStoreScreenshots` can be used to generate screenshots for a given `ScreenshotsConfig` and `List<ScreenshotScenario>`.

```dart
final config = ScreenshotsConfig(
  devices: [DeviceType.androidPhonePortrait, DeviceType.iOSPhone67Portrait],
  locales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  background: ScreenshotBackground.solid(
    color: Colors.green,
  ),
  foregroundOptions: const ScreenshotForegroundOptions.top(
    textStyle: textStyle,
  ),
  theme: ThemeData.light(),
);
```

```dart
final screens = [
  ScreenshotScenario(
    onBuildScreen: () => const Page1(),
    onGenerateText: (locale) => switch (locale) {
      const Locale('en') => 'Light mode',
      const Locale('de') => 'Hellmodus',
      _ => throw ScreenshotUnsupportedLocale(locale),
    },
  ),
];
```

```dart
void main() {
  generateAppStoreScreenshots(
    config: config,
    screens: screens,
  );
}
```

Screenshots can be found in [example/assets_dev/screenshots/](example/assets_dev/screenshots/).

See [example/test/app_store_screenshots/generate_screenshots_test.dart](example/test/app_store_screenshots/generate_screenshots_test.dart) for full example.

#### Supported Devices

| DeviceType               | Description        | Resolution | Frame           |
| ------------------------ | ------------------ | ---------- | --------------- |
| androidPhonePortrait     | Android Phone      | 1080x1920  | One Plus 8 Pro  |
| androidPhoneLandscape    | Android Phone      | 1920x1080  | One Plus 8 Pro  |
| androidTablet7Portrait   | Android 7" Tablet  | 1080x1920  | Generic         |
| androidTablet7Landscape  | Android 7" Tablet  | 1920x1080  | Generic         |
| androidTablet10Portrait  | Android 10" Tablet | 1080x1920  | Generic         |
| androidTablet10Landscape | Android 10" Tablet | 1920x1080  | Generic         |
| iOSPhone47Portrait       | 4.7" iPhone        | 750x1334   | iPhone SE       |
| iOSPhone47Landscape      | 4.7" iPhone        | 750x1334   | iPhone SE       |
| iOSPhone55Portrait       | 5.5" iPhone        | 1242x2208  | iPhone 13 mini¹ |
| iOSPhone55Landscape      | 5.5" iPhone        | 2208x1242  | iPhone 13 mini¹ |
| iOSPhone65Portrait       | 6.5" iPhone        | 1242x2688  | iPhone 13 mini  |
| iOSPhone65Landscape      | 6.5" iPhone        | 2688x1242  | iPhone 13 mini  |
| iOSPhone67Portrait       | 6.7" iPhone        | 1290x2796  | iPhone 13 mini¹ |
| iOSPhone67Landscape      | 6.7" iPhone        | 2796x1290  | iPhone 13 mini¹ |
| iOSTablet129Portrait     | 12.9" iPad         | 2048x2732  | iPad 4th Gen    |
| iOSTablet129Landscape    | 12.9" iPad         | 2732x2048  | iPad 4th Gen    |
| linux                    |                    | 1920x1080  | Laptop          |
| macOS                    |                    | 1920x1080  | Laptop          |
| windows                  |                    | 1920x1080  | Laptop          |

¹Incorrect frame but correct resolution

### App Icon

Given an `AppIcon` widget, `generateAppIcon` and `generateAppIconAndroidForeground` can be used to generated 512x512 app icons and android foreground, while `generateAppIconMacOS` can be used to generate a 824x macOS app icon in a 1024x frame with rounded edges and shadows:

<table>
<tr><td>

```dart
generateAppIcon(
  onBuildIcon: (size) => AppIcon(
    size: size,
  ),
);
```
</td><td><img src="example/assets_dev/app_icons/app_icon.png" alt="image" width="64" height="auto"></td></tr>
<td>

```dart
generateAppIconAndroidForeground(
  onBuildIcon: (size) => AppIcon(
    size: size,
    hasTransparentBackground: true,
  ),
);
```
</td><td><img src="example/assets_dev/app_icons/android_icon_foreground.png" alt="image" width="64" height="auto"></td>
</tr>
<td>

```dart
generateAppIconMacOS(
    onBuildIcon: (size) => AppIcon(
      size: size,
    ),
  );
```
</td><td><img src="example/assets_dev/app_icons/app_icon_macos.png" alt="image" width="64" height="auto"></td>
</tr>
</table>

Icons can be found in [example/assets_dev/app_icons/](example/assets_dev/app_icons/). [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) could then be used to update the launcher icons for targeted platforms.

See [example/test/app_store_screenshots/generate_app_icons_test.dart](example/test/app_store_screenshots/generate_app_icons_test.dart) for full example.

### Google Play Assets

`generateGooglePlayFeatureGraphic` can be used to generate a 1024x500 feature graphic per locale for Google Play.

<table><tr>
<td><img src="example/assets_dev/google_play_assets/google_play_feature_graphic_de.png" alt="image" width="250" height="auto"></td>
<td><img src="example/assets_dev/google_play_assets/google_play_feature_graphic_en.png" alt="image" width="250" height="auto"></td>
</tr></table>

Assets can be found in [example/assets_dev/google_play_assets/](example/assets_dev/google_play_assets/).

See [example/test/app_store_screenshots/generate_google_play_assets_test.dart](example/test/app_store_screenshots/generate_google_play_assets_test.dart) for full example.

### Steam Assets

Icon, Cover, Hero/Logo and Banner assets for programs in Steam Launcher can be generated as follows:

<table>
<tr><td>

```dart
generateSteamLogo(
  onBuildIcon: (size) => const SteamIcon(),
);
```
</td><td><img src="example/assets_dev/steam/icon.png" alt="image" width="64" height="auto"></td></tr>
<td>

```dart
generateSteamCover(
  onBuildCover: (size) => const SteamCover(),
);
```
</td><td><img src="example/assets_dev/steam/cover.png" alt="image" width="64" height="auto"></td></tr>
<td>

```dart
generateSteamLogo(
  onBuildLogo: (size) => const SteamLogo(),
);
```
</td><td><img src="example/assets_dev/steam/logo.png" alt="image" width="64" height="auto"></td></tr>
<td>

```dart
generateSteamHero(
  onBuildHero: (size) => const SteamHero(),
);
```
</td><td><img src="example/assets_dev/steam/hero.png" alt="image" width="64" height="auto"></td></tr>
<td>

```dart
generateSteamBanner(
  onBuildBanner: (size) => const SteamBanner(),
);
```
</td><td><img src="example/assets_dev/steam/banner.png" alt="image" width="64" height="auto"></td></tr>
</table>

Assets can be found in [example/assets_dev/steam/](example/assets_dev/steam/).

See [example/test/app_store_screenshots/generate_steam_assets_test.dart](example/test/app_store_screenshots/generate_steam_assets_test.dart) for full example.

## Custom Fonts

By default, all fonts included in pubspec.yaml, as well as dependent packages, will be loaded. However, if another font is required, for instance to render an app icon, it can be loaded as follows:

```dart
setUp(() async {
  await loadFont(
    path: 'path/to/font',
    name: 'FontFamily',
  );
});
```

and then used via `fontFamily` as required.

## Roadmap

- 0.0.1 release on pub.dev
- Add testing
