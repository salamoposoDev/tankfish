class Sensors {
  final dynamic hum;
  final dynamic turbidity;
  final dynamic tds;
  final dynamic temp;
  final dynamic waterTemp;
  final dynamic ph;
  final dynamic time;
  final dynamic waterLevel;
  final dynamic oxygen;

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

  factory Sensors.fromJson(Map<String, dynamic> json) => Sensors(
        hum: json["hum"] ?? 0,
        turbidity: json["turbidity"] ?? 0,
        tds: json["tds"] ?? 0,
        temp: json["temp"] ?? 0,
        waterTemp: json["waterTemp"] ?? 0,
        ph: json["ph"] ?? 0.0,
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
