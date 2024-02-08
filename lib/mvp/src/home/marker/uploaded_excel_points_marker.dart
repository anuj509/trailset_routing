import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/json_uploaded_model.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/show_menu_for_upload_excel_file_marker.dart';

class UploadedExcelPointsMarker extends Marker {
  UploadedExcelPointsMarker({
    required this.uploadedExcelModel,
    required this.builder,
    required this.index,
  }) : super(
          height: 40,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: AnchorAlign.top.rotationAlignment,
          width: 40,
          point: LatLng(uploadedExcelModel.lat, uploadedExcelModel.lng),
          builder: builder,
        );

  final UploadedExcelModel uploadedExcelModel;
  final Widget Function(BuildContext) builder;
  final int index;
}

class UploadedExcelMarkerPopup extends StatelessWidget {
  const UploadedExcelMarkerPopup(
      {super.key,
      required this.homeProvider,
      required this.index,
      required this.customPoint,
      required this.callBack});

  final HomeProvider homeProvider;
  final int index;
  final CustomPoint customPoint;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return UploadedExcelFileMarkerDialog(
      homeProvider: homeProvider,
      index: index,
      customPoint: customPoint,
      callback: callBack,
    );
  }
}
