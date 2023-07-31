import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_fish/models/device_info.dart';

class DeviceInfoCubit extends Cubit<DeviceInfo> {
  DatabaseReference databaseReference;

  DeviceInfoCubit()
      : databaseReference = FirebaseDatabase.instance.ref('deviceInfo'),
        super(DeviceInfo());

  void getData() async {
    databaseReference.onValue.listen((event) {
      if (event.snapshot.exists) {
        final jsonString = jsonEncode(event.snapshot.value);
        final jsonData = DeviceInfo.fromJson(json.decode(jsonString));
        emit(jsonData);
      }
    });
  }
}
