import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trailset_route_optimize/utils/utils.dart';
import 'package:universal_html/html.dart' as html;

class DownloadTemplateView extends StatefulWidget {
  const DownloadTemplateView({super.key});

  @override
  State<DownloadTemplateView> createState() => _DownloadTemplateViewState();
}

class _DownloadTemplateViewState extends State<DownloadTemplateView> {
  bool isSampleData = false;
  bool isSampleStandard = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: VariableUtilities.screenSize.height,
      width: VariableUtilities.screenSize.width,
      child: Material(
        color: Colors.transparent,
        child: StatefulBuilder(builder: (_, state) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                  width: 454,
                  height: 342,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Download templates',
                                style: FontUtilities.h18(
                                    fontWeight: FWT.bold,
                                    fontColor:
                                        VariableUtilities.theme.color292D32)),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: VariableUtilities.theme.color737B85,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  isSampleData = false;
                                  isSampleStandard = true;
                                  state(() {});
                                },
                                child: Container(
                                    height: 148,
                                    width: 194,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color: isSampleStandard
                                                ? VariableUtilities
                                                    .theme.color0F41FC
                                                : Colors.transparent),
                                        color: isSampleStandard
                                            ? Colors.transparent
                                            : VariableUtilities
                                                .theme.colorF3F5FE),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AssetUtils.sampleStandardIcon,
                                          height: 103,
                                          width: 125,
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Sample Standard\n template',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: FontUtilities.h16(
                                    fontWeight: FWT.semiBold,
                                    fontColor:
                                        VariableUtilities.theme.color292D32),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  isSampleData = true;
                                  isSampleStandard = false;
                                  state(() {});
                                },
                                child: Container(
                                    height: 148,
                                    width: 194,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color: isSampleData
                                                ? VariableUtilities
                                                    .theme.color0F41FC
                                                : Colors.transparent),
                                        color: isSampleData
                                            ? Colors.transparent
                                            : VariableUtilities
                                                .theme.colorF3F5FE),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AssetUtils.sampleDataIcon,
                                          height: 103,
                                          width: 125,
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Download Sample\nData',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: FontUtilities.h16(
                                    fontWeight: FWT.semiBold,
                                    fontColor:
                                        VariableUtilities.theme.color292D32),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          if (isSampleData || isSampleStandard) {
                            String assetPath =
                                '${kDebugMode ? '' : 'assets/'}assets/xlsx/${isSampleData ? 'trailset_sample_data' : 'trailset_standard_template'}.xlsx'; // Adjust the path to match your asset
                            final anchor = html.AnchorElement(href: assetPath)
                              ..setAttribute('download',
                                  '${isSampleData ? 'trailset_sample_data' : 'trailset_standard_template'}.xlsx'); // Specify the filename
                            anchor.click();
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 38,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: (isSampleData || isSampleStandard)
                                  ? VariableUtilities.theme.primaryColor
                                  : VariableUtilities.theme.primaryColor
                                      .withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      AssetUtils.downloadTemplateSvgIcon,
                                      colorFilter: ColorFilter.mode(
                                          VariableUtilities.theme.whiteColor,
                                          BlendMode.srcATop)),
                                  const SizedBox(width: 10),
                                  Text('Download',
                                      style: FontUtilities.h16(
                                          fontWeight: FWT.semiBold,
                                          fontColor: VariableUtilities
                                              .theme.colorF7F9FB))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }),
      ),
    );
  }
}
