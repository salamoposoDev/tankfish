import 'dart:convert';

class Schedule {
  final TimeSchedule? time1;
  final TimeSchedule? time2;
  final TimeSchedule? time3;
  final bool? enable;

  Schedule({
    this.time1,
    this.time2,
    this.time3,
    this.enable,
  });

  factory Schedule.fromRawJson(String str) =>
      Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        time1: TimeSchedule.fromJson(json["time1"]),
        time2: TimeSchedule.fromJson(json["time2"]),
        time3: TimeSchedule.fromJson(json["time3"]),
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "time1": time1!.toJson(),
        "time2": time2!.toJson(),
        "time3": time3!.toJson(),
        "enable": enable,
      };
}

class TimeSchedule {
  final int? amount;
  final String? time;

  TimeSchedule({
    this.amount,
    this.time,
  });

  factory TimeSchedule.fromRawJson(String str) =>
      TimeSchedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TimeSchedule.fromJson(Map<String, dynamic> json) => TimeSchedule(
        amount: json["amount"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "time": time,
      };
}
