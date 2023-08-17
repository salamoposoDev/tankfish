import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_fish/models/device_model.dart';

class getAllDeviceCubit extends Cubit<List<String>> {
  getAllDeviceCubit(super.initialState);
  StreamSubscription? _subscription;

  final deviceName = <String>[];
  final device = <Map<String, dynamic>>[];
  final dbref = FirebaseDatabase.instance.ref('sensors');
  Future<void> getData() async {
    try {
      if (_subscription != null && _subscription!.isPaused) {
        _subscription!.resume();
      } else {
        dbref.onValue.listen((event) {
          deviceName.clear();
          // log(event.snapshot.value.toString());
          if (event.snapshot.exists) {
            // log(event.snapshot.children.first.value.toString());
            for (var i = 0; i < event.snapshot.children.length; i++) {
              final data = event.snapshot.children.toList();
              // log(data[].value.toString());
              deviceName.add(data[i].key.toString());
            }

            log(device.toString());
            emit(deviceName);
          }
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
