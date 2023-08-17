import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_fish/models/shcedule_model.dart';

class GetScheduleCubit extends Cubit<List<Map<String, dynamic>>> {
  DatabaseReference dbRef;
  StreamSubscription? _subscription;

  GetScheduleCubit()
      : dbRef = FirebaseDatabase.instance.ref('automation/'),
        super([]);
  Future<void> getData(String path) async {
    try {
      dbRef.child('$path/schedule').onValue.listen((event) {
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
              // log(timeDataList.toString());
            }
          });
          emit(timeDataList);
        }
      });
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
