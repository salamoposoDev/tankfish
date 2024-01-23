import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_fish/models/device_info.dart';
import 'package:tank_fish/models/device_model.dart';
import 'package:tank_fish/models/sensors_model.dart';

class GetSensorDevicesCubit extends Cubit<String> {
  DatabaseReference dbref;
  StreamSubscription? _subscription;

  GetSensorDevicesCubit()
      : dbref = FirebaseDatabase.instance.ref('sensors/'),
        super('');

  Future<void> getSensorRealtime(String path) async {
    if (_subscription != null && _subscription!.isPaused) {
      _subscription!.resume();
    } else {
      try {
        dbref.child('$path/sensors').onValue.listen((event) {
          if (event.snapshot.exists) {
            try {
              final jsonString = jsonEncode(event.snapshot.value);
              // log(jsonString);
              // final sensor = Sensors.fromJson(json.decode(jsonString));
              // log(sensor.ph.toString());
              emit(jsonString);
            } catch (e) {
              // Cetak pesan kesalahan atau lakukan tindakan lain yang sesuai
              log("Error parsing data Sensors: $e");
            }
          } else {
            // Data tidak ditemukan di Firebase, emit objek SensorDevice kosong
            emit('');
          }
        });
      } catch (e) {
        log(e.toString());
      }
    }
  }

  // Future<void> getDeviceInfo(String path) async {
  //   if (_subscription != null && _subscription!.isPaused) {
  //     _subscription!.resume();
  //   } else {
  //     try {
  //       dbref.child('$path/deviceInfo').onValue.listen((event) {
  //         if (event.snapshot.exists) {
  //           try {
  //             final jsonString = jsonEncode(event.snapshot.value);

  //             emit(jsonString);
  //           } catch (e) {
  //             // Cetak pesan kesalahan atau lakukan tindakan lain yang sesuai
  //             log("Error parsing data sensors: $e");
  //           }
  //         }
  //       });
  //     } catch (e) {
  //       log(e.toString());
  //     }
  //   }
  // }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
