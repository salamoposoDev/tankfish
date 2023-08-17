import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tank_fish/models/device_info.dart';
import 'package:tank_fish/models/history_schedule_model.dart';
import 'package:tank_fish/models/sensors_model.dart';

final sensorsStreamProvider =
    StreamProvider.family<Sensors, String>((ref, sensorsPath) {
  return FirebaseDatabase.instance
      .ref('sensors/$sensorsPath/sensors')
      .onValue
      .map((event) {
    if (event.snapshot.value != null) {
      final jsonString = jsonEncode(event.snapshot.value);
      final data = Sensors.fromJson(json.decode(jsonString));
      return data;
    } else {
      return Sensors();
    }
  });
});

final getDeviceInfoProvider =
    StreamProvider.family<DeviceInfo, String>((ref, sensorsPath) {
  return FirebaseDatabase.instance
      .ref('sensors/$sensorsPath/deviceInfo')
      .onValue
      .map((event) {
    if (event.snapshot.value != null) {
      final jsonString = jsonEncode(event.snapshot.value);
      final data = DeviceInfo.fromJson(json.decode(jsonString));
      return data;
    } else {
      return DeviceInfo();
    }
  });
});

final getScheduleProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
        (ref, sensorsPath) async {
  final ref = await FirebaseDatabase.instance
      .ref('automation/$sensorsPath/schedule')
      .once();

  if (ref.snapshot.exists) {
    final jsonString = jsonEncode(ref.snapshot.value);

    Map<String, dynamic> jsonData = json.decode(jsonString);

    List<Map<String, dynamic>> timeDataList = [];

    jsonData.forEach((key, value) {
      if (value is Map<String, dynamic> &&
          value.containsKey("amount") &&
          value.containsKey("time")) {
        int amount = value["amount"];
        String time = value["time"];

        Map<String, dynamic> timeDataMap = {
          "amount": amount,
          "time": time,
        };

        timeDataList.add(timeDataMap);
      }
    });

    return timeDataList;
  } else {
    return [];
  }
});

final getHistoryScheduleProvider =
    StreamProvider.family<List<HistorySchedule>, String>((ref, sensorsPath) {
  final stream = FirebaseDatabase.instance
      .ref()
      .child('automation/$sensorsPath/history')
      .onValue;

  return stream.map((event) {
    if (event.snapshot.value != null) {
      final jsonData = event.snapshot.value;

      List<HistorySchedule> historyScheduleList = [];

      Map<dynamic, dynamic> map = jsonData as Map<dynamic, dynamic>;
      List<dynamic> dataList = map.values.toList();

      for (var data in dataList) {
        HistorySchedule historySchedule = HistorySchedule(
          servoDelay: data['servoDelay'],
          timeRtc: data['timeRtc'],
          time: data['time'],
          amount: data['amount'],
        );
        historyScheduleList.add(historySchedule);
      }
      return historyScheduleList;
    }
    return [];
  });
});
