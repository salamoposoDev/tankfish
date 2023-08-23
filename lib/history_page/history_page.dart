import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/widgets/tankfish_dropdown.dart';
import 'package:tank_fish/history_page/helper/sensor_data_calculator.dart';
import 'package:tank_fish/history_page/history_detail_page.dart';
import 'package:tank_fish/history_page/sensor_card_history.dart';
import 'package:tank_fish/providers.dart';
import 'package:tank_fish/providers/stream_data_sensor.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final item = List.generate(10, (index) => '2$index');

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
  final backroundColor = [
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.blue.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    // final sensorData =
    //     FirebaseDatabase.instance.ref('sensors/s-A0:B7:65:DC:5C:44/history');
    // sensorData.onValue.listen((event) {
    //   if (event.snapshot.exists) {
    //     final jsonData = jsonEncode(event.snapshot.value);
    //     // Parse the JSON data into a Map
    //     Map<String, dynamic> dataMap = json.decode(jsonData);

    //     int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    //     List<Map<String, dynamic>> todayDataList = [];

    //     dataMap.forEach((key, value) {
    //       int timestamp = value['time'];
    //       DateTime dateTime =
    //           DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    //       if (dateTime.year == DateTime.now().year &&
    //           dateTime.month == DateTime.now().month &&
    //           dateTime.day == DateTime.now().day) {
    //         todayDataList.add(value);
    //       }
    //     });

    //     // log('Data for today: ${todayDataList.length}');

    //     // log(jsonData.toString());
    //   }
    // });
    final idAndNameList = ref.watch(idAndNamePathProvider);
    final selectedItem = ref.watch(selectedTankProvider);
    final selectedPath = ref.watch(childPathProvider);
    final sensorsHistory = ref.watch(getTodayHistorySensor(selectedPath));
    if (idAndNameList.isLoading || sensorsHistory.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final temp = [];
    final hum = [];
    final watertemp = [];
    final ph = [];
    final tds = [];
    final oxygen = [];
    final waterLevel = [];
    final timeStamp = [];

    // log(searchResults.first.time.toString());

    for (var data in sensorsHistory.asData!.value) {
      timeStamp.add(data.time);
      temp.add(data.temp);
      hum.add(data.hum);
      watertemp.add(data.waterTemp);
      ph.add(data.ph);
      tds.add(data.tds);
      oxygen.add(data.oxygen);
      waterLevel.add(data.waterLevel);
    }
    // log(sensorsHistory.toString());
    // log(sensorsHistory.asData!.value.first.hum.toString());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TankFisDropdown(
                      onSelect: (value) {
                        var index = int.parse(value);
                        final selectedValue =
                            idAndNameList.asData!.value[index]['id'];

                        ref.read(selectedTankProvider.notifier).state =
                            idAndNameList.asData!.value[index]['name'];
                        ref
                            .read(childPathProvider.notifier)
                            .update((state) => selectedValue);
                      },
                      selectedItem: selectedItem,
                      idAndName: idAndNameList.asData!.value,
                    ),
                    Text(
                      'History',
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // HistoryChart(),
                AnimatedList(
                  initialItemCount: sensor.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index, animation) {
                    final lastUpdate = checkRelativeTime(timeStamp.first);
                    final maxTemp = SensorDataCalculator.calculateMax(temp);
                    final minTemp = SensorDataCalculator.calculateMin(temp);
                    final avTemp = SensorDataCalculator.calculateAverage(temp);

                    final maxHum = SensorDataCalculator.calculateMax(hum);
                    final minHum = SensorDataCalculator.calculateMin(hum);
                    final avHum = SensorDataCalculator.calculateAverage(hum);

                    final maxWaterTemp =
                        SensorDataCalculator.calculateMax(watertemp);
                    final minWaterTemp =
                        SensorDataCalculator.calculateMin(watertemp);
                    final avWaterTemp =
                        SensorDataCalculator.calculateAverage(watertemp);

                    final maxPh = SensorDataCalculator.calculateMax(ph);
                    final minPh = SensorDataCalculator.calculateMin(ph);
                    final avPh = SensorDataCalculator.calculateAverage(ph);

                    final maxTds = SensorDataCalculator.calculateMax(tds);
                    final minTds = SensorDataCalculator.calculateMin(tds);
                    final avTds = SensorDataCalculator.calculateAverage(tds);

                    final maxOx = SensorDataCalculator.calculateMax(oxygen);
                    final minOx = SensorDataCalculator.calculateMin(oxygen);
                    final avOx = SensorDataCalculator.calculateAverage(oxygen);

                    final maxWaterLevel =
                        SensorDataCalculator.calculateMax(waterLevel);
                    final minWaterLevel =
                        SensorDataCalculator.calculateMin(waterLevel);
                    final avOxWaterLevel =
                        SensorDataCalculator.calculateAverage(waterLevel);

                    final sensorCalculated = [
                      {'max': maxTemp, 'min': minTemp, 'av': avTemp},
                      {
                        'max': maxWaterTemp,
                        'min': minWaterTemp,
                        'av': avWaterTemp
                      },
                      {'max': maxHum, 'min': minHum, 'av': avHum},
                      {'max': maxPh, 'min': minPh, 'av': avPh},
                      {'max': maxTds, 'min': minTds, 'av': avTds},
                      {'max': maxOx, 'min': minOx, 'av': avOx},
                      {
                        'max': maxWaterLevel,
                        'min': minWaterLevel,
                        'av': avOxWaterLevel
                      },
                    ];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: historySensorCard(
                        logo: sensor[index]['logo'].toString(),
                        name: sensor[index]['name'].toString(),
                        symbol: sensor[index]['symbol'].toString(),
                        average:
                            sensorCalculated[index]['av'].toStringAsFixed(2),
                        maxValue: sensorCalculated[index]['max'].toString(),
                        minValue: sensorCalculated[index]['min'].toString(),
                        totalData: sensorsHistory.asData?.value.length,
                        lastUpdate: lastUpdate,
                        backgroundColor: backroundColor[index],
                        onTab: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryDetailPage(
                                      id: selectedPath,
                                      sensorName:
                                          sensor[index]['name'].toString(),
                                    )),
                          );
                        },
                      ),
                    );
                  },
                ),
                // historySensorCard(
                //   backgroundColor: Colors.blue.shade50,
                //   onTab: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => HistoryDetailPage()),
                //     );
                //   },
                // ),
                // SizedBox(height: 16.h),
                // historySensorCard(
                //   backgroundColor: Colors.orange.shade50,
                // ),
                // SizedBox(height: 16.h),
                // historySensorCard(
                //   backgroundColor: Colors.red.shade50,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

dynamic maxValue(dynamic valueSensor) {
  return valueSensor
      .reduce((value, element) => value > element ? value : element);
}

String checkRelativeTime(int timestamp) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  int differenceInDays = now.difference(dateTime).inDays;

  if (differenceInDays == 0) {
    String formattedTime = DateFormat.Hm().format(dateTime);
    return 'Hari ini, $formattedTime';
  } else if (differenceInDays == 1) {
    return 'Kemarin';
  } else if (differenceInDays < 4) {
    String formattedTime = DateFormat('EEEE').format(dateTime);
    return formattedTime;
  } else {
    String formattedTime = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedTime;
  }
}
