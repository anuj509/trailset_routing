import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trailset_route_optimize/utils/utils.dart';
import 'package:universal_html/html.dart' as html;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      width: VariableUtilities.screenSize.width,
      decoration: BoxDecoration(
        color: VariableUtilities.theme.whiteColor,
        boxShadow: [
          BoxShadow(
            color: VariableUtilities.theme.color777777,
            offset: const Offset(0, 1),
            blurRadius: 13,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AssetUtils.trailSetSvgLogo,
            ),
            InkWell(
              onTap: () {
                html.window.open(
                    'https://github.com/anuj509/trailset_routing/blob/main/README.md',
                    'Documentation');
              },
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border:
                        Border.all(color: VariableUtilities.theme.color737B85),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(AssetUtils.downloadTemplateSvgIcon),
                        const Icon(Icons.open_in_new),
                        const SizedBox(width: 10),
                        Text('Documentation',
                            style: FontUtilities.h16(
                                fontWeight: FWT.semiBold,
                                fontColor: VariableUtilities.theme.blackColor))
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(67);
}
