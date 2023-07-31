import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_fish/models/realtime_sensors.dart';

class RealtimeSensorCubit extends Cubit<Sensors> {
  final DatabaseReference _databaseReference;

  RealtimeSensorCubit()
      : _databaseReference = FirebaseDatabase.instance.ref('sensors'),
        super(Sensors());

  void getData() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.exists) {
        String dataStr = jsonEncode(event.snapshot.value);

        var realtimeData = Sensors.fromJson(json.decode(dataStr));

        emit(realtimeData);
      }
    });
  }
}
