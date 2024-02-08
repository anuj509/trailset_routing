import 'package:flutter/material.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

class RoutingSummaryWidget extends StatelessWidget {
  const RoutingSummaryWidget({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return homeProvider.optimizedRouteModel.summary != null
        ? Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 250,
                  height: 100,
                  decoration: BoxDecoration(
                      color: VariableUtilities.theme.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: VariableUtilities.theme.blackColor,
                            blurRadius: 4,
                            spreadRadius: -2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Trip Duration : ',
                              style: FontUtilities.h16(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.blackColor),
                            ),
                            Text(
                              formatSecondsToHoursAndMinutes(homeProvider
                                  .optimizedRouteModel.summary!.duration),
                              style: FontUtilities.h16(
                                  fontColor:
                                      VariableUtilities.theme.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Trip Distance : ',
                              style: FontUtilities.h16(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.blackColor),
                            ),
                            Text(
                              '${(homeProvider.optimizedRouteModel.summary!.distance / 1000).toStringAsFixed(2)} km/h',
                              style: FontUtilities.h16(
                                  fontColor:
                                      VariableUtilities.theme.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Computing  time : ',
                              style: FontUtilities.h16(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.blackColor),
                            ),
                            Text(
                              '${(homeProvider.optimizedRouteModel.summary!.computingTimes!.loading + homeProvider.optimizedRouteModel.summary!.computingTimes!.routing + homeProvider.optimizedRouteModel.summary!.computingTimes!.solving) / 1000} s',
                              style: FontUtilities.h16(
                                  fontColor:
                                      VariableUtilities.theme.blackColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          )
        : const SizedBox();
  }

  String formatSecondsToHoursAndMinutes(int seconds) {
    int hours = seconds ~/ 3600; // Get the whole hours
    int minutes = (seconds % 3600) ~/ 60; // Get the remaining minutes

    String formattedTime = '';
    if (hours > 0) {
      formattedTime += '$hours h ';
    }
    formattedTime += '$minutes min';

    return formattedTime;
  }
}
