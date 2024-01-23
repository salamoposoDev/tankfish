import 'dart:convert';

class HistorySchedule {
  final int? servoDelay;
  final String? timeRtc;
  final int? time;
  final int? amount;

  HistorySchedule({this.servoDelay, this.timeRtc, this.time, this.amount});

  factory HistorySchedule.fromRawJson(String str) =>
      HistorySchedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistorySchedule.fromJson(Map<String, dynamic> json) =>
      HistorySchedule(
        servoDelay: json["servoDelay"],
        timeRtc: json["timeRtc"],
        time: json["time"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "servoDelay": servoDelay,
        "timeRtc": timeRtc,
        "time": time,
        "amount": amount,
      };
}
