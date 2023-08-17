import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tank_fish/providers.dart';
import 'package:tank_fish/providers/stream_data_sensor.dart';
import 'package:tank_fish/sensors/widgets/sensor_card.dart';

class SensorCardList extends ConsumerStatefulWidget {
  const SensorCardList({
    required this.onSelected,
    super.key,
  });
  final void Function(String, dynamic) onSelected;

  @override
  ConsumerState<SensorCardList> createState() => _SensorCardListState();
}

class _SensorCardListState extends ConsumerState<SensorCardList> {
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
      'symbol': 'mg/L',
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
  @override
  Widget build(BuildContext context) {
    final path = ref.watch(childPathProvider);
    final sensorValue = ref.watch(sensorsStreamProvider(path));

    if (sensorValue.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
          clipBehavior: Clip.none,
          itemCount: sensor.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final value = [
              sensorValue.value?.temp,
              sensorValue.value?.waterTemp?.toInt(),
              sensorValue.value?.hum,
              sensorValue.value?.ph,
              sensorValue.value?.tds,
              sensorValue.value!.oxygen! / 1000,
              sensorValue.value?.waterLevel,
            ];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: InkWell(
                onTap: () {
                  ispress = !ispress;
                  activeIndex = index;
                  ref.read(selectedSensorValueProvider.notifier).state =
                      value[index]!.toInt();
                  widget.onSelected(
                      sensor[index]['name'].toString(), value[index]);
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SensorcCard(
                    isPressed: activeIndex == index ? true : false,
                    name: sensor[index]['name'].toString(),
                    value: value[index].toString(),
                    symbol: sensor[index]['symbol'].toString(),
                    logo: sensor[index]['logo'].toString(),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
