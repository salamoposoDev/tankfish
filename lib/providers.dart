import 'package:flutter_riverpod/flutter_riverpod.dart';

final childPathProvider = StateProvider<String>((ref) => 's-A0:B7:65:DC:42:F0');
final selectedTankProvider = StateProvider<String>((ref) => 'Tank Lele 1');
final selectedLockProvider = StateProvider<bool>((ref) => false);

final selectedSensorValueProvider = StateProvider.autoDispose<int>((ref) => 0);
final loadingProvider = StateProvider<bool>((ref) => false);
final minMaxProvider =
    StateProvider.autoDispose<List<double>>((ref) => [10, 60]);

final sensorNameProvider = StateProvider.autoDispose<String>((ref) => 'Suhu');
