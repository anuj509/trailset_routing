import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/open_time_picker.dart';
import 'package:trailset_route_optimize/mvp/widgets/widgets.dart';
import 'package:trailset_route_optimize/utils/utils.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class SelectedVehicleWithStops extends StatefulWidget {
  const SelectedVehicleWithStops({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  State<SelectedVehicleWithStops> createState() =>
      _SelectedVehicleWithStopsState();
}

class _SelectedVehicleWithStopsState extends State<SelectedVehicleWithStops> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.builder(
          itemCount: widget.homeProvider.selectedJobList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: VariableUtilities.theme.whiteColor,
                    borderRadius: BorderRadius.circular(3),
                    border:
                        Border.all(color: VariableUtilities.theme.colorDFDFDF)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                  activeTrackColor: widget.homeProvider
                                      .selectedJobList[index].color,
                                  activeColor:
                                      VariableUtilities.theme.whiteColor,
                                  value: widget.homeProvider
                                      .selectedJobList[index].isJobActivated,
                                  onChanged: (val) {
                                    widget.homeProvider
                                        .makeSwitchOnOrOff(index: index);
                                  }),
                            ),
                            Text(
                              widget.homeProvider.selectedJobList[index]
                                  .vehicleName,
                              style: FontUtilities.h14(
                                  fontColor:
                                      VariableUtilities.theme.color292D32,
                                  fontWeight: FWT.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialogForUpdate(
                                      cargoEndTime: DateFormat('h:mm a').format(
                                          widget.homeProvider
                                              .selectedJobList[index].endTime),
                                      cargoHeight:
                                          '${widget.homeProvider.selectedJobList[index].height}',
                                      cargoId:
                                          '${widget.homeProvider.selectedJobList[index].id}',
                                      cargoLength:
                                          '${widget.homeProvider.selectedJobList[index].length}',
                                      cargoName: widget.homeProvider
                                          .selectedJobList[index].vehicleName,
                                      cargoNo: widget.homeProvider
                                          .selectedJobList[index].vehicleNo,
                                      cargoPayload:
                                          '${widget.homeProvider.selectedJobList[index].payload}',
                                      cargoStartTime: DateFormat('h:mm a')
                                          .format(widget
                                              .homeProvider
                                              .selectedJobList[index]
                                              .startTime),
                                      cargoStops:
                                          '${widget.homeProvider.selectedJobList[index].stops}',
                                      cargoTopSpeed:
                                          '${widget.homeProvider.selectedJobList[index].topSpeed}',
                                      index: index,
                                      isUpdate: true,
                                      context: context,
                                      homeProvider: widget.homeProvider);
                                },
                                icon: SvgPicture.asset(AssetUtils.editSvgIcon))
                          ],
                        ),
                        Row(
                          children: [
                            // Text(
                            //   widget.homeProvider.selectedJobList[index]
                            //       .vehicleNo,
                            //   style: FontUtilities.h14(
                            //       fontColor:
                            //           VariableUtilities.theme.color737B85,
                            //       fontWeight: FWT.semiBold),
                            // ),
                            // const SizedBox(width: 5),
                            Text(
                              '${widget.homeProvider.selectedJobList[index].stops} Stops',
                              style: FontUtilities.h14(
                                  fontColor: VariableUtilities.theme.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                  widget.homeProvider.selectedJobList[index]
                                          .isDropDownMenuOpen
                                      ? AssetUtils.upArrowSvgIcon
                                      : AssetUtils.downArrowSvgIcon,
                                  height: 8,
                                  width: 8),
                              onPressed: () {
                                widget.homeProvider
                                    .makeDropDownMenuOpenOrCloseInJobList(
                                        // id : homeProvider
                                        //     .selectedJobList[
                                        //         index]
                                        //     .vehicleName,
                                        index: index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Wrap(
                        runSpacing: 20,
                        direction: Axis.horizontal,
                        children: [
                          widget.homeProvider.selectedJobList[index].vehicleNo
                                  .isEmpty
                              ? const SizedBox()
                              : JobDetailContainer(
                                  containerName: 'Number',
                                  suffixTitle: widget.homeProvider
                                      .selectedJobList[index].vehicleNo,
                                  height: 18,
                                  width: 18,
                                  isPng: false,
                                  imageUrl: AssetUtils.speedometerSvgIcon),
                          JobDetailContainer(
                              containerName: 'Height (mm)',
                              count: widget
                                  .homeProvider.selectedJobList[index].height,
                              suffixTitle: 'mm',
                              height: 18,
                              width: 18,
                              isPng: true,
                              imageUrl: AssetUtils.heightIcon),
                          JobDetailContainer(
                              containerName: 'Length (mm)',
                              count: widget
                                  .homeProvider.selectedJobList[index].length,
                              suffixTitle: 'mm',
                              height: 18,
                              width: 18,
                              isPng: true,
                              imageUrl: AssetUtils.lengthIcon),
                          JobDetailContainer(
                              containerName: 'Pay load',
                              count: widget
                                  .homeProvider.selectedJobList[index].payload,
                              suffixTitle: 'Kgs',
                              imageUrl: AssetUtils.loadedSvgIcon),
                          JobDetailContainer(
                              containerName: 'Top Speed',
                              count: widget
                                  .homeProvider.selectedJobList[index].topSpeed,
                              suffixTitle: 'Km/h',
                              imageUrl: AssetUtils.speedometerSvgIcon),
                        ],
                      ),
                    ),
                    (widget.homeProvider.selectedJobList[index]
                                .dropLocationNameList.isNotEmpty &&
                            widget.homeProvider.selectedJobList[index]
                                .isDropDownMenuOpen)
                        ? Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Divider(),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget
                                      .homeProvider
                                      .selectedJobList[index]
                                      .dropLocationNameList
                                      .length,
                                  itemBuilder: (context, insideI) {
                                    return (widget
                                                    .homeProvider
                                                    .selectedJobList[index]
                                                    .dropLocationNameList[
                                                        insideI]
                                                    .type ==
                                                "start" ||
                                            widget
                                                    .homeProvider
                                                    .selectedJobList[index]
                                                    .dropLocationNameList[
                                                        insideI]
                                                    .type ==
                                                "end")
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 10.0),
                                            child: InkWell(
                                              onTap: () {
                                                widget
                                                    .homeProvider.mapController!
                                                    .move(
                                                        LatLng(
                                                          widget
                                                              .homeProvider
                                                              .selectedJobList[
                                                                  index]
                                                              .dropLocationNameList[
                                                                  insideI]
                                                              .location[1],
                                                          widget
                                                              .homeProvider
                                                              .selectedJobList[
                                                                  index]
                                                              .dropLocationNameList[
                                                                  insideI]
                                                              .location[0],
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
                                                              AssetUtils
                                                                  .greenMapSvgIcon,
                                                              height: 35,
                                                              width: 35,
                                                              color: widget
                                                                  .homeProvider
                                                                  .selectedJobList[
                                                                      index]
                                                                  .color),
                                                        ),
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 5.0,
                                                                    right: 1.0),
                                                            child: Text(
                                                              '$insideI',
                                                              style: FontUtilities.h12(
                                                                  fontWeight: FWT
                                                                      .semiBold,
                                                                  fontColor:
                                                                      VariableUtilities
                                                                          .theme
                                                                          .whiteColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      widget
                                                              .homeProvider
                                                              .selectedJobList[
                                                                  index]
                                                              .dropLocationNameList[
                                                                  insideI]
                                                              .description ??
                                                          '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontUtilities.h16(
                                                          fontColor:
                                                              VariableUtilities
                                                                  .theme
                                                                  .color292D32),
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('h:mm a').format(
                                                        DateTime.fromMillisecondsSinceEpoch(
                                                                int.parse(
                                                                    '${widget.homeProvider.selectedJobList[index].dropLocationNameList[insideI].arrival}000'))
                                                            .toLocal()
                                                            .toLocal()),
                                                    // Text(
                                                    //   truckReachDurationTmeInHoursAndMinutes(widget
                                                    //       .homeProvider
                                                    //       .selectedJobList[index]
                                                    //       .startTime
                                                    //       .add(Duration(
                                                    //           minutes: (widget
                                                    //                       .homeProvider
                                                    //                       .selectedJobList[
                                                    //                           index]
                                                    //                       .dropLocationNameList[
                                                    //                           insideI]
                                                    //                       .totalTravelDuration /
                                                    //                   60)
                                                    //               .ceil()))),
                                                    //  ' ${ homeProvider.selectedJobList[index].startTime.add(Duration(minutes: homeProvider.selectedJobList[index].dropLocationNameList[insideI].duration ~/ 60))}',
                                                    style: FontUtilities.h12(
                                                        fontColor:
                                                            VariableUtilities
                                                                .theme
                                                                .color737B85),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                  }),
                            ],
                          )
                        : const SizedBox()
                  ]),
                ),
              ),
            );
          }),
    );
  }

  String truckReachDurationTmeInHoursAndMinutes(DateTime date) {
    return DateFormat('h:mm a').format(
        DateTime(date.year, date.month, date.day, date.hour, date.minute));
  }
}

void showDialogForUpdate({
  required BuildContext context,
  required HomeProvider homeProvider,
  bool isUpdate = false,
  int index = 0,
  required String cargoId,
  required String cargoStops,
  required String cargoName,
  required String cargoNo,
  required String cargoHeight,
  required String cargoLength,
  required String cargoPayload,
  required String cargoTopSpeed,
  required String cargoStartTime,
  required String cargoEndTime,
}) {
  TextEditingController cargoIdController =
      TextEditingController(text: cargoId);

  TextEditingController cargoStopsController =
      TextEditingController(text: cargoStops);

  TextEditingController cargoNameController =
      TextEditingController(text: cargoName);

  TextEditingController cargoNoController =
      TextEditingController(text: cargoNo);

  TextEditingController cargoHeightController =
      TextEditingController(text: cargoHeight);

  TextEditingController cargoLengthController =
      TextEditingController(text: cargoLength);

  TextEditingController cargoPayloadController =
      TextEditingController(text: cargoPayload);

  TextEditingController cargoTopSpeedController =
      TextEditingController(text: cargoTopSpeed);

  TextEditingController cargoStartTimeController = TextEditingController(
      text: cargoStartTime.isNotEmpty
          ? cargoStartTime
          : DateFormat('h:mm a').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              9,
              0,
            )));

  TextEditingController cargoEndTimeController = TextEditingController(
      text: cargoEndTime.isNotEmpty
          ? cargoEndTime
          : DateFormat('h:mm a').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              0,
              0,
            )));
  TimeOfDay? startTimeOfVehicle;
  TimeOfDay? endTimeOfVehicle;

  String height = '0';

  String length = '0';

  String payload = '0';

  final formKey = GlobalKey<FormState>();
  height =
      cargoHeightController.text.isEmpty ? '0' : cargoHeightController.text;
  length =
      cargoLengthController.text.isEmpty ? '0' : cargoLengthController.text;
  payload =
      cargoPayloadController.text.isEmpty ? '0' : cargoPayloadController.text;
  showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: SingleChildScrollView(
              child: PointerInterceptor(
                child: StatefulBuilder(builder: (_, state) {
                  return Container(
                    height: VariableUtilities.screenSize.height,
                    width: VariableUtilities.screenSize.width,
                    color: VariableUtilities.theme.blackColor.withOpacity(.2),
                    child: Align(
                      alignment: Alignment.center,
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 800),
                                width: 778,
                                decoration: BoxDecoration(
                                    color: VariableUtilities.theme.whiteColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Custom Truck',
                                              style: FontUtilities.h18(
                                                  fontWeight: FWT.bold,
                                                  fontColor: VariableUtilities
                                                      .theme.color292D32),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: SvgPicture.asset(
                                                  AssetUtils.cancelSvgIcon,
                                                  height: 20,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  HorizontalInputField(
                                                    style: FontUtilities.h16(
                                                        fontColor:
                                                            VariableUtilities
                                                                .theme
                                                                .color292D32),
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: SvgPicture.asset(
                                                        AssetUtils
                                                            .smallTruckSvgIcon,
                                                        height: 22,
                                                        width: 22,
                                                      ),
                                                    ),
                                                    controller:
                                                        cargoNameController,
                                                    label: 'Cargo Name:',
                                                    hintText:
                                                        'Enter Cargo Name',
                                                    validator: (name) {
                                                      if (name!.isEmpty) {
                                                        return 'Please Enter Name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 14),
                                                  HorizontalInputField(
                                                    controller:
                                                        cargoNoController,
                                                    label: 'Cargo No:',
                                                    hintText: 'Enter Cargo No',
                                                    validator: (name) {
                                                      // if (name!.isEmpty) {
                                                      //   return 'Please Enter No';
                                                      // }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 14),
                                                  HorizontalInputField(
                                                    onChanged: (val) {
                                                      state(() {
                                                        height = val;
                                                      });
                                                    },
                                                    controller:
                                                        cargoHeightController,
                                                    label: 'Cargo height (mm):',
                                                    hintText:
                                                        'Enter Cargo Height',
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp(r'^\d+$')),
                                                    ],
                                                    validator: (name) {
                                                      final RegExp
                                                          digitOnlyRegex =
                                                          RegExp(r'^[0-9]+$');

                                                      if (!digitOnlyRegex
                                                          .hasMatch(name!)) {
                                                        return 'Field only contain digits';
                                                      }

                                                      if (name.isEmpty) {
                                                        return 'Please Enter Height';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 14),
                                                  HorizontalInputField(
                                                    onChanged: (val) {
                                                      state(() {
                                                        length = val;
                                                      });
                                                    },
                                                    controller:
                                                        cargoLengthController,
                                                    label: 'Cargo Length (mm):',
                                                    hintText:
                                                        'Enter Cargo Length',
                                                    validator: (name) {
                                                      final RegExp
                                                          digitOnlyRegex =
                                                          RegExp(r'^[0-9]+$');

                                                      if (!digitOnlyRegex
                                                          .hasMatch(name!)) {
                                                        return 'Field only contain digits';
                                                      }
                                                      if (name.isEmpty) {
                                                        return 'Please Enter Length';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 14),
                                                  HorizontalInputField(
                                                    onChanged: (val) {
                                                      state(() {
                                                        payload = val;
                                                      });
                                                    },
                                                    controller:
                                                        cargoPayloadController,
                                                    label: 'Pay Load (kgs):',
                                                    hintText: 'Enter Pay Load',
                                                    validator: (name) {
                                                      final RegExp
                                                          digitOnlyRegex =
                                                          RegExp(r'^[0-9]+$');

                                                      if (!digitOnlyRegex
                                                          .hasMatch(name!)) {
                                                        return 'Field only contain digits';
                                                      }
                                                      if (name.isEmpty) {
                                                        return 'Please Enter Payload';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 14),
                                                  HorizontalInputField(
                                                    controller:
                                                        cargoTopSpeedController,
                                                    label: 'Top Speed (km/h):',
                                                    hintText: 'Enter Top Speed',
                                                    validator: (name) {
                                                      final RegExp
                                                          digitOnlyRegex =
                                                          RegExp(r'^[0-9]+$');

                                                      if (!digitOnlyRegex
                                                          .hasMatch(name!)) {
                                                        return 'Field only contain digits';
                                                      }
                                                      if (name.isEmpty) {
                                                        return 'Please Enter TopSpeed';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 28),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HorizontalInputField(
                                                    readOnly: true,
                                                    onTap: () async {
                                                      TimeOfDay? timeOfDay =
                                                          await openTimePicker(
                                                              context);

                                                      if (timeOfDay != null) {
                                                        startTimeOfVehicle =
                                                            timeOfDay;
                                                        cargoStartTimeController
                                                                .text =
                                                            '${timeOfDay.hour}:${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}';
                                                      } else {
                                                        showToast(
                                                            title:
                                                                "Please Select Time First");
                                                      }
                                                    },
                                                    controller:
                                                        cargoStartTimeController,
                                                    label: 'Start Time:',
                                                    hintText:
                                                        'Enter Start Time',
                                                    validator: (name) {
                                                      if (name!.isEmpty) {
                                                        return 'Please Enter start Time';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 14),
                                                  HorizontalInputField(
                                                    onTap: () async {
                                                      TimeOfDay? timeOfDay =
                                                          await openTimePicker(
                                                              context);

                                                      if (timeOfDay != null) {
                                                        endTimeOfVehicle =
                                                            timeOfDay;
                                                        cargoEndTimeController
                                                                .text =
                                                            '${timeOfDay.hour}:${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}';
                                                      } else {
                                                        showToast(
                                                            title:
                                                                "Please Select Time First");
                                                      }
                                                    },
                                                    readOnly: true,
                                                    controller:
                                                        cargoEndTimeController,
                                                    label: 'End Time:',
                                                    hintText: 'Enter End Time',
                                                    validator: (name) {
                                                      if (name!.isEmpty) {
                                                        return 'Please Enter End Time';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 60),
                                                  SizedBox(
                                                      height: 150,
                                                      width: 361,
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 260,
                                                                  width: 260,
                                                                  child: Stack(
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        AssetUtils
                                                                            .addTruckImagePngIcon,
                                                                        width:
                                                                            260,
                                                                        height:
                                                                            260,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              150,
                                                                          top:
                                                                              50,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '${payload}Kgs',
                                                                          style:
                                                                              FontUtilities.h14(fontColor: VariableUtilities.theme.whiteColor),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top:
                                                                            -20,
                                                                        left:
                                                                            50,
                                                                        right:
                                                                            0,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            '${length}mm',
                                                                            style:
                                                                                FontUtilities.h14(fontColor: VariableUtilities.theme.primaryColor),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          50.0),
                                                                  child: Text(
                                                                      '${height}mm',
                                                                      style: FontUtilities.h14(
                                                                          fontColor: VariableUtilities
                                                                              .theme
                                                                              .primaryColor),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            PrimaryButton(
                                                width: 150,
                                                onTap: () {
                                                  // homeProvider
                                                  //         .isCustomTruckDialogOpen =
                                                  //     false;
                                                  Navigator.pop(context);
                                                },
                                                title: 'Cancel',
                                                titleColor: VariableUtilities
                                                    .theme.blackColor,
                                                color: Colors.transparent),
                                            const SizedBox(width: 10),
                                            PrimaryButton(
                                              borderColor: Colors.transparent,
                                              width: 150,
                                              onTap: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  String cargoNo =
                                                      cargoNoController.text;
                                                  if (cargoNo.isNotEmpty) {
                                                    bool cargoNumberExists =
                                                        await homeProvider
                                                            .isCargoNoExists(
                                                                isUpdate:
                                                                    isUpdate,
                                                                cargoNo:
                                                                    cargoNo,
                                                                index: index);
                                                    if (cargoNumberExists) {
                                                      showToast(
                                                          title:
                                                              "Cargo Number is already exists");
                                                      return;
                                                    }
                                                  }
                                                  if (isUpdate) {
                                                    homeProvider.updateItemToVehicleList(
                                                        vehicleId: homeProvider
                                                            .selectedJobList[
                                                                index]
                                                            .vehicleId,
                                                        index: index,
                                                        endTime:
                                                            endTimeOfVehicle,
                                                        startTime:
                                                            startTimeOfVehicle,
                                                        cargoStops:
                                                            cargoStopsController
                                                                .text,
                                                        id: cargoIdController
                                                            .text,
                                                        cargoNo:
                                                            cargoNoController
                                                                .text,
                                                        cargoName:
                                                            cargoNameController
                                                                .text,
                                                        cargoLength:
                                                            cargoLengthController
                                                                .text,
                                                        cargoHeight:
                                                            cargoHeightController
                                                                .text,
                                                        cargoPayload:
                                                            cargoPayloadController
                                                                .text,
                                                        cargoTopSpeed:
                                                            cargoTopSpeedController
                                                                .text);
                                                  } else {
                                                    homeProvider.addItemToVehicleList(
                                                        endTime:
                                                            endTimeOfVehicle,
                                                        startTime:
                                                            startTimeOfVehicle,
                                                        cargoNo:
                                                            cargoNoController
                                                                .text,
                                                        cargoName:
                                                            cargoNameController
                                                                .text,
                                                        cargoLength:
                                                            cargoLengthController
                                                                .text,
                                                        cargoHeight:
                                                            cargoHeightController
                                                                .text,
                                                        cargoPayload:
                                                            cargoPayloadController
                                                                .text,
                                                        cargoTopSpeed:
                                                            cargoTopSpeedController
                                                                .text);
                                                  }
                                                  // homeProvider
                                                  //         .isCustomTruckDialogOpen =
                                                  //     false;
                                                  Navigator.pop(context);
                                                }
                                              },
                                              title:
                                                  isUpdate ? 'Update' : 'Save',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      });
}
