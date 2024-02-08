import 'package:flutter/material.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

class AssignedOrUnAssigned extends StatelessWidget {
  const AssignedOrUnAssigned({super.key, required this.homeProvider});
  final HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: VariableUtilities.screenSize.width,
      color: VariableUtilities.theme.whiteColor,
      height: 63,
      child: Row(
        children: List.generate(
            homeProvider.assignableTypeList.length,
            (index) => Expanded(
                  child: InkWell(
                    onTap: () {
                      homeProvider.selectedAssignableType =
                          homeProvider.assignableTypeList[index];
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: homeProvider.assignableTypeList[index] ==
                                homeProvider.selectedAssignableType
                            ? VariableUtilities.theme.colorE8E8E8
                            : VariableUtilities.theme.whiteColor,
                        border: Border(
                            top: BorderSide(
                                color: VariableUtilities.theme.colorC3C3C3),
                            bottom: BorderSide(
                                color: VariableUtilities.theme.colorC3C3C3)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${getCount(homeProvider: homeProvider, type: homeProvider.assignableTypeList[index])}',
                              style: FontUtilities.h20(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.color292D32),
                            ),
                            Text(
                              homeProvider.assignableTypeList[index],
                              style: FontUtilities.h16(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.color717273),
                            ),
                          ]),
                    ),
                  ),
                )),
      ),
    );
  }

  int getCount({required String type, required HomeProvider homeProvider}) {
    int count = 0;
    switch (type) {
      case 'Assigned':
        return homeProvider.assignedExcelModelList.length;

      case 'Un-Assigned':
        return homeProvider.uploadedExcelModelList.length;

      case 'Total':
        return homeProvider.uploadedExcelToOptimizeMarkerList.length;

      default:
    }
    return count;
  }
}
