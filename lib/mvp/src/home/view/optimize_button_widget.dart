import 'package:flutter/material.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class OptimizeButtonWidget extends StatelessWidget {
  const OptimizeButtonWidget(
      {super.key, required this.homeProvider, required this.onTap});

  final HomeProvider homeProvider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              children: [
                Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: homeProvider.isOptimizeButtonEnabled
                        ? VariableUtilities.theme.primaryColor
                        : VariableUtilities.theme.primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5),
                          Image.asset(AssetUtils.optimizeIcon,
                              height: 18, width: 18),
                          const SizedBox(width: 5),
                          Text(
                            'Optimize',
                            style: FontUtilities.h14(
                                fontColor: VariableUtilities.theme.whiteColor,
                                fontWeight: FWT.semiBold),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
