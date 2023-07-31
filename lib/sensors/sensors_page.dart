import 'dart:developer';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/screens/bloc/get_sensors_realtime_bolc.dart';
import 'package:tank_fish/models/realtime_sensors.dart';
import 'package:tank_fish/sensors/realtime_chart.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  late List<LiveData> chartData;
  int activeIndex = 0;
  bool ispress = false;

  @override
  void initState() {
    chartData = getChartData();
    super.initState();
  }

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Text(
                'Realtime Sensors',
                style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.midnightBlue),
              ),
            ),

            BlocBuilder<RealtimeSensorCubit, Sensors>(builder: (context, data) {
              List sensorData = [];
              sensorData.addAll([
                data.temp,
                data.waterTemp,
                data.hum,
                data.ph,
                data.tds,
                data.oxygen,
                data.waterLevel,
              ]);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    clipBehavior: Clip.none,
                    itemCount: sensor.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ispress = !ispress;
                              activeIndex = index;
                            });
                          },
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: SensorcCard(
                              isPressed: activeIndex == index ? true : false,
                              name: sensor[index]['name'].toString(),
                              value: sensorData[index].toString(),
                              symbol: sensor[index]['symbol'].toString(),
                              logo: sensor[index]['logo'].toString(),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94),
    ];
  }
}

class SensorcCard extends StatelessWidget {
  const SensorcCard({
    super.key,
    this.logo,
    this.value,
    this.status,
    this.name,
    this.symbol,
    this.isPressed = false,
  });
  final String? logo;
  final String? value;
  final String? status;
  final String? name;
  final String? symbol;
  final bool? isPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: isPressed! ? Colors.orange.shade100 : Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (isPressed!)
            BoxShadow(
              blurRadius: 7,
              offset: const Offset(5, 5),
              color: isPressed! ? Colors.grey.shade500 : Colors.blue.shade200,
            ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? 'Suhu',
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value ?? '0',
                      style: GoogleFonts.roboto(
                          fontSize: isPressed! ? 30.sp : 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade800),
                    ),
                    Text(
                      ' $symbol',
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.midnightBlue),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status ?? 'normal',
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800),
                ),
                Image.asset(
                  logo!,
                  height: 45.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
