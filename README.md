# app_store_screenshots

A flutter tool to generate screenshots and other assets for app stores.

<table>
<tr>
<td><img src="example/assets_dev/screenshots/androidPhonePortrait/en/screenshot_1.png" alt="image" width="320" height="auto"></td>
<td><img src="example/assets_dev/screenshots/androidPhonePortrait/en/screenshot_2.png" alt="image" width="320" height="auto"></td>
</td>
</table>

## Getting Started

Add dependency

```yaml
app_store_screenshots:
    git: https://github.com/defuncart/app_store_screenshots
```

### Screenshots

Add `test/app_store_screenshots/generate_screenshots_test.dart`

```dart
void main() {
  generateAppStoreScreenshots(
    onSetUp: () {},
    config: (
      devices: [AppStoreDeviceType.androidPortrait],
      locales: const [Locale('en')],
    ),
    screens: [
      (
        onBuildScreen: () => const Page1(),
        wrapper: null,
        onPostPumped: null,
        backgroundColor: Colors.green,
        text: {
          const Locale('en'): 'Light mode',
        },
        textStyle: TextStyle(
          fontSize: 96,
          color: Colors.white,
        ),
        theme: ThemeData.light(),
      ),
    ],
    onTearDown: () {},
    skip: false,
  );
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Hello world'),
      ),
    );
  }
}
```

Generate screenshots using

```sh
flutter test test/app_store_screenshots/ --update-goldens
```

or

```sh
dart run app_store_screenshots:screenshots
```

Screenshots can bee found in `assets_dev/screenshots`.

See [example/test/app_store_screenshots/generate_screenshots_test.dart](example/test/app_store_screenshots/generate_screenshots_test.dart) for full example.

### App Icon

Given an `AppIcon` widget, `generateAppIcon` and `generateAppIconAndroidForeground` can be used to generated 512x512 app icons and android foreground:

<table>
<tr><td>

```dart
generateAppIcon(
  onBuildIcon: () => const AppIcon(
    size: 512,
  ),
);
```
</td><td><img src="example/assets_dev/app_icons/app_icon.png" alt="image" width="64" height="auto"></td></tr>
<td>

```dart
generateAppIconAndroidForeground(
  onBuildIcon: () => const AppIcon(
    size: 512,
    hasTransparentBackground: true,
  ),
);
```
</td><td><img src="example/assets_dev/app_icons/android_icon_foreground.png" alt="image" width="64" height="auto"></td>
</tr>
</table>

Icons can be found in `assets_dev/app_icons`. [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) could then be used to update the launcher icons for targeted platforms.

See [example/test/app_store_screenshots/generate_app_icons_test.dart](example/test/app_store_screenshots/generate_app_icons_test.dart) for full example.

### Google Play Assets

`generateGooglePlayFeatureGraphic` can be used to generate a 1024x500 feature graphic per locale for Google Play.

<table><tr>
</td><td><img src="example/assets_dev/google_play_assets/google_play_feature_graphic_de.png" alt="image" width="250" height="auto"></td>
</td><td><img src="example/assets_dev/google_play_assets/google_play_feature_graphic_en.png" alt="image" width="250" height="auto"></td>
</tr></table>

Assets can be found in `assets_dev/google_play_assets`. 

See [example/test/app_store_screenshots/generate_google_play_assets_test.dart](example/test/app_store_screenshots/generate_google_play_assets_test.dart) for full example.

## Roadmap

- Support iOS
- Support Android Tablets & Mobile Landscape
