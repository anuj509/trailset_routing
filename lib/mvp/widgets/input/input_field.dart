import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:parsel_web_optimize/utils/utils.dart';

///Validator for text field
typedef Validator = String? Function(String?)?;
typedef OnChanged = Function(String)?;

///Input text field
class InputField extends StatefulWidget {
  ///Input text field constructor

  const InputField({
    required this.controller,
    required this.label,
    required this.hintText,

    // required this.focusNode,
    this.validator,
    this.keyboardType = TextInputType.emailAddress,
    this.labelButton,
    this.suffixIcon,
    this.hintTextStyle,
    this.prefixIcon,
    this.onTap,
    this.prefixSymbol = false,
    this.readOnly,
    this.isObscure = false,
    this.onChanged,
    this.inputFormatters = const [],
    Key? key,
  }) : super(key: key);

  ///Controller for input field
  final TextEditingController controller;

  ///Label for input textfield
  final String label;

  ///Label Button for input textfield
  final Widget? labelButton;

  ///Hint Text for input textfield
  final String hintText;

  ///prefixSymbol Text for input textfield
  final bool prefixSymbol;

  ///Hint TextStyle for input textfield
  final TextStyle? hintTextStyle;

  ///Validator for textfield
  final Validator validator;

  ///OnChanged for textfield
  final OnChanged onChanged;

  ///Suffix Icon
  final Widget? suffixIcon;

  ///Prefix Icon
  final Widget? prefixIcon;

  ///On tap for input field
  final VoidCallback? onTap;

  ///Read only
  final bool? readOnly;

  ///Text Field is obscure
  final bool? isObscure;

  ///
  final TextInputType keyboardType;

  final List<TextInputFormatter> inputFormatters;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.label.isEmpty
            ? const SizedBox()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.blackColor),
                  ),
                  widget.labelButton ?? const SizedBox()
                ],
              ),
        const SizedBox(height: 5),
        Focus(
          onFocusChange: (focus) {
            isTapped = focus;
            setState(() {});
          },
          child: TextFormField(
            inputFormatters: [],
            keyboardType: widget.keyboardType,
            onTap: widget.onTap ?? () {},
            validator: widget.validator ??
                (String? val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Appropriate Value';
                  } else {
                    return null;
                  }
                },
            controller: widget.controller,
            readOnly: widget.readOnly ?? false,
            obscureText: widget.isObscure!,
            cursorColor: Colors.black,
            onChanged: widget.onChanged,
            style: FontUtilities.h16(
                fontColor: VariableUtilities.theme.blackColor),
            decoration: InputDecoration(
                prefixText: widget.prefixSymbol ? '₹ ' : '',
                prefixStyle: FontUtilities.h16(
                    fontColor: VariableUtilities.theme.color737B85),
                prefixIcon: widget.prefixIcon,
                hintText: widget.hintText,
                hintStyle: widget.hintTextStyle ??
                    FontUtilities.h14(
                        fontColor: VariableUtilities.theme.color737B85),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                enabledBorder: CustomInputBorder(
                  boxShadow: [
                    BoxShadow(
                      color: isTapped
                          ? VariableUtilities.theme.primaryColor
                              .withOpacity(0.4)
                          : VariableUtilities.theme.primaryColor
                              .withOpacity(0.0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(
                          0, 1), // Adjust the offset as per your preference
                    ),
                  ],
                  // borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: VariableUtilities.theme.color94A0C5,
                      style: BorderStyle.solid),
                ),
                border: CustomInputBorder(
                  boxShadow: [
                    BoxShadow(
                      color: isTapped
                          ? VariableUtilities.theme.primaryColor
                              .withOpacity(0.4)
                          : VariableUtilities.theme.primaryColor
                              .withOpacity(0.0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(
                          0, 1), // Adjust the offset as per your preference
                    ),
                  ],
                  // borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: VariableUtilities.theme.color94A0C5,
                      style: BorderStyle.solid),
                ),
                focusedBorder: CustomInputBorder(
                  boxShadow: [
                    BoxShadow(
                      color: isTapped
                          ? VariableUtilities.theme.primaryColor
                              .withOpacity(0.4)
                          : VariableUtilities.theme.primaryColor
                              .withOpacity(0.0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(
                          0, 1), // Adjust the offset as per your preference
                    ),
                  ],
                  borderSide: BorderSide(
                      color: VariableUtilities.theme.primaryColor,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: CustomInputBorder(
                  boxShadow: [
                    BoxShadow(
                      color: isTapped
                          ? VariableUtilities.theme.redColor.withOpacity(0.4)
                          : VariableUtilities.theme.redColor.withOpacity(0.0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(
                          0, 1), // Adjust the offset as per your preference
                    ),
                  ],
                  // borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: VariableUtilities.theme.redColor,
                      style: BorderStyle.solid),
                ),
                errorBorder: CustomInputBorder(
                  boxShadow: [
                    BoxShadow(
                      color: isTapped
                          ? VariableUtilities.theme.redColor.withOpacity(0.4)
                          : VariableUtilities.theme.redColor.withOpacity(0.0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(
                          0, 1), // Adjust the offset as per your preference
                    ),
                  ],
                  // borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: VariableUtilities.theme.color94A0C5,
                      style: BorderStyle.solid),
                ),
                suffixIcon: widget.suffixIcon ?? const SizedBox(),
                hoverColor: VariableUtilities.theme.color94A0C5),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class CustomInputBorder extends InputBorder {
  final double borderRadius;
  final BorderSide borderSide;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow> boxShadow;
  final Color? backgroundColor;

  const CustomInputBorder({
    this.borderRadius = 3.0,
    this.borderSide = const BorderSide(),
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.boxShadow = const [],
    this.backgroundColor = Colors.white,
  }) : super();

  @override
  EdgeInsetsGeometry get dimensions => padding;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(
          rect, Radius.circular(borderRadius - borderSide.width)));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)))
      ..addRRect(RRect.fromRectAndRadius(rect.deflate(borderSide.width),
          Radius.circular(borderRadius - borderSide.width)));
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double? gapExtent,
      double? gapPercentage,
      TextDirection? textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius borderRadius = BorderRadius.zero}) {
    final Paint paint = borderSide.toPaint();

    // Fill the background with a color if specified

    // Add boxShadow
    for (BoxShadow shadow in boxShadow) {
      final Path shadowPath = getOuterPath(rect.inflate(shadow.spreadRadius),
          textDirection: textDirection);
      final Paint shadowPaint = Paint()
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius);
      canvas.drawPath(shadowPath, shadowPaint);
    }

    final Path path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, paint);

    // Draw the white background with border radius
    if (backgroundColor != null) {
      final backgroundRect = Rect.fromLTWH(
        rect.left + borderSide.width,
        rect.top + borderSide.width,
        rect.width - borderSide.width * 2,
        rect.height - borderSide.width * 2,
      );
      final backgroundRadius = BorderRadius.circular(3);
      final backgroundPaint = Paint()..color = backgroundColor!;
      canvas.drawRRect(
          RRect.fromRectAndCorners(
            backgroundRect,
            topLeft: backgroundRadius.topLeft,
            topRight: backgroundRadius.topRight,
            bottomLeft: backgroundRadius.bottomLeft,
            bottomRight: backgroundRadius.bottomRight,
          ),
          backgroundPaint);
    }
  }

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return CustomInputBorder(
      borderRadius: borderRadius,
      borderSide: borderSide ?? this.borderSide,
      padding: padding,
      boxShadow: boxShadow,
      backgroundColor: backgroundColor,
    );
  }

  @override
  InputBorder scale(double t) {
    return CustomInputBorder(
      borderRadius: borderRadius * t,
      borderSide: borderSide.scale(t),
      padding: padding * t,
      boxShadow: boxShadow,
      backgroundColor: backgroundColor,
    );
  }

  @override
  bool get isOutline => true;
}

class CustomInputBorders extends InputBorder {
  final double borderRadius;
  final BorderSide borderSide;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow> boxShadow;

  const CustomInputBorders({
    this.borderRadius = 3.0,
    this.borderSide = const BorderSide(),
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.boxShadow = const [],
  }) : super();

  @override
  EdgeInsetsGeometry get dimensions => padding;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(
          rect, Radius.circular(borderRadius - borderSide.width)));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)))
      ..addRRect(RRect.fromRectAndRadius(rect.deflate(borderSide.width),
          Radius.circular(borderRadius - borderSide.width)));
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double? gapExtent,
      double? gapPercentage,
      TextDirection? textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius borderRadius = BorderRadius.zero}) {
    final Paint paint = borderSide.toPaint();

    // Fill the background with white color

    // Add boxShadow
    for (BoxShadow shadow in boxShadow) {
      final Path shadowPath = getOuterPath(rect.inflate(shadow.spreadRadius),
          textDirection: textDirection);
      final Paint shadowPaint = Paint()
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius);
      canvas.drawPath(shadowPath, shadowPaint);
    }
    final backgroundRect = Rect.fromLTWH(
      rect.left,
      rect.top,
      rect.width,
      rect.height,
    );

    // Draw the border
    final backgroundPaint = Paint()..color = Colors.white;
    canvas.drawRect(backgroundRect, backgroundPaint);
    final Path path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, paint);
  }

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return CustomInputBorder(
      borderRadius: borderRadius,
      borderSide: borderSide ?? this.borderSide,
      padding: padding,
      boxShadow: boxShadow,
    );
  }

  @override
  InputBorder scale(double t) {
    return CustomInputBorder(
      borderRadius: borderRadius * t,
      borderSide: borderSide.scale(t),
      padding: padding * t,
      boxShadow: boxShadow,
    );
  }

  @override
  bool get isOutline => true;
}
