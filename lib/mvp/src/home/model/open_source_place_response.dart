// To parse this JSON data, do
//
//     final openStreetPaceResponse = openStreetPaceResponseFromJson(jsonString);

import 'dart:convert';

List<OpenStreetPlaceResponse> openStreetPaceResponseFromJson(String str) =>
    List<OpenStreetPlaceResponse>.from(
        json.decode(str).map((x) => OpenStreetPlaceResponse.fromJson(x)));

String openStreetPaceResponseToJson(List<OpenStreetPlaceResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpenStreetPlaceResponse {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String openStreetPaceResponseClass;
  final String type;
  final int placeRank;
  final double importance;
  final String addresstype;
  final String name;
  final String displayName;
  final Address address;
  final List<String> boundingbox;

  OpenStreetPlaceResponse({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.openStreetPaceResponseClass,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addresstype,
    required this.name,
    required this.displayName,
    required this.address,
    required this.boundingbox,
  });

  OpenStreetPlaceResponse copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? openStreetPaceResponseClass,
    String? type,
    int? placeRank,
    double? importance,
    String? addresstype,
    String? name,
    String? displayName,
    Address? address,
    List<String>? boundingbox,
  }) =>
      OpenStreetPlaceResponse(
        placeId: placeId ?? this.placeId,
        licence: licence ?? this.licence,
        osmType: osmType ?? this.osmType,
        osmId: osmId ?? this.osmId,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        openStreetPaceResponseClass:
            openStreetPaceResponseClass ?? this.openStreetPaceResponseClass,
        type: type ?? this.type,
        placeRank: placeRank ?? this.placeRank,
        importance: importance ?? this.importance,
        addresstype: addresstype ?? this.addresstype,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        address: address ?? this.address,
        boundingbox: boundingbox ?? this.boundingbox,
      );

  factory OpenStreetPlaceResponse.fromJson(Map<String, dynamic> json) =>
      OpenStreetPlaceResponse(
        placeId: json["place_id"] ?? 0,
        licence: json["licence"] ?? '',
        osmType: json["osm_type"] ?? '',
        osmId: json["osm_id"] ?? 0,
        lat: json["lat"] ?? '',
        lon: json["lon"] ?? '',
        openStreetPaceResponseClass: json["class"] ?? '',
        type: json["type"] ?? '',
        placeRank: json["place_rank"] ?? 0,
        importance: json["importance"]?.toDouble() ?? 0.0,
        addresstype: json["addresstype"] ?? '',
        name: json["name"] ?? '',
        displayName: json["display_name"] ?? '',
        address: Address.fromJson((json["address"].runtimeType == String
                ? jsonDecode(json["address"])
                : json["address"]) ??
            {}),
        boundingbox: json["boundingbox"] == null
            ? []
            : List<String>.from(json["boundingbox"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "class": openStreetPaceResponseClass,
        "type": type,
        "place_rank": placeRank,
        "importance": importance,
        "addresstype": addresstype,
        "name": name,
        "display_name": displayName,
        "address": address.toJson(),
        "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
      };
}

class Address {
  final String? city;
  final String? county;
  final String stateDistrict;
  final String state;
  final String iso31662Lvl4;
  final String? postcode;
  final String country;
  final String countryCode;
  final String? waterway;
  final String? town;
  final String? hamlet;

  Address({
    this.city,
    this.county,
    required this.stateDistrict,
    required this.state,
    required this.iso31662Lvl4,
    this.postcode,
    required this.country,
    required this.countryCode,
    this.waterway,
    this.town,
    this.hamlet,
  });

  Address copyWith({
    String? city,
    String? county,
    String? stateDistrict,
    String? state,
    String? iso31662Lvl4,
    String? postcode,
    String? country,
    String? countryCode,
    String? waterway,
    String? town,
    String? hamlet,
  }) =>
      Address(
        city: city ?? this.city,
        county: county ?? this.county,
        stateDistrict: stateDistrict ?? this.stateDistrict,
        state: state ?? this.state,
        iso31662Lvl4: iso31662Lvl4 ?? this.iso31662Lvl4,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
        waterway: waterway ?? this.waterway,
        town: town ?? this.town,
        hamlet: hamlet ?? this.hamlet,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"] ?? '',
        county: json["county"] ?? '',
        stateDistrict: json["state_district"] ?? '',
        state: json["state"] ?? '',
        iso31662Lvl4: json["ISO3166-2-lvl4"] ?? '',
        postcode: json["postcode"] ?? '',
        country: json["country"] ?? '',
        countryCode: json["country_code"] ?? '',
        waterway: json["waterway"] ?? '',
        town: json["town"] ?? '',
        hamlet: json["hamlet"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "county": county,
        "state_district": stateDistrict,
        "state": state,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
        "waterway": waterway,
        "town": town,
        "hamlet": hamlet,
      };
}
