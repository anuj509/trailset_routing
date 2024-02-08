import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:parsel_web_optimize/mvp/src/home/marker/optimized_excel_points_marker.dart';
import 'package:parsel_web_optimize/mvp/src/home/marker/uploaded_excel_points_marker.dart';
import 'package:parsel_web_optimize/mvp/src/home/model/json_uploaded_model.dart';
import 'package:parsel_web_optimize/mvp/src/home/model/open_source_place_response.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/assigned_un_assigned_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/create_new_vehicle_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/download_template_view.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/home_screen_header_view.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/import_or_add_stops_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/optimize_button_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/round_trip_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/routing_summary_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/select_depo_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/select_new_vehicle_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/selected_vehicles_with_stops_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/show_menu_for_optimized_marker.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/show_menu_for_upload_excel_file_marker.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/un_assined_points_list_widget.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/uploaded_excel_points_widget.dart';
import 'package:parsel_web_optimize/mvp/widgets/widgets.dart';
import 'package:parsel_web_optimize/utils/utils.dart';
import 'package:provider/provider.dart';
// import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

// Only import dart:html if the code is running on the web.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset markerPosition = const Offset(0, 0);
  CustomPoint<double> offset = CustomPoint(0, 0);
  PopupController uploadedExcelPointPopupController = PopupController();
  PopupController optimizedPointsMPopupController = PopupController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.isCustomTruckDialogOpen = false;
      homeProvider.mapController!.move(homeProvider.depoLocation, 11);
    });

    super.initState();
  }

  // TextEditingController latitudeController =
  //     TextEditingController(text: '19.0441447');
  // TextEditingController longitudeController =
  //     TextEditingController(text: '72.8929133');
  final GlobalKey<FlutterMapState> mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Consumer(builder: (_, HomeProvider homeProvider, __) {
        return Stack(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: VariableUtilities.theme.colorF8FAFB,
                      boxShadow: [
                        BoxShadow(
                            color: VariableUtilities.theme.blackColor,
                            spreadRadius: -3,
                            blurRadius: 5)
                      ]),
                  height: VariableUtilities.screenSize.height,
                  width: 500,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImportOrAddStopsWidget(
                            onTemplateCallBack: () {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  barrierColor: Colors.transparent,
                                  builder: (ctx) {
                                    return DownloadTemplateView();
                                  });
                            },
                            homeProvider: homeProvider,
                            onAddStopCallBack: () async {
                              homeProvider.isOptionsAvailable = false;
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  barrierColor: Colors.transparent,
                                  builder: (ctx) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: SizedBox(
                                        width: 600,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              width: 400,
                                              color: Colors.white,
                                              child:
                                                  UploadedExcelFileMarkerDialog(
                                                callback: () {
                                                  uploadedExcelPointPopupController
                                                      .hideAllPopups();
                                                },
                                                customPoint:
                                                    const CustomPoint(0, 0),
                                                homeProvider: homeProvider,
                                                index: 0,
                                                isNewRecord: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            onImportCallBack: () async {
                              await homeProvider.selectExcelFile();
                            },
                          ),
                          const SizedBox(height: 12),
                          AssignedOrUnAssigned(homeProvider: homeProvider),
                          const SizedBox(height: 21),
                          HomeScreenHeaderView(
                              isOptimizeButtonEnabled:
                                  homeProvider.isOptimizeButtonEnabled,
                              onTap: homeProvider.isOptimizeButtonEnabled
                                  ? () async {
                                      // Timer(Duration(), () { })
                                      // await homeProvider.callOptimizeApi();
                                    }
                                  : () {}),
                          const SizedBox(height: 15),
                          CreateNewVehicleWidget(homeProvider: homeProvider),
                          const SizedBox(height: 10),
                          SelectNewVehicleWidget(homeProvider: homeProvider),
                          const SizedBox(height: 14),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'JOB',
                                style: FontUtilities.h14(
                                    fontColor:
                                        VariableUtilities.theme.blackColor,
                                    fontWeight: FWT.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SelectDepoWidget(homeProvider: homeProvider),
                          const SizedBox(height: 10),
                          RoundTripWidget(homeProvider: homeProvider),
                          const SizedBox(height: 10),
                          homeProvider.selectedAssignableType == 'Un-Assigned'
                              ? const SizedBox()
                              : SelectedVehicleWithStops(
                                  homeProvider: homeProvider),
                          const SizedBox(height: 10),
                          // AssignedPointsListWidget(homeProvider: homeProvider),
                          UnAssignedPointsListWidget(
                              homeProvider: homeProvider),
                          UploadedExcelPointsListWidget(
                              homeProvider: homeProvider),
                          const SizedBox(height: 10),
                        ]),
                  ),
                ),
                Expanded(
                    child: Stack(
                  children: [
                    FlutterMap(
                      key: mapKey,
                      options: MapOptions(
                        onTap: (TapPosition tapPosition, LatLng latLng) async {
                          await http
                              .get(Uri.parse(
                                  "https://nominatim.openstreetmap.org/reverse?lat=${latLng.latitude}&lon=${latLng.longitude}&format=json"))
                              .then((value) {
                            if (value.statusCode == 200) {
                              OpenStreetPlaceResponse openStreetPaceResponse =
                                  OpenStreetPlaceResponse.fromJson(
                                      jsonDecode(value.body));
                              homeProvider.updateExcelModelListOnTap(
                                  latLng, openStreetPaceResponse);
                            }
                            print("Value --> ${value.statusCode}");
                          });
                          uploadedExcelPointPopupController.hideAllPopups();
                        },
                        center: homeProvider.uploadedExcelModelList.isEmpty
                            ? const LatLng(51.509364, -0.128928)
                            : LatLng(homeProvider.uploadedExcelModelList[0].lat,
                                homeProvider.uploadedExcelModelList[0].lng),
                        zoom: 9.2,
                        minZoom: 4.0,
                        maxZoom: 18.0,
                      ),
                      mapController: homeProvider.mapController,
                      nonRotatedChildren: [
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(Uri.parse(
                                  'https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        Stack(
                          children: List.generate(
                            homeProvider.optimizedRouteModel.routes.length,
                            (index) => homeProvider
                                    .optimizedRouteModel.routes[index].isVisible
                                ? PolylineLayer(
                                    polylineCulling: true,
                                    polylines: [
                                      Polyline(
                                          strokeWidth: 0.5,
                                          borderColor: homeProvider
                                              .optimizedRouteModel
                                              .routes[index]
                                              .color
                                              .withOpacity(.6),
                                          color: homeProvider
                                              .optimizedRouteModel
                                              .routes[index]
                                              .color
                                              .withOpacity(.6),
                                          borderStrokeWidth: 6,
                                          points: homeProvider
                                              .optimizedRouteModel
                                              .routes[index]
                                              .polylines
                                              .map((e) => LatLng(
                                                  e.latitude, e.longitude))
                                              .toList())
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                                point: LatLng(
                                    homeProvider.depoLocation.latitude,
                                    homeProvider.depoLocation.longitude),
                                builder: (context) {
                                  return Draggable(
                                    feedback: Image.asset(AssetUtils.mapIcon,
                                        height: 20, width: 20),
                                    data: "LocationMarker",
                                    onDraggableCanceled: (velocity, offset) {
                                      if (offset.dx >= 490) {
                                        final point = homeProvider
                                            .mapController!
                                            .pointToLatLng(CustomPoint(
                                                offset.dx - 500 + 10,
                                                offset.dy + 5 - 67));
                                        homeProvider.latitudeController.text =
                                            '${point.latitude}';

                                        homeProvider.longitudeController.text =
                                            '${point.longitude}';

                                        homeProvider.depoLocation = point;
                                        // homeProvider
                                        //         .isOptimizeButtonEnabled =
                                        //     true;
                                      }
                                    },
                                    child: Image.asset(AssetUtils.mapIcon,
                                        height: 20, width: 20),
                                  );
                                })
                          ],
                        ),

                        Stack(
                          children: [
                            for (int i = 0;
                                i < homeProvider.selectedJobList.length;
                                i++) ...{
                              homeProvider.selectedJobList[i].isJobActivated
                                  ? PopupMarkerLayer(
                                      key: homeProvider
                                          .selectedJobList[i].globalKey,
                                      options: PopupMarkerLayerOptions(
                                        popupController:
                                            optimizedPointsMPopupController,
                                        markers: List.generate(
                                            homeProvider.selectedJobList[i]
                                                .dropLocationNameList.length,
                                            (index) =>
                                                OptimizedExcelPointsMarker(
                                                    selectedJobIndex: i,
                                                    routeStep: homeProvider
                                                            .selectedJobList[i]
                                                            .dropLocationNameList[
                                                        index],
                                                    index: index,
                                                    builder: (_) => homeProvider
                                                                .selectedJobList[
                                                                    i]
                                                                .dropLocationNameList[
                                                                    index]
                                                                .type ==
                                                            'job'
                                                        ? Stack(
                                                            children: [
                                                              Center(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  AssetUtils
                                                                      .greenMapSvgIcon,
                                                                  height: 35,
                                                                  width: 35,
                                                                  color: homeProvider
                                                                      .selectedJobList[
                                                                          i]
                                                                      .color
                                                                      .withOpacity(
                                                                          0.6),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          5.0,
                                                                      right:
                                                                          1.0),
                                                                  child: Text(
                                                                    '$index',
                                                                    style: FontUtilities.h12(
                                                                        fontWeight: FWT
                                                                            .semiBold,
                                                                        fontColor: VariableUtilities
                                                                            .theme
                                                                            .whiteColor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox())),
                                        popupDisplayOptions:
                                            PopupDisplayOptions(
                                                snap: PopupSnap.markerTop,
                                                builder: (BuildContext context,
                                                    Marker marker) {
                                                  if (marker
                                                      is OptimizedExcelPointsMarker) {
                                                    print(
                                                        "marker.index --> ${marker.selectedJobIndex} ${marker.index}");
                                                    return OptimizedMarkerDialog(
                                                      key: homeProvider
                                                          .selectedJobList[marker
                                                              .selectedJobIndex]
                                                          .dropLocationNameList[
                                                              marker.index]
                                                          .globalKey,
                                                      homeProvider:
                                                          homeProvider,
                                                      color: homeProvider
                                                          .selectedJobList[marker
                                                              .selectedJobIndex]
                                                          .color,
                                                      routeStep: homeProvider
                                                              .selectedJobList[
                                                                  marker
                                                                      .selectedJobIndex]
                                                              .dropLocationNameList[
                                                          marker.index],
                                                      selectedJobIndex: marker
                                                          .selectedJobIndex,
                                                      dropLocationIndex:
                                                          marker.index,
                                                      callBack: () {
                                                        optimizedPointsMPopupController
                                                            .hideAllPopups();
                                                      },
                                                    );
                                                  }
                                                  return const SizedBox();
                                                }),
                                      ),
                                    )
                                  : const SizedBox(),
                            },
                          ],
                        ),
                        // : const SizedBox(),
                        PopupMarkerLayer(
                          // key: uploadedMarkerKey,
                          options: PopupMarkerLayerOptions(
                            popupController: uploadedExcelPointPopupController,
                            markers: List.generate(
                                homeProvider.uploadedExcelModelList.length,
                                (index) => UploadedExcelPointsMarker(
                                      index: index,
                                      // key: e.globalKey,
                                      uploadedExcelModel: UploadedExcelModel(
                                          id: homeProvider
                                              .uploadedExcelModelList[index].id,
                                          name: homeProvider
                                              .uploadedExcelModelList[index]
                                              .name,
                                          lng: homeProvider
                                              .uploadedExcelModelList[index]
                                              .lng,
                                          lat: homeProvider
                                              .uploadedExcelModelList[index]
                                              .lat,
                                          priority: homeProvider
                                              .uploadedExcelModelList[index]
                                              .priority,
                                          startTime: homeProvider
                                              .uploadedExcelModelList[index]
                                              .startTime,
                                          endTime: homeProvider
                                              .uploadedExcelModelList[index]
                                              .endTime,
                                          serviceTime: homeProvider
                                              .uploadedExcelModelList[index]
                                              .serviceTime,
                                          globalKey: homeProvider
                                              .uploadedExcelModelList[index]
                                              .globalKey),

                                      builder: (_) => Stack(
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              AssetUtils.greenMapSvgIcon,
                                              height: 35,
                                              width: 35,
                                              color: VariableUtilities
                                                  .theme.primaryColor
                                                  .withOpacity(0.6),
                                            ),
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
                                    )),
                            popupDisplayOptions: PopupDisplayOptions(
                                snap: PopupSnap.markerTop,
                                builder: (BuildContext context, Marker marker) {
                                  if (marker is UploadedExcelPointsMarker) {
                                    return UploadedExcelMarkerPopup(
                                      callBack: () {
                                        uploadedExcelPointPopupController
                                            .hideAllPopups();
                                      },
                                      customPoint: offset,
                                      homeProvider: homeProvider,
                                      index: marker.index,
                                    );
                                  }
                                  return const Card(
                                      child: Text('Not a uploadedExcelModel'));
                                }),
                          ),
                        ),
                      ],
                    ),
                    RoutingSummaryWidget(homeProvider: homeProvider),
                    OptimizeButtonWidget(
                      homeProvider: homeProvider,
                      onTap: homeProvider.isOptimizeButtonEnabled
                          ? () async {
                              uploadedExcelPointPopupController.hideAllPopups();
                              await homeProvider.callOptimizeApi();
                            }
                          : () {},
                    )
                  ],
                )),
              ],
            ),
            Visibility(
                visible: homeProvider.isRouteOptimizedActivated ||
                    homeProvider.isFileSelectPressed,
                child: Container(
                    color: VariableUtilities.theme.blackColor.withOpacity(0.3),
                    height: VariableUtilities.screenSize.height,
                    width: VariableUtilities.screenSize.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: VariableUtilities.theme.primaryColor,
                      ),
                    ))),
          ],
        );
      }),
    );
  }

  String truckReachDurationTmeInHoursAndMinutes(DateTime date) {
    return DateFormat('h:mm a').format(
        DateTime(date.year, date.month, date.day, date.hour, date.minute));
  }

  Future<TimeOfDay?> openTimePicker() async {
    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return timeOfDay;
  }
}
