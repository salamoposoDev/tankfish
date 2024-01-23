import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_fish/models/automation_models.dart';

class GetAutomationCubit extends Cubit<AutomationDetail> {
  DatabaseReference dbRef;
  StreamSubscription? _subscription;

  GetAutomationCubit()
      : dbRef = FirebaseDatabase.instance.ref('automation/'),
        super(AutomationDetail());

  Future<void> getData(String path) async {
    if (_subscription != null && _subscription!.isPaused) {
      _subscription!.resume();
    } else {
      try {
        _subscription = dbRef.child(path).onValue.listen((event) {
          if (event.snapshot.exists) {
            final jsonData = jsonEncode(event.snapshot.value);
            final data = AutomationDetail.fromJson(json.decode(jsonData));
            emit(data);
          } else {
            emit(AutomationDetail());
          }
        });
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
