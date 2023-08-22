import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tank_fish/history_page/bar_chart.dart';

final childPathProvider = StateProvider<String>((ref) => 's-E0:5A:1B:A1:61:F0');
final selectedTankProvider = StateProvider<String>((ref) => 'Tank Kakap 1');
final selectedLockProvider = StateProvider<bool>((ref) => false);

final selectedSensorValueProvider = StateProvider.autoDispose<int>((ref) => 0);
final loadingProvider = StateProvider.autoDispose<bool>((ref) => true);
final loadingDashProvider = StateProvider<bool>((ref) => true);
final minMaxProvider =
    StateProvider.autoDispose<List<double>>((ref) => [10, 60]);

final sensorNameProvider = StateProvider.autoDispose<String>((ref) => 'Suhu');

final selectedSortProvider =
    StateProvider.autoDispose<String>((ref) => 'Hari ini');

final chartDataProvider = StateProvider.autoDispose<List<dynamic>>((ref) => []);
