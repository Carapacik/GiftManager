import 'package:flutter/material.dart';

extension ThemeBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeStylesExtension on ThemeData {
  TextStyle get h1 => textTheme.displayLarge!;

  TextStyle get h2 => textTheme.displayMedium!;

  TextStyle get h3 => textTheme.displaySmall!;

  TextStyle get h4 => textTheme.headlineMedium!;

  TextStyle get h5 => textTheme.headlineSmall!;

  TextStyle get h6 => textTheme.titleLarge!;

  TextStyle get button => textTheme.labelLarge!;
}

extension BrightnessDependantTextStyle on TextStyle {
  TextStyle dynamicColor({
    required final BuildContext context,
    required final Color lightThemeColor,
    required final Color darkThemeColor,
  }) {
    final brightness = MediaQuery.of(context).platformBrightness;
    switch (brightness) {
      case Brightness.dark:
        return copyWith(color: darkThemeColor);
      case Brightness.light:
        return copyWith(color: lightThemeColor);
    }
  }
}
