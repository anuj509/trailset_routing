library parsel_web_optimize_theme;

import 'package:flutter/material.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

part 'theme_base.dart';
part 'light_theme.dart';
part 'static_colors.dart';

/// This is the manager class of the application theme.
/// we can manage application using this class and methods of this class.
/// all the functions regarding theme will be in this class.
class ThemeManager {
  /// this function is used to manage theme and initialize theme data.
  static void initializeTheme() {
    VariableUtilities.theme = LightTheme();
  }
}
