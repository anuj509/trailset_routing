import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

class UploadedExcelPointsListWidget extends StatelessWidget {
  const UploadedExcelPointsListWidget({super.key, required this.homeProvider});

  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return homeProvider.uploadedExcelToOptimizeMarkerList.isEmpty
        ? const SizedBox()
        : homeProvider.selectedAssignableType == "Total"
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: VariableUtilities.theme.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: VariableUtilities.theme.colorDFDFDF),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          homeProvider.uploadedExcelToOptimizeMarkerList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: InkWell(
                            onTap: () {
                              homeProvider.mapController!.move(
                                  LatLng(
                                    homeProvider
                                        .uploadedExcelToOptimizeMarkerList[
                                            index]
                                        .lat,
                                    homeProvider
                                        .uploadedExcelToOptimizeMarkerList[
                                            index]
                                        .lng,
                                  ),
                                  18);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                            AssetUtils.greenMapSvgIcon,
                                            height: 35,
                                            width: 35,
                                            colorFilter: ColorFilter.mode(
                                                VariableUtilities
                                                    .theme.primaryColor,
                                                BlendMode.srcATop)),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0, right: 1.0),
                                          child: Text(
                                            '${index + 1}',
                                            style: FontUtilities.h12(
                                                fontWeight: FWT.semiBold,
                                                fontColor: VariableUtilities
                                                    .theme.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    homeProvider
                                        .uploadedExcelToOptimizeMarkerList[
                                            index]
                                        .name,
                                    maxLines: 2,
                                    style: FontUtilities.h16(
                                        fontColor: VariableUtilities
                                            .theme.color292D32),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            : const SizedBox();
  }
}
