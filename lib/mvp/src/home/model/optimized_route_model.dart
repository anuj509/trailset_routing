import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

OptimizedRouteModel optimizedRouteModelFromJson(String str) =>
    OptimizedRouteModel.fromJson(json.decode(str));

String optimizedRouteModelToJson(OptimizedRouteModel data) =>
    json.encode(data.toJson());

class OptimizedRouteModel {
  final int code;
  final Summary? summary;
  final List<Unassigned> unassigned;
  List<Summary> routes;

  OptimizedRouteModel({
    required this.code,
    this.summary,
    required this.unassigned,
    required this.routes,
  });

  factory OptimizedRouteModel.fromJson(Map<String, dynamic> json) =>
      OptimizedRouteModel(
        code: json["code"],
        summary: Summary.fromJson(json["summary"]),
        unassigned: json["unassigned"] == null
            ? []
            : List<Unassigned>.from(
                json["unassigned"].map((x) => Unassigned.fromJson(x))),
        routes:
            List<Summary>.from(json["routes"].map((x) => Summary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "summary": summary!.toJson(),
        "unassigned": List<dynamic>.from(unassigned.map((x) => x.toJson())),
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Summary {
  int id;
  int vehicleId;
  final int? vehicle;
  final int cost;
  final List<int> delivery;
  final List<int> amount;
  final List<int> pickup;
  final int setup;
  final int service;
  final int duration;
  final int waitingTime;
  final int priority;
  final int distance;
  final List<RouteStep>? steps;
  final List<dynamic> violations;
  final String? geometry;
  final int? routes;
  final int? unassigned;
  final ComputingTimes? computingTimes;
  List<PointLatLng> polylines;
  Color color;
  bool isVisible;

  Summary({
    this.id = 500,
    this.vehicleId = 500,
    this.vehicle,
    this.color = Colors.transparent,
    this.polylines = const [],
    required this.cost,
    required this.delivery,
    required this.amount,
    required this.pickup,
    required this.setup,
    required this.service,
    required this.duration,
    required this.waitingTime,
    required this.priority,
    required this.distance,
    this.steps,
    required this.violations,
    this.geometry,
    this.routes,
    this.unassigned,
    this.computingTimes,
    this.isVisible = true,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        vehicle: json["vehicle"],
        cost: json["cost"],
        delivery: List<int>.from(json["delivery"].map((x) => x)),
        amount: List<int>.from(json["amount"].map((x) => x)),
        pickup: List<int>.from(json["pickup"].map((x) => x)),
        setup: json["setup"],
        service: json["service"],
        duration: json["duration"],
        waitingTime: json["waiting_time"],
        priority: json["priority"],
        distance: json["distance"],
        steps: json["steps"] == null
            ? []
            : List<RouteStep>.from(
                json["steps"]!.map((x) => RouteStep.fromJson(x))),
        violations: List<dynamic>.from(json["violations"].map((x) => x)),
        geometry: json["geometry"],
        routes: json["routes"],
        unassigned: json["unassigned"],
        computingTimes: json["computing_times"] == null
            ? null
            : ComputingTimes.fromJson(json["computing_times"]),
      );

  Map<String, dynamic> toJson() => {
        "vehicle": vehicle,
        "cost": cost,
        "delivery": List<dynamic>.from(delivery.map((x) => x)),
        "amount": List<dynamic>.from(amount.map((x) => x)),
        "pickup": List<dynamic>.from(pickup.map((x) => x)),
        "setup": setup,
        "service": service,
        "duration": duration,
        "waiting_time": waitingTime,
        "priority": priority,
        "distance": distance,
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "violations": List<dynamic>.from(violations.map((x) => x)),
        "geometry": geometry,
        "routes": routes,
        "unassigned": unassigned,
        "computing_times": computingTimes?.toJson(),
      };
}

class ComputingTimes {
  final int loading;
  final int solving;
  final int routing;

  ComputingTimes({
    required this.loading,
    required this.solving,
    required this.routing,
  });

  factory ComputingTimes.fromJson(Map<String, dynamic> json) => ComputingTimes(
        loading: json["loading"],
        solving: json["solving"],
        routing: json["routing"],
      );

  Map<String, dynamic> toJson() => {
        "loading": loading,
        "solving": solving,
        "routing": routing,
      };
}

class RouteStep {
  final String type;
  final List<double> location;
  final int setup;
  final int service;
  final int waitingTime;
  final List<int> load;
  final int arrival;
  int duration;
  int totalTravelDuration;
  final List<dynamic> violations;
  final int distance;
  final String? description;
  final int? id;
  final int? job;
  int priority;
  DateTime startTime;
  DateTime endTime;
  int serviceTime;
  GlobalKey? globalKey;

  RouteStep({
    required this.type,
    this.globalKey,
    required this.location,
    required this.setup,
    required this.service,
    required this.waitingTime,
    required this.load,
    required this.arrival,
    required this.duration,
    required this.totalTravelDuration,
    required this.violations,
    required this.distance,
    this.description,
    this.id,
    this.job,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.serviceTime,
  });

  // Implement custom equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RouteStep &&
        other.type == type &&
        listEquals(other.location, location) &&
        other.setup == setup &&
        other.service == service &&
        other.waitingTime == waitingTime &&
        listEquals(other.load, load) &&
        other.arrival == arrival &&
        other.duration == duration &&
        listEquals(other.violations, violations) &&
        other.distance == distance &&
        other.description == description &&
        other.id == id &&
        other.job == job &&
        other.priority == priority &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.serviceTime == serviceTime;
  }

  @override
  int get hashCode {
    return Object.hash(
      type,
      Object.hashAll(location),
      setup,
      service,
      waitingTime,
      Object.hashAll(load),
      arrival,
      duration,
      Object.hashAll(violations),
      distance,
      description,
      id,
      job,
      priority,
      startTime,
      endTime,
      serviceTime,
    );
  }

  factory RouteStep.fromJson(Map<String, dynamic> json) => RouteStep(
        type: json["type"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        setup: json["setup"],
        service: json["service"],
        waitingTime: json["waiting_time"],
        load: List<int>.from(json["load"].map((x) => x)),
        arrival: json["arrival"],
        duration: json["duration"],
        violations: List<dynamic>.from(json["violations"].map((x) => x)),
        distance: json["distance"],
        description: json["description"],
        id: json["id"],
        job: json["job"],
        priority: json["priority"] ?? 0,
        totalTravelDuration: json["totalTravelDuration"] ?? 0,
        startTime: json["start_time"] ?? DateTime.now(),
        endTime: json["end_time"] ?? DateTime.now(),
        serviceTime: json["service_time"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "location": List<dynamic>.from(location.map((x) => x)),
        "setup": setup,
        "service": service,
        "waiting_time": waitingTime,
        "load": List<dynamic>.from(load.map((x) => x)),
        "arrival": arrival,
        "duration": duration,
        "violations": List<dynamic>.from(violations.map((x) => x)),
        "distance": distance,
        "description": description,
        "id": id,
        "job": job,
        "priority": priority,
        "start_time": startTime,
        "end_time": endTime,
        "service_time": serviceTime,
        "totalTravelDuration": totalTravelDuration
      };
}

class Unassigned {
  final String description;
  final int id;
  final List<double> location;
  final String type;

  Unassigned({
    required this.description,
    required this.id,
    required this.location,
    required this.type,
  });

  factory Unassigned.fromJson(Map<String, dynamic> json) => Unassigned(
        description: json["description"],
        id: json["id"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "location": List<dynamic>.from(location.map((x) => x)),
        "type": type,
      };
}
