# Unexpected Behavior with Nested Async Generators in Dart.

- Minimal repro

  This is the repo.

- Steps to replicate the behavior

  1. Run app
  2. Press `Corret` button five times
  3. Press `Wrong` button five times

- Errors received
  Both actions shoul produce the same results. In reality `Correct` produse [1,2,3,4,5,6,7,8,9, 10] and `Wrong` produces [1,1,2,2,3,3,4,4,5,5].

- Plugins used and its versions

  `flutter_bloc: ^7.1.0`

- Logs from running flutter doctor --verbose

  ```log
  [✓] Flutter (Channel beta, 2.6.0-5.2.pre, on macOS 11.6 20G165 darwin-x64, locale en-DE)
      • Flutter version 2.6.0-5.2.pre at /Users/user_name/fvm/versions/beta
      • Upstream repository https://github.com/flutter/flutter.git
      • Framework revision 400608f101 (12 days ago), 2021-09-15 15:50:26 -0700
      • Engine revision 1d521d89d8
      • Dart version 2.15.0 (build 2.15.0-82.2.beta)

  [✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
      • Android SDK at /Users/user_name/Library/Android/sdk
      • Platform android-31, build-tools 30.0.2
      • ANDROID_HOME = /Users/user_name/Library/Android/sdk
      • Java binary at: /Applications/Android Studio.app/Contents/jre/Contents/Home/bin/java
      • Java version OpenJDK Runtime Environment (build 11.0.10+0-b96-7281165)
      • All Android licenses accepted.

  [✓] Xcode - develop for iOS and macOS (Xcode 13.0)
      • Xcode at /Applications/Xcode.app/Contents/Developer
      • CocoaPods version 1.10.1

  [✓] Chrome - develop for the web
      • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

  [✓] Android Studio (version 2020.3)
      • Android Studio at /Applications/Android Studio.app/Contents
      • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
      • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
      • Java version OpenJDK Runtime Environment (build 11.0.10+0-b96-7281165)

  [✓] VS Code (version 1.60.2)
      • VS Code at /Applications/Visual Studio Code.app/Contents
      • Flutter extension version 3.26.0

  [✓] Connected device (2 available)
      • macOS (desktop) • macos  • darwin-x64     • macOS 11.6 20G165 darwin-x64
      • Chrome (web)    • chrome • web-javascript • Google Chrome 93.0.4577.82

  • No issues found!
  ```

https://github.com/dart-lang/sdk/issues/44616
