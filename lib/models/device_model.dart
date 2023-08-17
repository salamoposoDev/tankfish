// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'package:tank_fish/models/device_info.dart';
import 'dart:convert';

import 'package:tank_fish/models/sensors_model.dart';

class SensorDevice {
  final Sensors? sensors;
  final String? name;
  final DeviceInfo? deviceInfo;
  final int? timestamp;

  SensorDevice({
    this.sensors,
    this.name,
    this.deviceInfo,
    this.timestamp,
  });

  factory SensorDevice.fromRawJson(String str) =>
      SensorDevice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SensorDevice.fromJson(Map<String, dynamic> json) => SensorDevice(
        sensors: Sensors.fromJson(json["sensors"]),
        name: json["name"],
        deviceInfo: DeviceInfo.fromJson(json["deviceInfo"]),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "sensors": sensors!.toJson(),
        "name": name,
        "deviceInfo": deviceInfo!.toJson(),
        "timestamp": timestamp,
      };
}
