import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealtimeChart extends ConsumerStatefulWidget {
  const RealtimeChart({
    Key? key,
    required this.timestamp,
    required this.sensorValue,
    this.sensorName = 'Suhu',
  }) : super(key: key);
  final int timestamp;
  final int sensorValue;
  final String? sensorName;

  @override
  RealtimeChartState createState() => RealtimeChartState();
}

class RealtimeChartState extends ConsumerState<RealtimeChart> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  late Timer timer;

  @override
  void initState() {
    chartData = getChartData();
    timer = Timer.periodic(const Duration(seconds: 1), updateDataSource);

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final minMax = ref.watch(minMaxProvider);
    return SizedBox(
      width: double.maxFinite,
      height: 250.h,
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0),
        borderWidth: 0,
        series: <ChartSeries<LiveData, String>>[
          // Change int to String for xValueMapper
          SplineAreaSeries<LiveData, String>(
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.blue.shade900,
            ]),
            // Change int to String for xValueMapper
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: Colors.blue,
            xValueMapper: (LiveData sales, _) =>
                sales.time, // Use timeString for x-axis
            yValueMapper: (LiveData sales, _) =>
                sales.speed, // Use temperature for y-axis
          ),
        ],
        primaryXAxis: CategoryAxis(
          borderWidth: 0,
          borderColor: Colors.transparent,
          axisLine: AxisLine(width: 2),

          // interval: 3,
          // Use CategoryAxis for timeString
          majorGridLines: const MajorGridLines(width: 1),
          edgeLabelPlacement: EdgeLabelPlacement.shift,

          title: AxisTitle(text: 'Time'),
        ),
        primaryYAxis: NumericAxis(
          borderWidth: 0,
          borderColor: Colors.transparent,
          // isVisible: false,
          interval: 2,
          // minimum: minMax[0],
          // maximum: minMax[1],
          axisLine: const AxisLine(width: 2),
          majorTickLines: const MajorTickLines(size: 0),
          title: AxisTitle(text: widget.sensorName),

          // axisBorderType: AxisBorderType.withoutTopAndBottom,
        ),
      ),
    );
  }

  int time = 10;
  void updateDataSource(Timer timer) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.timestamp * 1000);

    final currentTimeString =
        '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

    setState(() {
      chartData.add(LiveData(currentTimeString, widget.sensorValue));
      chartData.removeAt(0);
      _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1,
        removedDataIndex: 0,
      );
    });
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData('00:00:00', 42),
      LiveData('00:00:01', 47),
      LiveData('00:00:02', 43),
      LiveData('00:00:03', 49),
      LiveData('00:00:04', 54),
      LiveData('00:00:05', 41),
      LiveData('00:00:06', 58),
      LiveData('00:00:07', 51),
      LiveData('00:00:08', 98),
      LiveData('00:00:09', 41),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final String time;
  final num speed;
}
