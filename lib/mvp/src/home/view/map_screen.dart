// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';

// CustomInfoWindowController _customInfoWindowController =
//     CustomInfoWindowController();

// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return OSMFlutter(
//         controller: mapController,
//         onLocationChanged: (c) {
//           
//         },
//         onGeoPointClicked: (p) {
//           
//         },
//         osmOption: OSMOption(
//           showZoomController: true,
//           showDefaultInfoWindow: true,
//           userTrackingOption: const UserTrackingOption(
//             enableTracking: true,
//             unFollowUser: false,
//           ),
//           zoomOption: const ZoomOption(
//             minZoomLevel: 3,
//             initZoom: 12,
//             maxZoomLevel: 19,
//             stepZoom: 1.0,
//           ),
//           userLocationMarker: UserLocationMaker(
//             personMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.location_history_rounded,
//                 color: Colors.red,
//                 size: 48,
//               ),
//             ),
//             directionArrowMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.double_arrow,
//                 size: 48,
//               ),
//             ),
//           ),
//           roadConfiguration: const RoadOption(
//             roadColor: Colors.yellowAccent,
//           ),
//           markerOption: MarkerOption(
//               defaultMarker: const MarkerIcon(
//             icon: Icon(
//               Icons.person_pin_circle,
//               color: Colors.blue,
//               size: 56,
//             ),
//           )),
//         ));
//   }
// }
