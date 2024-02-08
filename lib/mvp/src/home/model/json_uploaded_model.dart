import 'dart:convert';

import 'package:flutter/material.dart';

UploadedExcelModel uploadedExcelModelFromJson(String str) =>
    UploadedExcelModel.fromJson(json.decode(str));

String uploadedExcelModelToJson(UploadedExcelModel data) =>
    json.encode(data.toJson());

class UploadedExcelModel {
  final int id;
  final String name;
  final double lng;
  final double lat;
  int priority;
  DateTime startTime;
  DateTime endTime;
  int serviceTime;
  final GlobalKey globalKey;

  UploadedExcelModel({
    required this.id,
    required this.name,
    required this.lng,
    required this.lat,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.serviceTime,
    required this.globalKey,
  });

  factory UploadedExcelModel.fromJson(Map<String, dynamic> json) =>
      UploadedExcelModel(
        id: json["id"],
        name: json["name"],
        lng: json["lng"],
        lat: json["lat"],
        priority: json["priority"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        serviceTime: json["service_time"],
        globalKey: json["global_key"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lng": lng,
        "lat": lat,
        "priority": priority,
        "start_time": startTime,
        "end_time": endTime,
        "service_time": serviceTime,
        "global_key": globalKey,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadedExcelModel &&
        other.endTime == endTime &&
        other.globalKey == globalKey &&
        other.id == id &&
        other.lat == lat &&
        other.lng == lng &&
        other.name == name &&
        other.priority == priority &&
        other.serviceTime == serviceTime &&
        other.startTime == startTime;
  }

  @override
  int get hashCode {
    return Object.hash(
      endTime,
      globalKey,
      id,
      lat,
      lng,
      name,
      priority,
      serviceTime,
      startTime,
    );
  }
}
