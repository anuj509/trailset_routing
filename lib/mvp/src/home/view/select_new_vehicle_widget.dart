import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/selected_vehicle_view.dart';
import 'package:trailset_route_optimize/mvp/widgets/widgets.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

class SelectNewVehicleWidget extends StatelessWidget {
  const SelectNewVehicleWidget({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: 480,
            decoration: homeProvider.isSelectVehicleDropDownOpen
                ? BoxDecoration(
                    color: VariableUtilities.theme.whiteColor,
                    border:
                        Border.all(color: VariableUtilities.theme.primaryColor),
                    boxShadow: [
                      BoxShadow(
                          color: VariableUtilities.theme.color919191
                              .withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ],
                    borderRadius: BorderRadius.circular(5))
                : BoxDecoration(
                    color: VariableUtilities.theme.whiteColor,
                    border:
                        Border.all(color: VariableUtilities.theme.primaryColor),
                    borderRadius: BorderRadius.circular(3),
                  ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: homeProvider.isSelectVehicleDropDownOpen
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: homeProvider.isSelectVehicleDropDownOpen
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Select Vehicles',
                                  style: FontUtilities.h16(
                                      fontColor:
                                          VariableUtilities.theme.color292D32,
                                      fontWeight: FWT.semiBold),
                                ),
                              )
                            : homeProvider.selectedVehicleList.isEmpty
                                ? Text(
                                    'Vehicle is not selected',
                                    style: FontUtilities.h14(
                                      fontColor:
                                          VariableUtilities.theme.color292D32,
                                    ),
                                  )
                                : Wrap(
                                    spacing:
                                        8, // Adjust the spacing between containers
                                    alignment: WrapAlignment
                                        .start, // Align items to the start of the row
                                    children: List.generate(
                                        homeProvider.selectedVehicleList.length,
                                        (index) => SelectedVehicleView(
                                              jobModel: homeProvider
                                                  .selectedVehicleList[index],
                                              homeProvider: homeProvider,
                                            )),
                                  ),
                      ),
                      IconButton(
                          onPressed: () {
                            homeProvider.isSelectVehicleDropDownOpen =
                                !homeProvider.isSelectVehicleDropDownOpen;
                          },
                          icon: SvgPicture.asset(
                              homeProvider.isSelectVehicleDropDownOpen
                                  ? AssetUtils.upArrowSvgIcon
                                  : AssetUtils.downArrowSvgIcon,
                              height: 8,
                              width: 8))
                    ],
                  ),
                  homeProvider.isSelectVehicleDropDownOpen
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: homeProvider.vehicleList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          activeColor: VariableUtilities
                                              .theme.primaryColor,
                                          value: homeProvider.vehicleList[index]
                                              .isItemSelected,
                                          onChanged: (val) {
                                            homeProvider
                                                .makeItemSelectUnSelectInVehicleList(
                                                    id: homeProvider
                                                        .vehicleList[index].id);
                                            homeProvider
                                                .onCheckBoxSelectFromVehicleSelection(
                                                    jobModel: homeProvider
                                                        .vehicleList[index]);
                                          }),
                                      const SizedBox(width: 10),
                                      SvgPicture.asset(
                                          AssetUtils.smallTruckSvgIcon,
                                          height: 15,
                                          width: 15),
                                      const SizedBox(width: 10),
                                      Text(
                                        homeProvider
                                            .vehicleList[index].vehicleName,
                                        style: FontUtilities.h16(
                                          fontWeight: FWT.semiBold,
                                          fontColor: VariableUtilities
                                              .theme.blackColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        homeProvider
                                            .vehicleList[index].vehicleNo,
                                        style: FontUtilities.h14(
                                          fontColor: VariableUtilities
                                              .theme.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      IconButton(
                                          onPressed: () {
                                            homeProvider.decreaseItemQty(
                                                id: homeProvider
                                                    .vehicleList[index].id);
                                          },
                                          icon: Image.asset(
                                            AssetUtils.minusRoundPngIcon,
                                            height: 18,
                                            width: 18,
                                          )),
                                      Text(
                                        '${homeProvider.vehicleList[index].vehicleQty}',
                                        style: FontUtilities.h12(
                                            fontColor: VariableUtilities
                                                .theme.color333333),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            homeProvider.increaseItemQty(
                                                id: homeProvider
                                                    .vehicleList[index].id);
                                          },
                                          icon: Image.asset(
                                            AssetUtils.plusRoundPngIcon,
                                            height: 18,
                                            width: 18,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    runSpacing: 10,
                                    alignment: WrapAlignment.spaceBetween,
                                    runAlignment: WrapAlignment.spaceBetween,
                                    direction: Axis.horizontal,
                                    children: [
                                      homeProvider.vehicleList[index].vehicleNo
                                              .isEmpty
                                          ? const SizedBox()
                                          : Row(
                                              children: [
                                                JobDetailContainer(
                                                    height: 18,
                                                    width: 18,
                                                    containerName: 'Number',
                                                    suffixTitle: homeProvider
                                                        .vehicleList[index]
                                                        .vehicleNo,
                                                    isPng: true,
                                                    imageUrl: AssetUtils
                                                        .speedometerSvgIcon),
                                                const SizedBox(width: 20),
                                              ],
                                            ),
                                      JobDetailContainer(
                                          height: 18,
                                          width: 18,
                                          containerName: 'Height (mm)',
                                          count: homeProvider
                                              .vehicleList[index].height,
                                          suffixTitle: 'mm',
                                          isPng: true,
                                          imageUrl: AssetUtils.heightIcon),
                                      const SizedBox(width: 20),
                                      JobDetailContainer(
                                          height: 18,
                                          width: 18,
                                          containerName: 'Length (mm)',
                                          isPng: true,
                                          count: homeProvider
                                              .vehicleList[index].length,
                                          suffixTitle: 'mm',
                                          imageUrl: AssetUtils.lengthIcon),
                                      const SizedBox(width: 20),
                                      JobDetailContainer(
                                          containerName: 'Pay load',
                                          count: homeProvider
                                              .vehicleList[index].payload,
                                          suffixTitle: 'Kgs',
                                          imageUrl: AssetUtils.loadedSvgIcon),
                                      const SizedBox(width: 20),
                                      JobDetailContainer(
                                          containerName: 'Top Speed',
                                          count: homeProvider
                                              .vehicleList[index].topSpeed,
                                          suffixTitle: 'Km/h',
                                          imageUrl:
                                              AssetUtils.speedometerSvgIcon),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  (homeProvider.vehicleList.length - 1 == index)
                                      ? const SizedBox()
                                      : Divider(
                                          thickness: 0.2,
                                          height: 0.2,
                                          color: VariableUtilities
                                              .theme.color737B85)
                                ],
                              ),
                            );
                          })
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
