import 'package:flutter/material.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

class HomeScreenHeaderView extends StatelessWidget {
  const HomeScreenHeaderView(
      {super.key, required this.onTap, this.isOptimizeButtonEnabled = false});
  final VoidCallback onTap;
  final bool? isOptimizeButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Routing',
            style: FontUtilities.h18(
                fontColor: VariableUtilities.theme.color292D32,
                fontWeight: FWT.bold),
          ),

          ///If we want to enable optimize button
          ///simple uncomment this code
          // InkWell(
          //   onTap: onTap,
          //   child: Stack(
          //     children: [
          //       Container(
          //         height: 30,
          //         width: 100,
          //         decoration: BoxDecoration(
          //           color: VariableUtilities.theme.primaryColor,
          //           borderRadius: BorderRadius.circular(3),
          //         ),
          //         child: SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Center(
          //             child: Row(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   const SizedBox(width: 5),
          //                   Image.asset(AssetUtils.optimizeIcon,
          //                       height: 18, width: 18),
          //                   const SizedBox(width: 5),
          //                   Text(
          //                     'Optimize',
          //                     style: FontUtilities.h14(
          //                         fontColor: VariableUtilities.theme.whiteColor,
          //                         fontWeight: FWT.semiBold),
          //                   )
          //                 ]),
          //           ),
          //         ),
          //       ),
          //       isOptimizeButtonEnabled!
          //           ? const SizedBox()
          //           : Container(
          //               height: 30,
          //               width: 100,
          //               decoration: BoxDecoration(
          //                 color: VariableUtilities.theme.whiteColor
          //                     .withOpacity(0.4),
          //                 borderRadius: BorderRadius.circular(3),
          //               ),
          //             ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
