import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tank_fish/history_page/bar_chart.dart';
import 'package:tank_fish/history_page/helper/sensor_data_calculator.dart';
import 'package:tank_fish/models/sensors_model.dart';
import 'package:tank_fish/providers.dart';
import 'package:tank_fish/providers/stream_data_sensor.dart';

class HistoryDetailPage extends ConsumerStatefulWidget {
  const HistoryDetailPage({
    super.key,
    required this.id,
    required this.sensorName,
  });
  final String id;
  final String sensorName;

  @override
  ConsumerState<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends ConsumerState<HistoryDetailPage> {
  final filterText = ['Hari ini', 'Bulan ini'];
  List<dynamic> myCharData = [];
  int selectedFilter = 0;
  bool loading = true;
  dynamic maxVal = 0;
  dynamic minVal = 0;
  dynamic avVal = 0;
  @override
  Widget build(BuildContext context) {
    final charData = ref.watch(chartDataProvider);
    final selectedSort = ref.watch(selectedSortProvider);
    final detailSensorHis = ref.watch(getDetailSensorsHistory(widget.id));
    if (detailSensorHis.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final shortedDataList =
        shortedList(detailSensorHis.asData!.value, selectedSort);

    // log('${widget.id}, ${widget.sensorName}');

    myCharData = [];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Sensor ${widget.sensorName}',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.sp,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      filterText.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 8.h),
                        child: PilList(
                          onTap: () {
                            setState(() {
                              selectedFilter = index;
                            });
                            ref.read(selectedSortProvider.notifier).state =
                                filterText[index];
                            loading = true;
                          },
                          onSelect: selectedFilter == index ? true : false,
                          text: filterText[index],
                        ),
                      ),
                    ),
                  ),
                  PilList(
                    onTap: () {},
                    text: 'Sort by',
                  ),
                  // DropdownButton(
                  //   hint: Text('Today'),
                  //   items: [
                  //     DropdownMenuItem(
                  //       child: Text('data'),
                  //       // value: ,
                  //     ),
                  //   ],
                  //   onChanged: (value) {},
                  //   underline: Container(),
                  //   iconEnabledColor: Colors.blue,
                  // ),
                ],
              ),
            ),
            HistoryChart(
              sensorName: widget.sensorName,
              chartData: charData,
            ),
            // Divider(
            //   color: Colors.grey,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         children: [
            //           Text(
            //             'Max',
            //             style: GoogleFonts.roboto(),
            //           ),
            //           Text(
            //             maxVal.toString(),
            //             style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text(
            //             'Rata-rata',
            //             style: GoogleFonts.roboto(),
            //           ),
            //           Text(
            //             avVal.toString(),
            //             style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text(
            //             'Min',
            //             style: GoogleFonts.roboto(),
            //           ),
            //           Text(
            //             minVal.toString(),
            //             style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Divider(
            //   color: Colors.grey,
            // ),
            SizedBox(height: 16.h),
            ListView.builder(
              itemCount: shortedDataList.length,
              shrinkWrap: true,
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                List<dynamic> valueSens = [];
                final myData =
                    mysensors(shortedDataList, widget.sensorName, index);
                // valueSens.addAll(myData);

                // log(valueSens.toString());

                // maxVal = SensorDataCalculator.calculateMax(valueSens);
                // minVal = SensorDataCalculator.calculateMin(valueSens);
                // avVal = SensorDataCalculator.calculateAverage(valueSens);
                myCharData.add(myData);
                // log(myCharData.length.toString());
                if (loading) {
                  Future.delayed(Duration.zero, () {
                    ref.read(chartDataProvider.notifier).state = myCharData;
                  });
                  loading = false;
                }

                // for (var element in myData) {
                //   myCharData.add(element);
                // }
                // myCharData.addAll([myData[0], myData[1]]);
                final time = timeFormat(myData[1], selectedSort);
                final symbol = sensorSymbol(widget.sensorName);
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: ListTile(
                    title: Text(
                      '${myData[0]} $symbol',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Normal',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse_outlined,
                              size: 20,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              time,
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: Text('${index + 1}'),
                    dense: true,
                    tileColor: Colors.white,
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}

class PilList extends StatelessWidget {
  const PilList({
    super.key,
    required this.onTap,
    required this.text,
    this.onSelect = false,
  });
  final VoidCallback onTap;
  final String text;
  final bool? onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: onSelect! ? Colors.blue : Colors.grey),
          color: onSelect! ? Colors.blue.shade100 : Colors.white,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14.sp),
        ),
      ),
    );
  }
}

List<Sensors> shortedList(Map<String, dynamic> mapSensor, String shortType) {
  List<Sensors> datalist = [];
  datalist.clear();
  mapSensor.forEach((key, value) {
    int timestamp = value['time'];
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    // log('${formatedDate}, ${dateTimeNowFormated}');
    if (shortType == 'Hari ini') {
      DateFormat dateFormat = DateFormat('d/M/y');
      String formatedDate = dateFormat.format(dateTime);
      String dateTimeNowFormated = dateFormat.format(DateTime.now());
      // log('${formatedDate}, ${dateTimeNowFormated}');
      if (formatedDate == dateTimeNowFormated) {
        datalist.add(Sensors.fromJson(value));
      }
    }
    if (shortType == 'Bulan ini') {
      DateFormat dateFormat = DateFormat('M/y');
      String formatedDate = dateFormat.format(dateTime);
      String dateTimeNowFormated = dateFormat.format(DateTime.now());
      // log('${formatedDate}, ${dateTimeNowFormated}');
      if (formatedDate == dateTimeNowFormated) {
        datalist.add(Sensors.fromJson(value));
      }
    }
  });
  datalist.sort((a, b) => a.time!.compareTo(b.time!));

  return datalist;
}

String timeFormat(int timestamp, String filterBy) {
  String formatedDate = '';
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  if (filterBy == 'Hari ini') {
    DateFormat dateFormat = DateFormat('hh:mm');
    formatedDate = 'Hari ini, ${dateFormat.format(dateTime)}';
  }
  if (filterBy == 'Bulan ini') {
    DateFormat dateFormat = DateFormat('d/M/y');
    formatedDate = dateFormat.format(dateTime);
  }
  return formatedDate;
}

List<dynamic> mysensors(List<Sensors> data, String id, int index) {
  switch (id) {
    case 'Suhu':
      return [data[index].temp, data[index].time];
    case 'Suhu Air':
      return [data[index].waterTemp, data[index].time];
    case 'Kelembapan':
      return [data[index].hum, data[index].time];
    case 'PH':
      return [data[index].ph, data[index].time];
    case 'TDS':
      return [data[index].tds, data[index].time];
    case 'Oksigen':
      return [data[index].oxygen, data[index].time];
    case 'Level Air':
      return [data[index].waterLevel, data[index].time];
    default:
      return [];
  }
}

String sensorSymbol(id) {
  switch (id) {
    case 'Suhu':
      return ' °C';
    case 'Suhu Air':
      return ' °C';
    case 'Kelembapan':
      return ' %';
    case 'PH':
      return '';
    case 'TDS':
      return ' ppm';
    case 'Oksigen':
      return ' mg/L';
    case 'Level Air':
      return ' %';
    default:
      return '';
  }
}
