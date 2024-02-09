import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:trailset_route_optimize/utils/utils.dart';

import 'input_field.dart';

///Input text field
class HorizontalInputField extends StatefulWidget {
  ///Input text field constructor

  const HorizontalInputField({
    required this.controller,
    required this.label,
    required this.hintText,

    // required this.focusNode,
    this.validator,
    this.keyboardType = TextInputType.emailAddress,
    this.labelButton,
    this.suffixIcon,
    this.hintTextStyle,
    this.style,
    this.prefixIcon,
    this.onTap,
    this.prefixSymbol = false,
    this.readOnly,
    this.isObscure = false,
    this.onChanged,
    this.width,
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

  ///Hint TextStyle for input textfield
  final TextStyle? style;

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

  final double? width;

  ///
  final TextInputType keyboardType;

  final List<TextInputFormatter> inputFormatters;
  @override
  State<HorizontalInputField> createState() => _HorizontalInputFieldState();
}

class _HorizontalInputFieldState extends State<HorizontalInputField> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.label.isEmpty
            ? const SizedBox()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widget.width ?? 131,
                    child: Text(
                      widget.label,
                      style: FontUtilities.h16(
                          fontColor: VariableUtilities.theme.color292D32),
                    ),
                  ),
                  widget.labelButton ?? const SizedBox()
                ],
              ),
        const SizedBox(height: 5),
        Expanded(
          child: Focus(
            onFocusChange: (focus) {
              isTapped = focus;
              setState(() {});
            },
            child: TextFormField(
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
              style: widget.style ??
                  FontUtilities.h16(
                      fontColor: VariableUtilities.theme.color737B85),
              decoration: InputDecoration(
                  prefixText: widget.prefixSymbol ? '₹ ' : '',
                  prefixStyle: FontUtilities.h16(
                      fontColor: VariableUtilities.theme.color737B85),
                  prefixIcon: widget.prefixIcon,
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle ??
                      FontUtilities.h16(
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
                      width: 0.5,
                      color: VariableUtilities.theme.color94A0C5,
                    ),
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
                      width: 0.5,
                      color: VariableUtilities.theme.color94A0C5,
                    ),
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
                      width: 0.5,
                      color: VariableUtilities.theme.primaryColor,
                    ),
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
                      width: 0.5,
                      color: VariableUtilities.theme.redColor,
                    ),
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
                        width: 0.5, color: VariableUtilities.theme.color94A0C5),
                  ),
                  suffixIcon: widget.suffixIcon ?? const SizedBox(),
                  hoverColor: VariableUtilities.theme.color94A0C5),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
