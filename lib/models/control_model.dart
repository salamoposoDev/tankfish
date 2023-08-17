import 'dart:convert';

class Control {
  final int servoDelay;
  final int restart;
  final int servo;

  Control({
    required this.servoDelay,
    required this.restart,
    required this.servo,
  });

  factory Control.fromRawJson(String str) => Control.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Control.fromJson(Map<String, dynamic> json) => Control(
        servoDelay: json["servoDelay"],
        restart: json["restart"],
        servo: json["servo"],
      );

  Map<String, dynamic> toJson() => {
        "servoDelay": servoDelay,
        "restart": restart,
        "servo": servo,
      };
}
