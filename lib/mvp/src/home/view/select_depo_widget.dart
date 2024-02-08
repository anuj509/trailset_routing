import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class SelectDepoWidget extends StatefulWidget {
  const SelectDepoWidget({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  State<SelectDepoWidget> createState() => _SelectDepoWidgetState();
}

class _SelectDepoWidgetState extends State<SelectDepoWidget> {
  // TextEditingController latitudeController =
  //     TextEditingController(text: '19.0441447');

  // TextEditingController longitudeController =
  //     TextEditingController(text: '72.8929133');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Depo',
              style: FontUtilities.h14(
                  fontColor: VariableUtilities.theme.color737B85,
                  fontWeight: FWT.semiBold),
            ),
            const SizedBox(width: 10),
            Draggable(
              feedback: Center(
                child: Image.asset(AssetUtils.mapIcon, height: 20, width: 20),
              ),
              data: "LocationMarker",
              onDraggableCanceled: (velocity, offset) {
                if (offset.dx >= 490) {
                  final point = widget.homeProvider.mapController!
                      .pointToLatLng(CustomPoint(
                          offset.dx - 500 + 10, offset.dy + 5 - 67));
                  widget.homeProvider.latitudeController.text =
                      '${point.latitude}';

                  widget.homeProvider.longitudeController.text =
                      '${point.longitude}';

                  widget.homeProvider.depoLocation = point;
                }
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: VariableUtilities.theme.color737B85,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    child: Row(children: [
                      Container(
                        height: 35,
                        width: 2,
                        color: VariableUtilities.theme.primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            SvgPicture.asset(AssetUtils.sixDotSvgIcon,
                                height: 15, width: 15),
                            const SizedBox(width: 8),
                            Text(
                              'Depo',
                              style: FontUtilities.h14(
                                  fontColor: VariableUtilities.theme.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(AssetUtils.mapIcon,
                                height: 20, width: 20),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Container(color: Colors.red)
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: VariableUtilities.theme.color737B85,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        'Lat',
                        style: FontUtilities.h12(
                            fontColor: VariableUtilities.theme.color777C83),
                      ),
                      SizedBox(
                        height: 50,
                        width: 80,
                        child: TextFormField(
                          onChanged: (val) {
                            final RegExp digitOnlyRegex = RegExp(r'^[0-9.]+$');

                            if (digitOnlyRegex.hasMatch(val) &&
                                val.isNotEmpty) {
                              widget.homeProvider.depoLocation = LatLng(
                                  double.parse(val),
                                  widget.homeProvider.depoLocation.longitude);
                              widget.homeProvider.mapController!.move(
                                  LatLng(
                                      double.parse(val),
                                      widget
                                          .homeProvider.depoLocation.longitude),
                                  15);
                            }
                          },
                          controller: widget.homeProvider.latitudeController,
                          cursorHeight: 15,
                          style: FontUtilities.h12(
                              fontWeight: FWT.semiBold,
                              fontColor: VariableUtilities.theme.blackColor),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(1),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  color: VariableUtilities.theme.color737B85,
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        'Lng',
                        style: FontUtilities.h12(
                            fontColor: VariableUtilities.theme.color777C83),
                      ),
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextFormField(
                          onChanged: (val) {
                            final RegExp digitOnlyRegex = RegExp(r'^[0-9.]+$');

                            if (digitOnlyRegex.hasMatch(val) &&
                                val.isNotEmpty) {
                              widget.homeProvider.depoLocation = LatLng(
                                  widget.homeProvider.depoLocation.latitude,
                                  double.parse(val));

                              widget.homeProvider.mapController!.move(
                                  LatLng(
                                      widget.homeProvider.depoLocation.latitude,
                                      double.parse(val)),
                                  15);
                            }
                          },
                          controller: widget.homeProvider.longitudeController,
                          cursorHeight: 20,
                          style: FontUtilities.h12(
                              fontWeight: FWT.semiBold,
                              fontColor: VariableUtilities.theme.blackColor),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(1),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
