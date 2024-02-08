import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class RoundTripWidget extends StatelessWidget {
  const RoundTripWidget({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
          decoration: BoxDecoration(
              color: VariableUtilities.theme.whiteColor,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: VariableUtilities.theme.colorC3C9D2)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AssetUtils.roundTripSvgIcon),
                    const SizedBox(width: 10),
                    Text(
                      'Round Trip',
                      style: FontUtilities.h16(
                          fontColor: VariableUtilities.theme.color292D32,
                          fontWeight: FWT.semiBold),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 0.75,
                  child: Switch(
                      activeTrackColor: VariableUtilities.theme.color42C05E,
                      inactiveThumbColor: VariableUtilities.theme.whiteColor,
                      thumbColor: MaterialStateProperty.all(
                          VariableUtilities.theme.whiteColor),
                      value: homeProvider.isRoundTripAvailable,
                      onChanged: (val) {
                        homeProvider.isRoundTripAvailable =
                            !homeProvider.isRoundTripAvailable;
                      }),
                )
              ],
            ),
          )),
    );
  }
}
