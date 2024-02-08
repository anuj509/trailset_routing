import 'package:flutter/material.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

/// FontUtilities is main base class for all the styles of fonts used.
/// you can directly change the font styles in this file.
/// so, all the fonts used in application will be changed.
class FontUtilities {
  /// Font Family
  static String openSans = 'OpenSans';

  // static String

  /// FONT STYLE FOR FONT SIZE 8
  static TextStyle h6({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 6,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  static TextStyle h8({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 8,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 9
  static TextStyle h9({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 9,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 10
  static TextStyle h10({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 10,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 11
  static TextStyle h11({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 11,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 12
  static TextStyle h12({
    required Color? fontColor,
    TextDecoration? decoration,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 12,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 13
  static TextStyle h13({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 13,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 14
  static TextStyle h14({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 14,
        decorationColor: VariableUtilities.theme.primaryColor,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 15
  static TextStyle h15({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 15,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 16
  static TextStyle h16({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 16,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 18
  static TextStyle h18({
    required Color? fontColor,
    TextDecoration? decoration,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 18,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 20
  static TextStyle h20({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 20,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 21
  static TextStyle h21({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 21,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 22
  static TextStyle h22({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 22,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 23
  static TextStyle h23({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 23,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 24
  static TextStyle h24({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 24,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 26
  static TextStyle h26({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 26,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 28
  static TextStyle h28({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 28,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 30
  static TextStyle h30({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 30,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 32
  static TextStyle h32({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 32,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 34
  static TextStyle h34({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 34,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 36
  static TextStyle h36({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 36,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 38
  static TextStyle h38({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 38,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 40
  static TextStyle h40({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 40,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 45
  static TextStyle h45({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 45,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 50
  static TextStyle h50({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 50,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 55
  static TextStyle h55({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 55,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 60
  static TextStyle h60({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 60,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 65
  static TextStyle h65({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 65,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 70
  static TextStyle h70({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 70,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 75
  static TextStyle h75({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 75,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }

  /// FONTSTYLE FOR FONT SIZE 80
  static TextStyle h80({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
    FF fontFamily = FF.openSans,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontWeight(fontWeight),
        fontSize: 80,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: fontFamily == FF.openSans ? openSans : '');
  }
}

/// these are the most commonly used fontweight for mobile application.
enum FF {
  ///Inria Sans
  openSans
}

/// these are the most commonly used fontweight for mobile application.
enum FWT {
  /// FontWeight -> 900
  extraBold,

  /// FontWeight -> 800
  black,

  /// FontWeight -> 700
  bold,

  /// FontWeight -> 600
  semiBold,

  /// FontWeight -> 500
  medium,

  /// FontWeight -> 400
  regular,

  /// FontWeight -> 200
  light,
}

/// THIS FUNCTION IS USED TO SET FONT WEIGHT ACCORDING TO SELECTED ENUM...
FontWeight getFontWeight(FWT fwt) {
  switch (fwt) {
    case FWT.light:
      return FontWeight.w200;
    case FWT.regular:
      return FontWeight.w400;
    case FWT.medium:
      return FontWeight.w500;
    case FWT.semiBold:
      return FontWeight.w600;
    case FWT.bold:
      return FontWeight.w700;
    case FWT.black:
      return FontWeight.w800;

    case FWT.extraBold:
      return FontWeight.w900;
  }
}
