import 'dart:developer';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/providers.dart';
import 'package:tank_fish/providers/stream_data_sensor.dart';
import 'package:tank_fish/sensors/realtime_chart.dart';
import 'package:tank_fish/sensors/widgets/sensor_card_list.dart';
import '../dashboard/widgets/tankfish_dropdown.dart';

class SensorPage extends ConsumerWidget {
  SensorPage({super.key});

  late List<LiveData> chartData;
  int activeIndex = 0;
  bool ispress = false;

  final List<String> _dropdownItems = [
    'Tank Lele 1',
    'Tank Lele 2',
    'Tank Udang 1',
    'Tank Udang 2',
    'Tank Kakap 1',
    'Tank Kakap 2'
  ];

  final List<String> _dropdownItemsValue = [
    's-A0:B7:65:DC:42:F0',
    's-A0:B7:65:DD:30:44',
    's-A0:B7:65:DC:5C:44',
    's-A0:B7:65:DD:C8:E8',
    's-E0:5A:1B:A1:61:F0',
    's-A0:B7:65:DC:65:7C'
  ];
  bool loading = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedTankProvider);
    final selectedSensorValue = ref.watch(selectedSensorValueProvider);
    final path = ref.watch(childPathProvider);
    final sensorValue = ref.watch(sensorsStreamProvider(path));
    final sensorName = ref.watch(sensorNameProvider);

    if (sensorValue.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!loading) {
      Future.delayed(Duration.zero, () {
        ref.read(selectedSensorValueProvider.notifier).update((state) {
          return sensorValue.value!.temp!.toInt();
        });
      });
      loading = true;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TankFisDropdown(
                      onSelect: (value) {
                        var index = int.parse(value);
                        final selectedValue = _dropdownItemsValue[index];
                        ref.read(selectedTankProvider.notifier).state =
                            _dropdownItems[index];
                        ref
                            .read(childPathProvider.notifier)
                            .update((state) => selectedValue);
                      },
                      selectedItem: selectedItem,
                      dropdownItems: _dropdownItems,
                      dropdownItemsValue: _dropdownItemsValue),
                  Text(
                    'Sensors',
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            RealtimeChart(
              timestamp: sensorValue.value!.time!,
              sensorValue: selectedSensorValue,
              sensorName: sensorName,
            ),
            SensorCardList(onSelected: (name, value) {
              ref.read(sensorNameProvider.notifier).state = name;
              final nilai = minMax(name);
              ref.read(minMaxProvider.notifier).state = nilai;
              log(nilai.toString());
              log('$name : $value');
            }),
          ],
        ),
      ),
    );
  }
}

List<double> minMax(String? name) {
  List<double> value = [];
  switch (name) {
    case 'Suhu':
      return value = [10, 60];
    case 'Suhu Air':
      return value = [10, 60];
    case 'Kelembapan':
      return value = [10, 100];
    case 'PH':
      return value = [3.5, 11.0];
    case 'TDS':
      return value = [50, 5000];
    case 'Oksigen':
      return value = [0, 100];
    case 'Level Air':
      return value = [0, 100];
  }
  return value;
}
