import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/optimized_route_model.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/show_menu_for_optimized_marker.dart';

class OptimizedExcelPointsMarker extends Marker {
  OptimizedExcelPointsMarker({
    required this.routeStep,
    required this.builder,
    required this.index,
    required this.selectedJobIndex,
  }) : super(
          key: GlobalKey(),
          height: 40,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: AnchorAlign.top.rotationAlignment,
          width: 40,
          point: LatLng(routeStep.location[1], routeStep.location[0]),
          builder: builder,
        );

  final RouteStep routeStep;

  final Widget Function(BuildContext) builder;
  final int index;
  final int selectedJobIndex;
}

class OptimizedPointsMarkerPopup extends StatelessWidget {
  const OptimizedPointsMarkerPopup(
      {super.key,
      required this.homeProvider,
      required this.callBack,
      required this.routeStep,
      required this.selectedJobIndex,
      required this.dropLocationIndex,
      required this.color});
  final HomeProvider homeProvider;
  final RouteStep routeStep;
  final int selectedJobIndex;
  final int dropLocationIndex;
  final Color color;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return OptimizedMarkerDialog(
      callBack: callBack,
      color: color,
      dropLocationIndex: dropLocationIndex,
      routeStep: routeStep,
      selectedJobIndex: selectedJobIndex,
      homeProvider: homeProvider,
    );
  }
}
