// To parse this JSON data, do
//
//     final automation = automationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:tank_fish/models/control_model.dart';
import 'package:tank_fish/models/device_info.dart';
import 'dart:convert';
import 'package:tank_fish/models/history_schedule_model.dart';
import 'package:tank_fish/models/shcedule_model.dart';

// class AutomationDevices {
//   final AutomationDetail automationDevices;

//   AutomationDevices({
//     required this.automationDevices,
//   });

//   factory AutomationDevices.fromRawJson(String str) =>
//       AutomationDevices.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AutomationDevices.fromJson(Map<String, dynamic> json) =>
//       AutomationDevices(
//         automationDevices:
//             AutomationDetail.fromJson(json["au-A0:B7:65:DD:58:50"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "au-A0:B7:65:DD:58:50": automationDevices.toJson(),
//       };
// }

class AutomationDetail {
  final Schedule? schedule;
  final String? name;
  final Control? control;
  final Map<String, HistorySchedule>? history;
  final DeviceInfo? deviceInfo;

  AutomationDetail({
    this.schedule,
    this.name,
    this.control,
    this.history,
    this.deviceInfo,
  });

  factory AutomationDetail.fromRawJson(String str) =>
      AutomationDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AutomationDetail.fromJson(Map<String, dynamic> json) =>
      AutomationDetail(
        schedule: Schedule.fromJson(json["schedule"]),
        name: json["name"],
        control: Control.fromJson(json["control"]),
        history: Map.from(json["history"]).map((k, v) =>
            MapEntry<String, HistorySchedule>(k, HistorySchedule.fromJson(v))),
        deviceInfo: DeviceInfo.fromJson(json["deviceInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "schedule": schedule!.toJson(),
        "name": name,
        "control": control!.toJson(),
        "history": Map.from(history!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "deviceInfo": deviceInfo!.toJson(),
      };
}
