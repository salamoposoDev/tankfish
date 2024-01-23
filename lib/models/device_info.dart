import 'dart:convert';

class DeviceInfo {
  final int? rssi;
  final String? name;
  final String? ipAddr;
  final String? macAddr;

  DeviceInfo({
    this.rssi,
    this.name,
    this.ipAddr,
    this.macAddr,
  });

  factory DeviceInfo.fromRawJson(String str) =>
      DeviceInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
        rssi: json["rssi"] ?? 0,
        name: json["name"] ?? '',
        ipAddr: json["ipAddr"] ?? '',
        macAddr: json["macAddr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "rssi": rssi,
        "name": name,
        "ipAddr": ipAddr,
        "macAddr": macAddr,
      };
}
