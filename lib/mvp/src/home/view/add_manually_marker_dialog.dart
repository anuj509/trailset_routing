import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:parsel_web_optimize/mvp/src/home/model/open_source_place_response.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/open_time_picker.dart';
import 'package:parsel_web_optimize/mvp/widgets/widgets.dart';
import 'package:parsel_web_optimize/utils/utils.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

addManuallyMarkerDialog(BuildContext context, HomeProvider homeProvider) {
  final _formKey = GlobalKey<FormState>();

  showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return Material(
          color: Colors.transparent,
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
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              width: 400,
                              decoration: BoxDecoration(
                                  color: VariableUtilities.theme.whiteColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Add Custom Point',
                                              style: FontUtilities.h18(
                                                  fontWeight: FWT.bold,
                                                  fontColor: VariableUtilities
                                                      .theme.color292D32),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          DropdownSearch<
                                                  OpenStreetPlaceResponse>(
                                              compareFn: (i, s) => true,
                                              asyncItems: (filter) async {
                                                List<OpenStreetPlaceResponse>
                                                    list = [];
                                                await http
                                                    .get(Uri.parse(
                                                        "https://nominatim.openstreetmap.org/search?q=surat&limit=5&format=json&addressdetails=1&countrycodes=IN"))
                                                    .then((value) {
                                                  if (value.statusCode == 200) {
                                                    var apiDataList =
                                                        jsonDecode(value.body);
                                                    List<OpenStreetPlaceResponse>
                                                        openStreetPaceResponses =
                                                        apiDataList
                                                            .map((jsonObject) {
                                                      return OpenStreetPlaceResponse
                                                          .fromJson(jsonObject);
                                                    }).toList();

                                                    list =
                                                        openStreetPaceResponses;
                                                    state(() {});
                                                  }
                                                  print(
                                                      "Value --> ${value.statusCode}");
                                                });
                                                return list;
                                              },
                                              popupProps:
                                                  PopupPropsMultiSelection.menu(
                                                isFilterOnline: true,
                                                showSelectedItems: true,
                                                showSearchBox: true,
                                                onItemAdded: (list, obj) {
                                                  print(obj);
                                                },
                                                itemBuilder:
                                                    (context, object, val) {
                                                  return Text(
                                                      object.displayName);
                                                },
                                              )),
                                          Stack(
                                            fit: StackFit.passthrough,
                                            children: [
                                              InputField(
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    AssetUtils.mapIcon,
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                ),
                                                onChanged: (val) {},
                                                controller:
                                                    TextEditingController(),
                                                label: 'Job Name',
                                                hintText: 'Enter Job Name',
                                                validator: (name) {
                                                  if (name!.isEmpty) {
                                                    return 'Please Enter Name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(children: [
                                            Expanded(
                                              child: InputField(
                                                onChanged: (val) {},
                                                controller:
                                                    TextEditingController(),
                                                label: 'Service Time',
                                                hintText: 'Enter Service Time',
                                                validator: (name) {
                                                  final RegExp digitOnlyRegex =
                                                      RegExp(r'^[0-9]+$');

                                                  if (!digitOnlyRegex
                                                      .hasMatch(name!)) {
                                                    return 'Field only contain digits';
                                                  }
                                                  if (name.isEmpty) {
                                                    return 'Please Enter Service Time';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: InputField(
                                                onChanged: (val) {},
                                                controller:
                                                    TextEditingController(),
                                                label: 'Priority',
                                                hintText: 'Enter Priority',
                                                validator: (name) {
                                                  final RegExp digitOnlyRegex =
                                                      RegExp(r'^[0-9]+$');

                                                  if (!digitOnlyRegex
                                                      .hasMatch(name!)) {
                                                    return 'Field only contain digits';
                                                  }
                                                  if (name.isEmpty) {
                                                    return 'Please Enter Priority';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ]),
                                          Row(children: [
                                            Expanded(
                                              child: InputField(
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? timeOfDay =
                                                      await openTimePicker(
                                                          context);

                                                  if (timeOfDay != null) {
                                                  } else {
                                                    showToast(
                                                        title:
                                                            "Please Select Time First");
                                                  }
                                                },
                                                controller:
                                                    TextEditingController(),
                                                label: 'Start Time',
                                                hintText: 'Enter Start Time',
                                                validator: (name) {
                                                  if (name!.isEmpty) {
                                                    return 'Please Enter start Time';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: InputField(
                                                onTap: () async {
                                                  TimeOfDay? timeOfDay =
                                                      await openTimePicker(
                                                          context);

                                                  if (timeOfDay != null) {
                                                  } else {
                                                    showToast(
                                                        title:
                                                            "Please Select Time First");
                                                  }
                                                },
                                                readOnly: true,
                                                controller:
                                                    TextEditingController(),
                                                label: 'End Time',
                                                hintText: 'Enter End Time',
                                                validator: (name) {
                                                  if (name!.isEmpty) {
                                                    return 'Please Enter End Time';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ]),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                              PrimaryButton(
                                                width: 150,
                                                onTap: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                title: 'Save',
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ]),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          // homeProvider.isCustomTruckDialogOpen =
                                          //     false;
                                          Navigator.pop(context);
                                        },
                                        icon: SvgPicture.asset(
                                          AssetUtils.cancelSvgIcon,
                                          height: 20,
                                        )),
                                  )
                                ],
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
        );
      });
}
