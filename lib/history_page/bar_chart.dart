import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tank_fish/providers.dart';

class HistoryChart extends ConsumerStatefulWidget {
  const HistoryChart({
    super.key,
    required this.chartData,
    required this.sensorName,
  });

  final List<dynamic> chartData;
  final String sensorName;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<HistoryChart> {
  List<ChartData> data = [];
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedSort = ref.watch(selectedSortProvider);
    // log(widget.chartData.toString());
    data.clear();
    for (var i = 0; i < widget.chartData.length; i++) {
      final time = timeFormat(widget.chartData[i][1], selectedSort);
      data.add(ChartData(time, widget.chartData[i][0]));
    }

    final maxMinRange = maxMinY(widget.sensorName);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: SfCartesianChart(
        borderWidth: 0,
        plotAreaBorderWidth: 0,
        borderColor: Colors.transparent,
        plotAreaBorderColor: Colors.transparent,
        primaryXAxis: CategoryAxis(
          borderWidth: 0,
          // maximum: selectedSort == 'Hari ini' ? 12 : null,
          // minimum: selectedSort == 'Hari ini' ? 1 : null,
          // title: AxisTitle(text: 'Jam'),
          borderColor: Colors.transparent,
        ),
        primaryYAxis: NumericAxis(
          minimum: maxMinRange[0],
          maximum: maxMinRange[1],
          interval: 10,
        ),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            // name: 'Gold',
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.r),
              topRight: Radius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final dynamic y;
}

String timeFormat(int timestamp, String filterBy) {
  String formatedDate = '';
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  if (filterBy == 'Harian') {
    DateFormat dateFormat = DateFormat('h:m');
    formatedDate = dateFormat.format(dateTime);
  }
  if (filterBy == 'Bulanan') {
    DateFormat dateFormat = DateFormat('d/M');
    formatedDate = dateFormat.format(dateTime);
  }
  if (filterBy == 'Mingguan') {
    DateFormat dateFormat = DateFormat('d/M');
    formatedDate = dateFormat.format(dateTime);
  }
  if (filterBy == 'Tahunan') {
    DateFormat dateFormat = DateFormat('yy');
    formatedDate = dateFormat.format(dateTime);
  }
  return formatedDate;
}

List<double> maxMinY(String id) {
  switch (id) {
    case 'Suhu':
      return [0, 45];
    case 'Suhu Air':
      return [0, 45];
    case 'Kelembapan':
      return [10, 90];
    case 'PH':
      return [3.0, 12];
    case 'TDS':
      return [100, 5000];
    case 'Oksigen':
      return [100, 6000];
    case 'Level Air':
      return [0, 100];
    default:
      return [];
  }
}

// List<double> maxMinX(String filterBy) {
//   List<double> value;
//   if (filterBy == 'Hari ini') {
//     value = [6, 12];
//   }
//   if (filterBy == 'Bulan ini') {
//     value = [6, 12];
//   }
// }
