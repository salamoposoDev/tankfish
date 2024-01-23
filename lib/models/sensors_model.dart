import 'dart:convert';

class Sensors {
  final int? hum;
  final int? turbidity;
  final int? tds;
  final int? temp;
  final double? waterTemp;
  final double? ph;
  final int? time;
  final int? waterLevel;
  final int? oxygen;

  Sensors({
    this.hum,
    this.turbidity,
    this.tds,
    this.temp,
    this.waterTemp,
    this.ph,
    this.time,
    this.waterLevel,
    this.oxygen,
  });

  factory Sensors.fromRawJson(String str) => Sensors.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sensors.fromJson(Map<String, dynamic> json) => Sensors(
        hum: json["hum"] ?? 0,
        turbidity: json["turbidity"] ?? 0,
        tds: json["tds"] ?? 0,
        temp: json["temp"] ?? 0,
        waterTemp: json["waterTemp"]?.toDouble() ?? 0,
        ph: json["ph"]?.toDouble() ?? 0,
        time: json["time"] ?? 0,
        waterLevel: json["waterLevel"] ?? 0,
        oxygen: json["oxygen"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "hum": hum,
        "turbidity": turbidity,
        "tds": tds,
        "temp": temp,
        "waterTemp": waterTemp,
        "ph": ph,
        "time": time,
        "waterLevel": waterLevel,
        "oxygen": oxygen,
      };
}
