// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/optimized_route_model.dart';

JobModel jobModelFromJson(String str) => JobModel.fromJson(json.decode(str));

String jobModelToJson(JobModel data) => json.encode(data.toJson());

class JobModel {
  bool isJobActivated;
  bool isDropDownMenuOpen;
  bool isItemSelected;
  int vehicleQty;
  String vehicleName;
  String vehicleNo;
  int id;
  int vehicleId;
  int stops;
  int height;
  int length;
  int payload;
  int topSpeed;
  List<RouteStep> dropLocationNameList;
  Color color;
  DateTime startTime;
  DateTime endTime;
  GlobalKey? globalKey;
  JobModel({
    this.globalKey,
    this.isJobActivated = false,
    this.isDropDownMenuOpen = false,
    this.isItemSelected = false,
    this.vehicleQty = 1,
    this.color = Colors.transparent,
    required this.id,
    required this.vehicleId,
    required this.vehicleName,
    required this.vehicleNo,
    required this.stops,
    required this.height,
    required this.length,
    required this.payload,
    required this.topSpeed,
    required this.startTime,
    required this.endTime,
    this.dropLocationNameList = const [],
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    print("startTime --> ${json["startTime"].runtimeType}");
    print("endTime --> ${json["endTime"].runtimeType}");
    return JobModel(
      isJobActivated: json["isJobActivated"],
      id: json["id"],
      vehicleId: json["vehicleId"],
      isDropDownMenuOpen: json["isDropDownMenuOpen"],
      isItemSelected: json["isItemSelected"],
      vehicleQty: json["vehicleQty"],
      vehicleName: json["vehicleName"],
      vehicleNo: json["vehicleNo"],
      stops: json["stops"],
      height: json["height"],
      length: json["length"],
      payload: json["payload"],
      topSpeed: json["topSpeed"],
      startTime: json["startTime"].runtimeType == DateTime
          ? json["startTime"]
          : DateTime.parse(json["startTime"]),
      endTime: json["endTime"].runtimeType == DateTime
          ? json["endTime"]
          : DateTime.parse(json["endTime"]),
      dropLocationNameList: List<RouteStep>.from(
          json["dropLocationNameList"].map((x) => RouteStep.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicleId": vehicleId,
        "isJobActivated": isJobActivated,
        "vehicleNo": vehicleNo,
        "isDropDownMenuOpen": isDropDownMenuOpen,
        "isItemSelected": isItemSelected,
        "vehicleQty": vehicleQty,
        "vehicleName": vehicleName,
        "stops": stops,
        "height": height,
        "length": length,
        "payload": payload,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "topSpeed": topSpeed,
        "dropLocationNameList":
            List<dynamic>.from(dropLocationNameList.map((x) => x.toJson())),
      };
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobModel &&
          runtimeType == other.runtimeType &&
          vehicleId == other.vehicleId;

  @override
  int get hashCode => id.hashCode;
}

class LocationTimeModel {
  final String time;
  final String locationName;

  LocationTimeModel({
    required this.time,
    required this.locationName,
  });

  factory LocationTimeModel.fromJson(Map<String, dynamic> json) =>
      LocationTimeModel(
        time: json["time"],
        locationName: json["locationName"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "locationName": locationName,
      };
}

Job jobFromJson(String str) => Job.fromJson(json.decode(str));

String jobToJson(Job data) => json.encode(data.toJson());

class Job {
  final String description;
  final List<double> location;
  final int id;
  final List<int> delivery;
  final int priority;
  final List<List<int>> timeWindows;
  final int service;

  Job({
    required this.description,
    required this.location,
    required this.id,
    required this.delivery,
    required this.priority,
    required this.timeWindows,
    required this.service,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        description: json["description"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        id: json["id"],
        delivery: List<int>.from(json["delivery"].map((x) => x)),
        priority: json["priority"],
        timeWindows: List<List<int>>.from(
            json["time_windows"].map((x) => List<int>.from(x.map((x) => x)))),
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "location": List<dynamic>.from(location.map((x) => x)),
        "id": id,
        "delivery": List<dynamic>.from(delivery.map((x) => x)),
        "priority": priority,
        "time_windows": List<dynamic>.from(
            timeWindows.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "service": service,
      };
}

Vehicles vehiclesFromJson(String str) => Vehicles.fromJson(json.decode(str));

String vehiclesToJson(Vehicles data) => json.encode(data.toJson());

class Vehicles {
  final List<int> capacity;
  final List<double> end;
  final String endDescription;
  final int id;
  final String profile;
  final double speedFactor;
  final List<double> start;
  final String startDescription;

  Vehicles({
    required this.capacity,
    required this.end,
    required this.endDescription,
    required this.id,
    required this.profile,
    required this.speedFactor,
    required this.start,
    required this.startDescription,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        capacity: List<int>.from(json["capacity"].map((x) => x)),
        end: List<double>.from(json["end"].map((x) => x?.toDouble())),
        endDescription: json["endDescription"],
        id: json["id"],
        profile: json["profile"],
        speedFactor: json["speed_factor"]?.toDouble(),
        start: List<double>.from(json["start"].map((x) => x?.toDouble())),
        startDescription: json["startDescription"],
      );

  Map<String, dynamic> toJson() => {
        "capacity": List<dynamic>.from(capacity.map((x) => x)),
        "end": List<dynamic>.from(end.map((x) => x)),
        "endDescription": endDescription,
        "id": id,
        "profile": profile,
        "speed_factor": speedFactor,
        "start": List<dynamic>.from(start.map((x) => x)),
        "startDescription": startDescription,
      };
}
