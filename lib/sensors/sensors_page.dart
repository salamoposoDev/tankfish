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

  final sensor = [
    {
      'name': 'Suhu',
      'value': 30,
      'status': 'Normal',
      'symbol': '°C',
      'logo': 'lib/icons/temp2.png'
    },
    {
      'name': 'Suhu Air',
      'value': 27,
      'status': 'Normal',
      'symbol': '°C',
      'logo': 'lib/icons/water_temp.png'
    },
    {
      'name': 'Kelembapan',
      'value': 70,
      'status': 'Normal',
      'symbol': '%',
      'logo': 'lib/icons/hum2.png'
    },
    {
      'name': 'PH',
      'value': 7.1,
      'status': 'Normal',
      'symbol': '',
      'logo': 'lib/icons/ph_logo.png'
    },
    {
      'name': 'TDS',
      'value': 600,
      'status': 'Normal',
      'symbol': 'ppm',
      'logo': 'lib/icons/ppm.png'
    },
    {
      'name': 'Oksigen',
      'value': 120,
      'status': 'Normal',
      'symbol': '%',
      'logo': 'lib/icons/oxi.png'
    },
    {
      'name': 'Level Air',
      'value': 80,
      'status': 'Normal',
      'symbol': '%',
      'logo': 'lib/icons/water_level.png'
    },
  ];

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
    final minMaxValue = ref.watch(minMaxProvider);
    final sensorName = ref.watch(sensorNameProvider);

    if (sensorValue.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!loading) {
      Future.delayed(Duration.zero, () {
        // Perform initialization or actions after the widget tree is done building

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
