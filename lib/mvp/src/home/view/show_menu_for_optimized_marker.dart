import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:parsel_web_optimize/mvp/src/home/model/json_uploaded_model.dart';
import 'package:parsel_web_optimize/mvp/src/home/model/open_source_place_response.dart';
import 'package:parsel_web_optimize/mvp/src/home/model/optimized_route_model.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/open_time_picker.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/pop_up_menu.dart';
import 'package:parsel_web_optimize/mvp/widgets/pop_up/pop_up_shape.dart';
import 'package:parsel_web_optimize/mvp/widgets/widgets.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

// showMenuForOptimizedMarker({
//   required HomeProvider homeProvider,
//   required BuildContext context,
//   required TapDownDetails details,
//   required RouteStep routeStep,
//   required int selectedJobIndex,
//   required int dropLocationIndex,
//   required Color color,
// }) {
//   showMenuForParsel(
//     color: Colors.transparent,
//     shadowColor: Colors.transparent,
//     context: context,
//     position: RelativeRect.fromRect(
//         Offset(details.globalPosition.dx - 285,
//                 details.globalPosition.dy - 300) &
//             const Size(15, 15), // smaller rect, the touch area
//         Offset.zero & const Size.fromHeight(0)),
//     item: );
// }

class OptimizedMarkerDialog extends StatefulWidget {
  const OptimizedMarkerDialog(
      {super.key,
      required this.homeProvider,
      required this.routeStep,
      required this.selectedJobIndex,
      required this.dropLocationIndex,
      required this.color,
      required this.callBack});

  @override
  State<OptimizedMarkerDialog> createState() => _OptimizedMarkerDialogState();
  final HomeProvider homeProvider;

  final RouteStep routeStep;
  final int selectedJobIndex;
  final int dropLocationIndex;
  final Color color;
  final VoidCallback callBack;
}

class _OptimizedMarkerDialogState extends State<OptimizedMarkerDialog> {
  TextEditingController serviceTimeController = TextEditingController();

  TextEditingController priorityController = TextEditingController();

  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();
  Timer? _debounceTimerForLocationName;
  Timer? _debounceTimerForLat;
  Timer? _debounceTimerForLong;
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();

  @override
  void initState() {
    serviceTimeController =
        TextEditingController(text: '${widget.routeStep.serviceTime}');
    priorityController =
        TextEditingController(text: '${widget.routeStep.priority}');
    locationNameController =
        TextEditingController(text: '${widget.routeStep.description}');
    latController =
        TextEditingController(text: '${widget.routeStep.location[1]}');
    longController =
        TextEditingController(text: '${widget.routeStep.location[0]}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return SingleChildScrollView(
        child: PopupShapes(
            position: PopupArrowPosition.BottomCenter,
            bgColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Job ${widget.dropLocationIndex}',
                            style: FontUtilities.h14(
                                fontWeight: FWT.semiBold,
                                fontColor:
                                    VariableUtilities.theme.color737B85)),
                        InkWell(
                          onTap: () {
                            // Navigator.pop(context);
                            widget.callBack();
                          },
                          child: SvgPicture.asset(AssetUtils.cancelSvgIcon),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(widget.routeStep.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontUtilities.h14(
                            fontWeight: FWT.semiBold, fontColor: widget.color)),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: TextField(
                        // onEditingComplete: ,
                        controller: locationNameController,
                        onChanged: (val) async {
                          print(val.isNotEmpty && val.length > 3);
                          if (val.isNotEmpty && val.length > 3) {
                            _debounceTimerForLocationName?.cancel();
                            // if (widget.isNewRecord) {
                            _debounceTimerForLocationName = Timer(
                                const Duration(milliseconds: 1500), () async {
                              await widget.homeProvider
                                  .searchOnChanged(searchText: val);
                              state(() {});
                            });
                            // }
                          }
                          state(() {});
                        },
                        decoration: InputDecoration(
                            hintText: 'Search your location here...',
                            hintStyle: FontUtilities.h16(
                                fontColor: VariableUtilities.theme.color6F6E6E),
                            prefixIcon: Icon(
                              Icons.search,
                              color: VariableUtilities.theme.color737B85,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            filled: true,
                            fillColor: VariableUtilities.theme.colorEFEFEF),
                      ),
                    ),
                    widget.homeProvider.searchOpenStreetPlaceResponseList
                            .isEmpty
                        ? const SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                color: VariableUtilities.theme.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: VariableUtilities.theme.blackColor
                                        .withOpacity(0.15),
                                    offset: const Offset(0, 2),
                                    blurRadius: 6,
                                  )
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.homeProvider
                                      .searchOpenStreetPlaceResponseList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        OpenStreetPlaceResponse
                                            openStreetPlaceResponse = widget
                                                    .homeProvider
                                                    .searchOpenStreetPlaceResponseList[
                                                index];
                                        locationNameController =
                                            TextEditingController(
                                                text: openStreetPlaceResponse
                                                    .displayName);
                                        latController = TextEditingController(
                                            text: openStreetPlaceResponse.lat);
                                        longController = TextEditingController(
                                            text: openStreetPlaceResponse.lon);
                                        widget.homeProvider
                                            .searchOpenStreetPlaceResponseList = [];
                                        state(() {});
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget
                                                      .homeProvider
                                                      .searchOpenStreetPlaceResponseList[
                                                          index]
                                                      .displayName
                                                      .split(",")
                                                      .first,
                                                  style: FontUtilities.h16(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .color292D32),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  widget
                                                      .homeProvider
                                                      .searchOpenStreetPlaceResponseList[
                                                          index]
                                                      .displayName,
                                                  style: FontUtilities.h14(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .color6F6E6E),
                                                ),
                                              ],
                                            ),
                                          ),
                                          (((widget
                                                              .homeProvider
                                                              .searchOpenStreetPlaceResponseList
                                                              .length -
                                                          1) ==
                                                      index) ||
                                                  (index == 0 &&
                                                      widget
                                                              .homeProvider
                                                              .searchOpenStreetPlaceResponseList
                                                              .length ==
                                                          1))
                                              ? const SizedBox()
                                              : Divider(
                                                  color: VariableUtilities
                                                      .theme.colorB1B1B1,
                                                ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lat',
                            style: FontUtilities.h14(
                                fontColor:
                                    VariableUtilities.theme.color737B85)),
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: TextField(
                            controller: latController,
                            onChanged: (val) {
                              String latLng = '$val,${longController.text}';
                              bool isLatLngValidate = isValidLatLong(latLng);
                              _debounceTimerForLat?.cancel();
                              print("isLatValid ==> $isLatLngValidate");

                              if (isLatLngValidate) {
                                _debounceTimerForLat =
                                    Timer(const Duration(milliseconds: 1500),
                                        () async {
                                  OpenStreetPlaceResponse?
                                      openStreetPlaceResponse = await widget
                                          .homeProvider
                                          .fetchLocationNameFromLatLong(LatLng(
                                              double.parse(val),
                                              double.parse(
                                                  longController.text)));
                                  if (openStreetPlaceResponse != null) {
                                    print(
                                        'openStreetPlaceResponse --> ${openStreetPlaceResponse.toJson()}');
                                    locationNameController =
                                        TextEditingController(
                                            text: openStreetPlaceResponse
                                                .displayName);

                                    latController = TextEditingController(
                                        text: openStreetPlaceResponse.lat);
                                    longController = TextEditingController(
                                        text: openStreetPlaceResponse.lon);
                                    widget.homeProvider
                                        .searchOpenStreetPlaceResponseList = [];
                                    state(() {});
                                  }

                                  print(
                                      "isLatLngValidate ==> $isLatLngValidate");
                                });
                              }
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d*'))
                            ],
                            style: FontUtilities.h14(
                                fontColor: VariableUtilities.theme.color6F6E6E),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 20, left: 8),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      width: 0.7,
                                      color:
                                          VariableUtilities.theme.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      width: 0.7,
                                      color:
                                          VariableUtilities.theme.primaryColor),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Long',
                            style: FontUtilities.h14(
                                fontColor:
                                    VariableUtilities.theme.color737B85)),
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: TextField(
                            onChanged: (val) async {
                              String latLng = '${latController.text},$val';
                              bool isLatLngValidate = isValidLatLong(latLng);
                              _debounceTimerForLong?.cancel();
                              print("isLatValid ==> $isLatLngValidate");

                              if (isLatLngValidate) {
                                _debounceTimerForLong =
                                    Timer(const Duration(milliseconds: 1500),
                                        () async {
                                  OpenStreetPlaceResponse?
                                      openStreetPlaceResponse = await widget
                                          .homeProvider
                                          .fetchLocationNameFromLatLong(LatLng(
                                              double.parse(latController.text),
                                              double.parse(val)));
                                  if (openStreetPlaceResponse != null) {
                                    print(
                                        'openStreetPlaceResponse --> ${openStreetPlaceResponse?.toJson()}');
                                    locationNameController =
                                        TextEditingController(
                                            text: openStreetPlaceResponse
                                                .displayName);

                                    latController = TextEditingController(
                                        text: openStreetPlaceResponse.lat);
                                    longController = TextEditingController(
                                        text: openStreetPlaceResponse.lon);
                                    widget.homeProvider
                                        .searchOpenStreetPlaceResponseList = [];
                                    state(() {});
                                  }

                                  print(
                                      "isLatLngValidate ==> $isLatLngValidate");
                                });
                              }
                            },
                            controller: longController,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d*'))
                            ],
                            style: FontUtilities.h14(
                                fontColor: VariableUtilities.theme.color6F6E6E),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 20, left: 8),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      width: 0.7,
                                      color:
                                          VariableUtilities.theme.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      width: 0.7,
                                      color:
                                          VariableUtilities.theme.primaryColor),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Options',
                          style: FontUtilities.h14(
                              fontWeight: FWT.semiBold,
                              fontColor: VariableUtilities.theme.primaryColor),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: SvgPicture.asset(
                            widget.homeProvider.isOptionsAvailable
                                ? AssetUtils.downArrowSvgIcon
                                : AssetUtils.upArrowSvgIcon,
                            height: 8,
                            width: 8,
                            color: VariableUtilities.theme.primaryColor,
                          ),
                          onPressed: () {
                            widget.homeProvider.isOptionsAvailable =
                                !widget.homeProvider.isOptionsAvailable;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    widget.homeProvider.isOptionsAvailable
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Service-Time(mins)',
                                      style: FontUtilities.h14(
                                          fontColor: VariableUtilities
                                              .theme.color737B85)),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            width: 0.7,
                                            color: VariableUtilities
                                                .theme.primaryColor)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            onChanged: (val) {
                                              final RegExp digitOnlyRegex =
                                                  RegExp(r'^[0-9.]+$');

                                              if (digitOnlyRegex
                                                      .hasMatch(val) &&
                                                  val.isNotEmpty) {
                                                int? service =
                                                    int.tryParse(val);
                                                if (service != null) {
                                                  widget.homeProvider
                                                      .increaseServiceTimeByTypeForOptimizedMarker(
                                                    dropLocationIndex: widget
                                                        .dropLocationIndex,
                                                    jobName: widget.routeStep
                                                            .description ??
                                                        '',
                                                    selectedJobIndex:
                                                        widget.selectedJobIndex,
                                                    service: service,
                                                  );
                                                }
                                              }
                                            },
                                            controller: serviceTimeController,
                                            cursorHeight: 20,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 20),
                                                enabledBorder: InputBorder.none,
                                                border: InputBorder.none),
                                            style: FontUtilities.h14(
                                                fontColor: VariableUtilities
                                                    .theme.color737B85),
                                          ),
                                        ),
                                        // Text('${widget.routeStep.serviceTime}',
                                        //     style: FontUtilities.h14(
                                        //         fontColor:
                                        //             VariableUtilities.theme.color737B85)),
                                        Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  state(() {});
                                                  widget.homeProvider
                                                      .increaseServiceTimeForOptimizedMarker(
                                                          widget.routeStep
                                                                  .description ??
                                                              '');
                                                  serviceTimeController.text =
                                                      '${widget.routeStep.serviceTime}';
                                                  // widget.homeProvider.increaseServiceTime(
                                                  //     widget.homeProvider
                                                  //         .uploadedExcelModelList[index]
                                                  //         .name);
                                                },
                                                child: const Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 12,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  state(() {});

                                                  widget.homeProvider
                                                      .decreaseServiceTimeForOptimizedMarker(
                                                          widget.routeStep
                                                                  .description ??
                                                              '');
                                                  serviceTimeController.text =
                                                      '${widget.routeStep.serviceTime}';
                                                  // widget.homeProvider.decreaseServiceTime(
                                                  //     widget.homeProvider
                                                  //         .uploadedExcelModelList[index]
                                                  //         .name);
                                                },
                                                child: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Priority(0-100)',
                                      style: FontUtilities.h14(
                                          fontColor: VariableUtilities
                                              .theme.color737B85)),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            width: 0.7,
                                            color: VariableUtilities
                                                .theme.primaryColor)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            onChanged: (val) {
                                              final RegExp digitOnlyRegex =
                                                  RegExp(r'^[0-9.]+$');

                                              if (digitOnlyRegex
                                                      .hasMatch(val) &&
                                                  val.isNotEmpty) {
                                                int? priority =
                                                    int.tryParse(val);
                                                if (priority != null) {
                                                  if (priority <= 100) {
                                                    widget.homeProvider
                                                        .increasePriorityByTypeForOptimizedMarker(
                                                      dropLocationIndex: widget
                                                          .dropLocationIndex,
                                                      selectedJobIndex: widget
                                                          .selectedJobIndex,
                                                      jobName: widget.routeStep
                                                              .description ??
                                                          '',
                                                      priority: priority,
                                                    );
                                                  } else {
                                                    priorityController.text =
                                                        '100';
                                                    widget.homeProvider
                                                        .increasePriorityByTypeForOptimizedMarker(
                                                      dropLocationIndex: widget
                                                          .dropLocationIndex,
                                                      selectedJobIndex: widget
                                                          .selectedJobIndex,
                                                      jobName: widget.routeStep
                                                              .description ??
                                                          '',
                                                      priority: 100,
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                            controller: priorityController,
                                            cursorHeight: 20,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 20),
                                                enabledBorder: InputBorder.none,
                                                border: InputBorder.none),
                                            style: FontUtilities.h14(
                                                fontColor: VariableUtilities
                                                    .theme.color737B85),
                                          ),
                                        ),
                                        // Text('${widget.routeStep.priority}',
                                        //     style: FontUtilities.h14(
                                        //         fontColor:
                                        //             VariableUtilities.theme.color737B85)),
                                        Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  state(() {});
                                                  widget.homeProvider
                                                      .increaseJobPriorityForOptimizedMarker(
                                                          widget.routeStep
                                                                  .description ??
                                                              '');
                                                  priorityController.text =
                                                      '${widget.routeStep.priority}';
                                                },
                                                child: const Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 12,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  state(() {});

                                                  widget.homeProvider
                                                      .decreaseJobPriorityForOptimizedMarker(
                                                          widget.routeStep
                                                                  .description ??
                                                              '');
                                                  priorityController.text =
                                                      '${widget.routeStep.priority}';
                                                  // widget.homeProvider.decreaseJobPriority(
                                                  //     widget.homeProvider
                                                  //         .uploadedExcelModelList[index]
                                                  //         .name);
                                                },
                                                child: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Start-Time',
                                      style: FontUtilities.h14(
                                          fontColor: VariableUtilities
                                              .theme.color737B85)),
                                  InkWell(
                                    onTap: () async {
                                      TimeOfDay? timeOfDay =
                                          await openTimePicker(context);
                                      if (timeOfDay != null) {
                                        DateTime currentDate = DateTime.now();

                                        DateTime selectedDateTime = DateTime(
                                          currentDate.year,
                                          currentDate.month,
                                          currentDate.day,
                                          timeOfDay.hour,
                                          timeOfDay.minute,
                                        );
                                        startDateTime = selectedDateTime;
                                        widget.homeProvider
                                            .updateStartTimeForOptimizedMarker(
                                                widget.routeStep.description ??
                                                    '',
                                                selectedDateTime);
                                        state(() {});
                                      }
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                              width: 0.7,
                                              color: VariableUtilities
                                                  .theme.primaryColor)),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            DateFormat('h:mm a').format(
                                                widget.routeStep.startTime),
                                            style: FontUtilities.h14(
                                                fontColor: VariableUtilities
                                                    .theme.color737B85)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('End-Time',
                                      style: FontUtilities.h14(
                                          fontColor: VariableUtilities
                                              .theme.color737B85)),
                                  InkWell(
                                    onTap: () async {
                                      TimeOfDay? timeOfDay =
                                          await openTimePicker(context);
                                      if (timeOfDay != null) {
                                        DateTime currentDate = DateTime.now();

                                        // Create a DateTime object by combining the current date with the chosen time
                                        DateTime selectedDateTime = DateTime(
                                          currentDate.year,
                                          currentDate.month,
                                          currentDate.day,
                                          timeOfDay.hour,
                                          timeOfDay.minute,
                                        );
                                        endDateTime = selectedDateTime;
                                        widget.homeProvider
                                            .updateEndTimeForOptimizedMarker(
                                                widget.routeStep.description ??
                                                    '',
                                                selectedDateTime);
                                        state(() {});
                                      }
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                              width: 0.7,
                                              color: VariableUtilities
                                                  .theme.primaryColor)),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            DateFormat('h:mm a').format(
                                                widget.routeStep.endTime),
                                            style: FontUtilities.h14(
                                                fontColor: VariableUtilities
                                                    .theme.color737B85)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryButton(
                            height: 30,
                            borderRadius: 3,
                            width: 110,
                            textStyle: FontUtilities.h16(
                                fontWeight: FWT.semiBold,
                                fontColor: VariableUtilities.theme.color292D32),
                            onTap: () {
                              // homeProvider
                              //         .isCustomTruckDialogOpen =
                              //     false;
                              widget.homeProvider.isOptionsAvailable = false;
                              widget.homeProvider
                                  .searchOpenStreetPlaceResponseList = [];
                              widget.callBack();
                            },
                            title: 'Cancel',
                            titleColor: VariableUtilities.theme.blackColor,
                            color: Colors.transparent),
                        const SizedBox(width: 10),
                        PrimaryButton(
                          borderRadius: 3,
                          height: 30,
                          textStyle: FontUtilities.h16(
                              fontWeight: FWT.semiBold,
                              fontColor: VariableUtilities.theme.colorF7F9FB),
                          borderColor: VariableUtilities.theme.primaryColor,
                          width: 110,
                          onTap: () async {
                            if (locationNameController.text.isEmpty) {
                              showToast(title: 'Please Enter Location name');
                              return;
                            }
                            if (isValidLatLong(
                                '${latController.text},${longController.text}')) {
                              showToast(title: 'Enter Valid LatLng');
                              return;
                            }
                            widget.homeProvider
                                .updateOptimizedPointsListByIndex(
                              routeStep: RouteStep(
                                  description: locationNameController.text,
                                  globalKey: widget.routeStep.globalKey,
                                  id: widget.routeStep.id,
                                  job: widget.routeStep.job,
                                  type: widget.routeStep.type,
                                  location: [
                                    double.parse(longController.text),
                                    double.parse(latController.text)
                                  ],
                                  setup: widget.routeStep.setup,
                                  service: widget.routeStep.service,
                                  waitingTime: widget.routeStep.waitingTime,
                                  load: widget.routeStep.load,
                                  arrival: widget.routeStep.arrival,
                                  duration: widget.routeStep.duration,
                                  totalTravelDuration:
                                      widget.routeStep.totalTravelDuration,
                                  violations: widget.routeStep.violations,
                                  distance: widget.routeStep.distance,
                                  priority: int.parse(priorityController.text),
                                  startTime: startDateTime,
                                  endTime: endDateTime,
                                  serviceTime:
                                      int.parse(serviceTimeController.text)),
                              id: widget.routeStep.id ?? 0,
                              uploadedExcelModel: UploadedExcelModel(
                                  id: widget.routeStep.id ?? 0,
                                  name: locationNameController.text,
                                  lng: double.parse(longController.text),
                                  lat: double.parse(latController.text),
                                  priority: int.parse(priorityController.text),
                                  startTime: startDateTime,
                                  endTime: endDateTime,
                                  serviceTime:
                                      int.parse(serviceTimeController.text),
                                  globalKey: GlobalKey()),
                            );

                            widget.homeProvider
                                .searchOpenStreetPlaceResponseList = [];
                            // Navigator.pop(context);
                            widget.callBack();
                          },
                          title: 'Save',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ]),
            )),
      );
    });
  }

  DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    print('Converted DateTime: $dateTime');
    return dateTime;
  }

  bool isValidLatitude(String latitude) {
    RegExp pattern = RegExp(r'^\s*([-+]?\d{1,2}(?:\.\d{1,6})?)\s*$');

    return pattern.hasMatch(latitude);
  }

  bool isValidLongitude(String longitude) {
    RegExp pattern = RegExp(r'^\s*([-+]?\d{1,3}(?:\.\d{1,6})?)\s*$');

    return pattern.hasMatch(longitude);
  }

  bool isValidLatLong(String latLong) {
    RegExp pattern = RegExp(
        r'^\s*([-+]?\d{1,2}(?:\.\d{1,6})?)\s*,\s*([-+]?\d{1,3}(?:\.\d{1,6})?)\s*$');

    return pattern.hasMatch(latLong);
  }
}
