import 'package:flutter/material.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

///Primary button
class PrimaryButton extends StatelessWidget {
  ///Constructor Primary button

  const PrimaryButton({
    required this.onTap,
    required this.title,
    this.height,
    this.width,
    this.centerWidget,
    this.color,
    this.titleColor,
    this.borderColor,
    this.textStyle,
    this.borderRadius,
    this.titleImage,
    Key? key,
  }) : super(key: key);

  ///call back for button
  final VoidCallback onTap;

  ///Button height
  final double? height;

  ///Button width
  final double? width;

  ///Button color
  final Color? color;

  ///Button title color
  final Color? titleColor;

  ///Button Border color
  final Color? borderColor;

  ///Button title
  final String title;

  ///Button title
  final Widget? titleImage;

  ///Text style
  final TextStyle? textStyle;

  final Widget? centerWidget;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 45,
        width: width ?? 222,
        decoration: BoxDecoration(
            color: color ?? VariableUtilities.theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            border: Border.all(
                color: borderColor ?? VariableUtilities.theme.color737B85,
                width: 0)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleImage ?? const SizedBox(),
              titleImage != null ? const SizedBox(width: 10) : const SizedBox(),
              centerWidget ??
                  Text(
                    title,
                    style: textStyle ??
                        FontUtilities.h18(
                            fontColor: titleColor ??
                                VariableUtilities.theme.whiteColor,
                            fontWeight: FWT.semiBold),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
