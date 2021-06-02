// To parse this JSON data, do
//
//     final airData = airDataFromJson(jsonString);

import 'dart:convert';

AirData airDataFromJson(String str) => AirData.fromJson(json.decode(str));

String airDataToJson(AirData data) => json.encode(data.toJson());

class AirData {
  AirData({
    this.coord,
    this.list,
  });

  Coord coord;
  List<ListElement> list;

  factory AirData.fromJson(Map<String, dynamic> json) => AirData(
        coord: Coord.fromJson(json["coord"]),
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class ListElement {
  ListElement({
    this.main,
    this.components,
    this.dt,
  });

  Main main;
  Map<String, double> components;
  int dt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        main: Main.fromJson(json["main"]),
        components: Map.from(json["components"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        dt: json["dt"],
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "components":
            Map.from(components).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "dt": dt,
      };
}

class Main {
  Main({
    this.aqi,
  });

  int aqi;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json["aqi"],
      );

  Map<String, dynamic> toJson() => {
        "aqi": aqi,
      };
}
