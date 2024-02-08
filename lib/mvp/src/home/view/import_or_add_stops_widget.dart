import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class ImportOrAddStopsWidget extends StatelessWidget {
  const ImportOrAddStopsWidget(
      {super.key,
      required this.onImportCallBack,
      required this.onAddStopCallBack,
      required this.homeProvider,
      required this.onTemplateCallBack});

  final VoidCallback onImportCallBack;
  final VoidCallback onAddStopCallBack;
  final VoidCallback onTemplateCallBack;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Row(
          children: [
            !homeProvider.isFileUploaded
                ? button(
                    backgroundColor: VariableUtilities.theme.color2F9947,
                    borderColor: Colors.transparent,
                    callBack: onImportCallBack,
                    svgIcon: AssetUtils.jsonObjectSvgIcon,
                    title: 'Import Jobs',
                    titleStyle: FontUtilities.h16(
                        fontWeight: FWT.semiBold,
                        fontColor: VariableUtilities.theme.whiteColor))
                : const SizedBox(),
            const SizedBox(width: 10),
            button(
                backgroundColor: VariableUtilities.theme.whiteColor,
                borderColor: VariableUtilities.theme.color737B85,
                callBack: onAddStopCallBack,
                svgIcon: AssetUtils.addStopsSvgIcon,
                title: 'Add Stop',
                titleStyle: FontUtilities.h16(
                    fontWeight: FWT.semiBold,
                    fontColor: VariableUtilities.theme.blackColor)),
            const SizedBox(width: 10),
            button(
                backgroundColor: VariableUtilities.theme.colorD0D3DF,
                borderColor: Colors.transparent,
                callBack: onTemplateCallBack,
                svgIcon: AssetUtils.downloadTemplateSvgIcon,
                title: 'Template',
                titleStyle: FontUtilities.h16(
                    fontWeight: FWT.semiBold,
                    fontColor: VariableUtilities.theme.blackColor)),
          ],
        ));
  }

  Widget button({
    required String title,
    required TextStyle titleStyle,
    required VoidCallback callBack,
    required Color backgroundColor,
    required Color borderColor,
    required String svgIcon,
  }) {
    return Expanded(
      child: InkWell(
        onTap: callBack,
        child: Container(
          height: 38,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: borderColor),
              color: backgroundColor),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(svgIcon),
                  const SizedBox(width: 10),
                  Text(title, style: titleStyle)
                ]),
          ),
        ),
      ),
    );
  }
}
