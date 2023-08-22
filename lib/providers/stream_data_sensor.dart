import 'dart:convert';
import 'dart:developer';
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
    StreamProvider.family<List<Map<String, dynamic>>, String>(
        (ref, sensorsPath) {
  final stream = FirebaseDatabase.instance
      .ref()
      .child('automation/$sensorsPath/schedule')
      .onValue;
  return stream.map(
    (event) {
      if (event.snapshot.exists) {
        final jsonString = jsonEncode(event.snapshot.value);

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
      }
      return [];
    },
  );
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
    return [HistorySchedule()];
  });
});

final idAndNamePathProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final stream = FirebaseDatabase.instance.ref('sensors');
  return stream.onValue.map((event) {
    if (event.snapshot.exists) {
      final jsonData = json.encode(event.snapshot.value);
      Map<String, dynamic> data = json.decode(jsonData);
      List<Map<String, dynamic>> idAndNameList = [];
      data.forEach((key, value) {
        if (value is Map<String, dynamic> &&
            value.containsKey('id') &&
            value.containsKey('name')) {
          idAndNameList.add({'name': value['name'], 'id': value['id']});
        }
        idAndNameList.sort((a, b) => a['name'].compareTo(b['name']));
        // log(idAndNameList.length.toString());
      });
      return idAndNameList;
    } else {
      return [];
    }
  });
});

final getTodayHistorySensor =
    StreamProvider.family<List<Sensors>, String>((ref, path) {
  final stream = FirebaseDatabase.instance.ref('sensors/');
  return stream.child('$path/history').onValue.map((event) {
    if (event.snapshot.exists) {
      // final historyList = [];
      // for (var element in event.snapshot.children) {
      //   historyList.add(element.value);
      //   // log(historyList.length.toString());
      // }
      // final jsonString = jsonEncode(historyList);
      // final jsonData = jsonDecode(jsonString);
      // List<Sensors> historySensor = (jsonData as List)
      //     .map((itemWord) => Sensors.fromJson(itemWord))
      //     .toList();

      // return historySensor;
      final jsonData = jsonEncode(event.snapshot.value);
      Map<String, dynamic> dataMap = json.decode(jsonData);

      int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      List<Sensors> todayDataList = [];

      dataMap.forEach((key, value) {
        int timestamp = value['time'];
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
        if (DateTime.now().hour.toString() == '0') {
          if (dateTime.year == DateTime.now().year &&
              dateTime.month == DateTime.now().month &&
              dateTime.day == 21) {
            todayDataList.add(Sensors.fromJson(value));
          }
        } else {
          if (dateTime.year == DateTime.now().year &&
              dateTime.month == DateTime.now().month &&
              dateTime.day == DateTime.now().day) {
            todayDataList.add(Sensors.fromJson(value));
          }
        }
      });
      return todayDataList;
    } else {
      return [];
    }
  });
});

final getDetailSensorsHistory =
    StreamProvider.family<Map<String, dynamic>, String>((ref, path) {
  final stream = FirebaseDatabase.instance.ref('sensors/');
  return stream.child('$path/history').onValue.map((event) {
    if (event.snapshot.exists) {
      final jsonData = jsonEncode(event.snapshot.value);
      Map<String, dynamic> dataMap = json.decode(jsonData);
      return dataMap;
    } else {
      return {};
    }
  });
});
