import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/json_uploaded_model.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/open_source_place_response.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/open_time_picker.dart';
import 'package:trailset_route_optimize/mvp/widgets/pop_up/pop_up_shape.dart';
import 'package:trailset_route_optimize/mvp/widgets/widgets.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

class UploadedExcelFileMarkerDialog extends StatefulWidget {
  const UploadedExcelFileMarkerDialog(
      {super.key,
      required this.homeProvider,
      required this.index,
      required this.customPoint,
      required this.callback,
      this.isNewRecord = false});

  final HomeProvider homeProvider;
  final int index;
  final CustomPoint customPoint;
  final VoidCallback callback;
  final bool isNewRecord;

  @override
  State<UploadedExcelFileMarkerDialog> createState() =>
      _UploadedExcelFileMarkerDialogState();
}

class _UploadedExcelFileMarkerDialogState
    extends State<UploadedExcelFileMarkerDialog> {
  Timer? _debounceTimerForLocationName;
  Timer? _debounceTimerForLat;
  Timer? _debounceTimerForLong;

  TextEditingController serviceTimeController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();

  String locationName = 'Search Location...';
  LatLng latlong = const LatLng(0.0, 0.0);
  String serviceTime = "10";
  String priority = "0";

  // String startTime = DateFormat('h:mm a').format(DateTime(
  //     DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0, 0));
  // String endTime = DateFormat('h:mm a').format(DateTime(
  //     DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0, 0));
  DateTime startDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0, 0);
  DateTime endDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0, 0);
  @override
  void initState() {
    if (!widget.isNewRecord) {
      serviceTimeController = TextEditingController(
          text:
              '${widget.homeProvider.uploadedExcelModelList[widget.index].serviceTime}');

      priorityController = TextEditingController(
          text:
              '${widget.homeProvider.uploadedExcelModelList[widget.index].priority}');
      latController = TextEditingController(
          text:
              '${widget.homeProvider.uploadedExcelModelList[widget.index].lat}');
      longController = TextEditingController(
          text:
              '${widget.homeProvider.uploadedExcelModelList[widget.index].lng}');
      locationNameController = TextEditingController(
          text: widget.homeProvider.uploadedExcelModelList[widget.index].name);
    } else {
      latController = TextEditingController(text: '0.0');
      longController = TextEditingController(text: '0.0');
      serviceTimeController = TextEditingController(text: '10');
      priorityController = TextEditingController(text: '0');
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.homeProvider.isOptionsAvailable = false;
      widget.homeProvider.isLocationSearching = false;
      widget.homeProvider.isSelectValidAddress = true;
      widget.homeProvider.isLatSearching = false;
      widget.homeProvider.isLongSearching = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return SingleChildScrollView(
        child: PopupShapes(
            position: widget.isNewRecord
                ? PopupArrowPosition.none
                : PopupArrowPosition.bottomCenter,
            bgColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Job ${widget.isNewRecord ? (widget.homeProvider.uploadedExcelModelList.length + 1) : (widget.index + 1)}',
                              style: FontUtilities.h14(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.color737B85)),
                          InkWell(
                            onTap: () {
                              widget.homeProvider.isOptionsAvailable = false;

                              if (widget.isNewRecord) {
                                Navigator.pop(context);
                              } else {
                                widget.callback();
                              }
                            },
                            child: SvgPicture.asset(AssetUtils.cancelSvgIcon),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                          locationNameController.text.isEmpty
                              ? 'Search Your Location...'
                              : locationNameController.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FontUtilities.h18(
                              fontWeight: FWT.semiBold,
                              fontColor: VariableUtilities.theme.blackColor)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: TextField(
                          // onEditingComplete: ,
                          controller: locationNameController,
                          onChanged: (val) async {
                            if (val.isNotEmpty && val.length > 3) {
                              widget.homeProvider.isSelectValidAddress = false;
                              widget.homeProvider.isLocationSearching = true;
                              _debounceTimerForLocationName?.cancel();

                              _debounceTimerForLocationName = Timer(
                                  const Duration(milliseconds: 1500), () async {
                                try {
                                  await widget.homeProvider
                                      .searchOnChanged(searchText: val);
                                  widget.homeProvider.isLocationSearching =
                                      false;
                                } catch (e) {
                                  widget.homeProvider.isLocationSearching =
                                      false;
                                }
                                state(() {});
                              });
                            }
                            if (val.isEmpty) {
                              widget.homeProvider.isLocationSearching = false;

                              widget.homeProvider
                                  .searchOpenStreetPlaceResponseList = [];
                              widget.homeProvider.isSelectValidAddress = true;
                            }
                            state(() {});
                          },
                          decoration: InputDecoration(
                              hintText: 'Search your location here...',
                              hintStyle: FontUtilities.h16(
                                  fontColor:
                                      VariableUtilities.theme.color6F6E6E),
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
                      Stack(
                        children: [
                          widget.homeProvider.searchOpenStreetPlaceResponseList
                                  .isEmpty
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                      color: VariableUtilities.theme.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: VariableUtilities
                                              .theme.blackColor
                                              .withOpacity(0.15),
                                          offset: const Offset(0, 2),
                                          blurRadius: 6,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: widget
                                            .homeProvider
                                            .searchOpenStreetPlaceResponseList
                                            .length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              OpenStreetPlaceResponse
                                                  openStreetPlaceResponse =
                                                  widget.homeProvider
                                                          .searchOpenStreetPlaceResponseList[
                                                      index];
                                              locationNameController =
                                                  TextEditingController(
                                                      text:
                                                          openStreetPlaceResponse
                                                              .displayName);
                                              locationName =
                                                  openStreetPlaceResponse
                                                      .displayName;
                                              latController =
                                                  TextEditingController(
                                                      text:
                                                          openStreetPlaceResponse
                                                              .lat);
                                              longController =
                                                  TextEditingController(
                                                      text:
                                                          openStreetPlaceResponse
                                                              .lon);
                                              widget.homeProvider
                                                  .searchOpenStreetPlaceResponseList = [];
                                              widget.homeProvider
                                                  .isSelectValidAddress = true;
                                              state(() {});
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                            fontWeight:
                                                                FWT.semiBold,
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
                          locationNameController.text.isNotEmpty
                              ? widget.homeProvider.isLocationSearching
                                  ? SizedBox(
                                      width: VariableUtilities.screenSize.width,
                                      height: 55,
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      ))
                                  : widget
                                          .homeProvider
                                          .searchOpenStreetPlaceResponseList
                                          .isEmpty
                                      ? widget.homeProvider.isSelectValidAddress
                                          ? const SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 10),
                                                Center(
                                                  child: Text(
                                                    'No Location Found...',
                                                    style: FontUtilities.h14(
                                                        fontWeight:
                                                            FWT.semiBold,
                                                        fontColor:
                                                            VariableUtilities
                                                                .theme
                                                                .blackColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                      : const SizedBox()
                              : const SizedBox()
                        ],
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
                            child: Stack(
                              children: [
                                TextField(
                                  controller: latController,
                                  onChanged: (val) {
                                    String latLng =
                                        '$val,${longController.text}';

                                    bool isLatLngValidate =
                                        isValidLatLong(latLng);
                                    _debounceTimerForLat?.cancel();

                                    if (isLatLngValidate) {
                                      _debounceTimerForLat = Timer(
                                          const Duration(milliseconds: 1500),
                                          () async {
                                        widget.homeProvider.isLatSearching =
                                            true;
                                        state(() {});
                                        try {
                                          OpenStreetPlaceResponse?
                                              openStreetPlaceResponse =
                                              await widget.homeProvider
                                                  .fetchLocationNameFromLatLong(
                                                      LatLng(
                                                          double.parse(val),
                                                          double.parse(
                                                              longController
                                                                  .text)));
                                          if (openStreetPlaceResponse != null) {
                                            locationNameController =
                                                TextEditingController(
                                                    text:
                                                        openStreetPlaceResponse
                                                            .displayName);
                                            locationName =
                                                openStreetPlaceResponse
                                                    .displayName;
                                            latController =
                                                TextEditingController(
                                                    text:
                                                        openStreetPlaceResponse
                                                            .lat);
                                            longController =
                                                TextEditingController(
                                                    text:
                                                        openStreetPlaceResponse
                                                            .lon);
                                            widget.homeProvider
                                                .searchOpenStreetPlaceResponseList = [];
                                            state(() {});
                                          }
                                          widget.homeProvider.isLatSearching =
                                              false;
                                        } catch (e) {
                                          widget.homeProvider.isLatSearching =
                                              false;
                                          state(() {});
                                        }
                                        // widget.homeProvider.isLatLongSearching =
                                        //     false;
                                        state(() {});
                                      });
                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d*'))
                                  ],
                                  style: FontUtilities.h14(
                                      fontColor:
                                          VariableUtilities.theme.color6F6E6E),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 20, left: 8),
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        borderSide: BorderSide(
                                            width: 0.7,
                                            color: VariableUtilities
                                                .theme.primaryColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        borderSide: BorderSide(
                                            width: 0.7,
                                            color: VariableUtilities
                                                .theme.primaryColor),
                                      )),
                                ),
                                Visibility(
                                    visible: widget.homeProvider.isLatSearching,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      ],
                                    ))
                              ],
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
                            child: Stack(
                              children: [
                                TextField(
                                  onChanged: (val) async {
                                    String latLng =
                                        '${latController.text},$val';
                                    bool isLatLngValidate =
                                        isValidLatLong(latLng);
                                    _debounceTimerForLong?.cancel();

                                    if (isLatLngValidate) {
                                      _debounceTimerForLong = Timer(
                                          const Duration(milliseconds: 1500),
                                          () async {
                                        widget.homeProvider.isLongSearching =
                                            true;
                                        try {
                                          OpenStreetPlaceResponse?
                                              openStreetPlaceResponse =
                                              await widget.homeProvider
                                                  .fetchLocationNameFromLatLong(
                                                      LatLng(
                                                          double.parse(
                                                              latController
                                                                  .text),
                                                          double.parse(val)));
                                          if (openStreetPlaceResponse != null) {
                                            locationNameController =
                                                TextEditingController(
                                                    text:
                                                        openStreetPlaceResponse
                                                            .displayName);
                                            locationName =
                                                openStreetPlaceResponse
                                                    .displayName;
                                            latController =
                                                TextEditingController(
                                                    text:
                                                        openStreetPlaceResponse
                                                            .lat);
                                            longController =
                                                TextEditingController(
                                                    text:
                                                        openStreetPlaceResponse
                                                            .lon);
                                            widget.homeProvider
                                                .searchOpenStreetPlaceResponseList = [];
                                            widget.homeProvider
                                                .isLongSearching = false;
                                          } else {
                                            widget.homeProvider
                                                .isLongSearching = false;
                                          }
                                          state(() {});
                                        } catch (e) {
                                          widget.homeProvider.isLongSearching =
                                              false;
                                          state(() {});
                                        }
                                      });
                                    }
                                  },
                                  controller: longController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d*'))
                                  ],
                                  style: FontUtilities.h14(
                                      fontColor:
                                          VariableUtilities.theme.color6F6E6E),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 20, left: 8),
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        borderSide: BorderSide(
                                            width: 0.7,
                                            color: VariableUtilities
                                                .theme.primaryColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        borderSide: BorderSide(
                                            width: 0.7,
                                            color: VariableUtilities
                                                .theme.primaryColor),
                                      )),
                                ),
                                Visibility(
                                    visible:
                                        widget.homeProvider.isLongSearching,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      ],
                                    ))
                              ],
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
                                fontColor:
                                    VariableUtilities.theme.primaryColor),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: SvgPicture.asset(
                              widget.homeProvider.isOptionsAvailable
                                  ? AssetUtils.downArrowSvgIcon
                                  : AssetUtils.upArrowSvgIcon,
                              height: 8,
                              width: 8,
                              colorFilter: ColorFilter.mode(
                                VariableUtilities.theme.primaryColor,
                                BlendMode.srcATop,
                              ),
                            ),
                            onPressed: () {
                              widget.homeProvider.isOptionsAvailable =
                                  !widget.homeProvider.isOptionsAvailable;
                              if (widget.isNewRecord) {
                                state(() {});
                              }
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
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                                    if (widget.isNewRecord) {
                                                      priority = val;
                                                      state(() {});
                                                    } else {
                                                      widget.homeProvider
                                                          .increaseServiceTimeByType(
                                                              id: widget
                                                                  .homeProvider
                                                                  .uploadedExcelModelList[
                                                                      widget
                                                                          .index]
                                                                  .id,
                                                              service: service,
                                                              index:
                                                                  widget.index);
                                                    }
                                                  }
                                                }
                                              },
                                              controller: serviceTimeController,
                                              cursorHeight: 20,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 20),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  border: InputBorder.none),
                                              style: FontUtilities.h14(
                                                  fontColor: VariableUtilities
                                                      .theme.color737B85),
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (widget.isNewRecord) {
                                                      int val = int.parse(
                                                          serviceTime);
                                                      val = val + 1;
                                                      serviceTime =
                                                          val.toString();
                                                      serviceTimeController
                                                          .text = serviceTime;
                                                    } else {
                                                      widget.homeProvider
                                                          .increaseServiceTime(widget
                                                              .homeProvider
                                                              .uploadedExcelModelList[
                                                                  widget.index]
                                                              .id);
                                                      serviceTimeController
                                                              .text =
                                                          '${widget.homeProvider.uploadedExcelModelList[widget.index].serviceTime}';
                                                    }
                                                    state(() {});
                                                    // homeProvider.inc(
                                                    //     jobName: homeProvider
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
                                                    if (widget.isNewRecord) {
                                                      int val = int.parse(
                                                          serviceTime);
                                                      val = val - 1;
                                                      if (val < 0) {
                                                        val = 0;
                                                      }
                                                      serviceTime =
                                                          val.toString();
                                                      serviceTimeController
                                                          .text = serviceTime;
                                                    } else {
                                                      widget.homeProvider
                                                          .decreaseServiceTime(widget
                                                              .homeProvider
                                                              .uploadedExcelModelList[
                                                                  widget.index]
                                                              .id);

                                                      serviceTimeController
                                                              .text =
                                                          '${widget.homeProvider.uploadedExcelModelList[widget.index].serviceTime}';
                                                    }
                                                    state(() {});
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
                                const SizedBox(height: 8),
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
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                                  int? priorityInt =
                                                      int.tryParse(val);

                                                  if (priorityInt != null) {
                                                    if (priorityInt <= 100) {
                                                      if (widget.isNewRecord) {
                                                        priority = priorityInt
                                                            .toString();
                                                        state(() {});
                                                      }
                                                      widget.homeProvider
                                                          .increasePriorityByType(
                                                              id: widget
                                                                  .homeProvider
                                                                  .uploadedExcelModelList[
                                                                      widget
                                                                          .index]
                                                                  .id,
                                                              priority:
                                                                  priorityInt,
                                                              index:
                                                                  widget.index);
                                                    } else {
                                                      priorityController.text =
                                                          '100';
                                                      priority =
                                                          priorityController
                                                              .text;
                                                      widget.homeProvider
                                                          .increasePriorityByType(
                                                              id: widget
                                                                  .homeProvider
                                                                  .uploadedExcelModelList[
                                                                      widget
                                                                          .index]
                                                                  .id,
                                                              priority: 100,
                                                              index:
                                                                  widget.index);
                                                    }
                                                  }
                                                }
                                              },
                                              controller: priorityController,
                                              cursorHeight: 20,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 20),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  border: InputBorder.none),
                                              style: FontUtilities.h14(
                                                  fontColor: VariableUtilities
                                                      .theme.color737B85),
                                            ),
                                          ),
                                          // Text(
                                          //     '${homeProvider.uploadedExcelModelList[index].priority}',
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
                                                    if (widget.isNewRecord) {
                                                      int val =
                                                          int.parse(priority);
                                                      val = val + 1;
                                                      if (val >= 100) {
                                                        val = 100;
                                                      }
                                                      priority = val.toString();
                                                      priorityController.text =
                                                          priority;
                                                    } else {
                                                      widget.homeProvider
                                                          .increaseJobPriority(widget
                                                              .homeProvider
                                                              .uploadedExcelModelList[
                                                                  widget.index]
                                                              .id);
                                                      priorityController.text =
                                                          '${widget.homeProvider.uploadedExcelModelList[widget.index].priority}';
                                                    }
                                                    state(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.keyboard_arrow_up,
                                                    size: 12,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (widget.isNewRecord) {
                                                      int val =
                                                          int.parse(priority);
                                                      val = val - 1;
                                                      if (val < 0) {
                                                        val = 0;
                                                      }
                                                      priority = val.toString();
                                                      priorityController.text =
                                                          priority;
                                                    } else {
                                                      widget.homeProvider
                                                          .decreaseJobPriority(widget
                                                              .homeProvider
                                                              .uploadedExcelModelList[
                                                                  widget.index]
                                                              .id);
                                                      priorityController.text =
                                                          '${widget.homeProvider.uploadedExcelModelList[widget.index].priority}';
                                                    }
                                                    state(() {});
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
                                const SizedBox(height: 8),
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
                                          if (widget.isNewRecord) {
                                          } else {
                                            widget.homeProvider.updateStartTime(
                                                widget
                                                    .homeProvider
                                                    .uploadedExcelModelList[
                                                        widget.index]
                                                    .id,
                                                selectedDateTime);
                                          }
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
                                              widget.isNewRecord
                                                  ? DateFormat('h:mm a')
                                                      .format(startDateTime)
                                                  : DateFormat('h:mm a').format(
                                                      widget
                                                          .homeProvider
                                                          .uploadedExcelModelList[
                                                              widget.index]
                                                          .startTime),
                                              style: FontUtilities.h14(
                                                  fontColor: VariableUtilities
                                                      .theme.color737B85)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
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
                                          if (widget.isNewRecord) {
                                            endDateTime = selectedDateTime;
                                          } else {
                                            widget.homeProvider.updateEndTime(
                                                widget
                                                    .homeProvider
                                                    .uploadedExcelModelList[
                                                        widget.index]
                                                    .id,
                                                selectedDateTime);
                                          }

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
                                              widget.isNewRecord
                                                  ? DateFormat('h:mm a')
                                                      .format(endDateTime)
                                                  : DateFormat('h:mm a').format(
                                                      widget
                                                          .homeProvider
                                                          .uploadedExcelModelList[
                                                              widget.index]
                                                          .endTime),
                                              style: FontUtilities.h14(
                                                  fontColor: VariableUtilities
                                                      .theme.color737B85)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PrimaryButton(
                              height: 30,
                              borderRadius: 3,
                              width: 110,
                              textStyle: FontUtilities.h16(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      VariableUtilities.theme.color292D32),
                              onTap: () {
                                // homeProvider
                                //         .isCustomTruckDialogOpen =
                                //     false;
                                widget.homeProvider.isOptionsAvailable = false;
                                widget.homeProvider
                                    .searchOpenStreetPlaceResponseList = [];
                                if (widget.isNewRecord) {
                                  Navigator.pop(context);
                                } else {
                                  widget.callback();
                                }
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
                              if (!isValidLatLong(
                                  '${latController.text},${longController.text}')) {
                                showToast(title: 'Enter Valid LatLng');
                                return;
                              }
                              if (priorityController.text.isEmpty) {
                                showToast(title: 'Enter Valid Priority');
                                return;
                              }
                              if (serviceTimeController.text.isEmpty) {
                                showToast(title: 'Enter Valid Service-Time');
                                return;
                              }

                              if (widget.isNewRecord) {
                                widget.homeProvider.updateUploadExcelItemList(
                                    UploadedExcelModel(
                                        id: (widget
                                                .homeProvider
                                                .uploadedExcelToOptimizeMarkerList
                                                .length +
                                            1),
                                        name: locationNameController.text,
                                        lng: double.parse(longController.text),
                                        lat: double.parse(latController.text),
                                        priority: int.parse(priority),
                                        startTime: startDateTime,
                                        endTime: endDateTime,
                                        serviceTime: int.parse(serviceTime),
                                        globalKey: GlobalKey()));
                                Navigator.pop(context);
                              } else {
                                widget.homeProvider
                                    .updateUploadExcelItemListByIndex(
                                        UploadedExcelModel(
                                            id: widget
                                                .homeProvider
                                                .uploadedExcelModelList[
                                                    widget.index]
                                                .id,
                                            name: locationNameController.text,
                                            lng: double.parse(
                                                longController.text),
                                            lat: double.parse(
                                                latController.text),
                                            priority: int.parse(
                                                priorityController.text),
                                            startTime: startDateTime,
                                            endTime: endDateTime,
                                            serviceTime: int.parse(
                                                serviceTimeController.text),
                                            globalKey: GlobalKey()),
                                        widget.index);
                                widget.callback();
                              }
                              widget.homeProvider
                                  .searchOpenStreetPlaceResponseList = [];

                              state(() {});
                            },
                            title: 'Save',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ]),
              ),
            )),
      );
    });
  }

  DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

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
        r'^\s*([-+]?\d{1,2}(?:\.\d{1,20})?)\s*,\s*([-+]?\d{1,3}(?:\.\d{1,20})?)\s*$');

    return pattern.hasMatch(latLong);
  }
}
