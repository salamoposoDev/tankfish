import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ... The LiveData class remains the same ...

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}

final realtimeChartProvider =
    StateNotifierProvider.autoDispose<RealtimeChartController, List<LiveData>>(
        (ref) {
  return RealtimeChartController();
});

class RealtimeChartController extends StateNotifier<List<LiveData>> {
  RealtimeChartController() : super(<LiveData>[]);

  late Timer _timer;
  int _time = 19;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => updateDataSource());
  }

  void updateDataSource() {
    state = [
      ...state,
      LiveData(_time++, (math.Random().nextInt(60) + 30)),
    ];
    if (state.length > 18) {
      state = state.sublist(1);
    }
  }
}
