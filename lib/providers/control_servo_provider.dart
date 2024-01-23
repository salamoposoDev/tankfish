import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod/riverpod.dart';

final getServoStatusProvider = StateProvider.family<int, String>((ref, path) {
  final dbRef = FirebaseDatabase.instance.ref('automation/$path/control/servo');

  dbRef.onValue.listen((event) {
    if (event.snapshot.exists) {
      int data = event.snapshot.value as int;
      ref.controller.state = data;
    }
  });

  // Return default value, misalnya 0 jika belum ada data dari Firebase.
  return 0;
});
