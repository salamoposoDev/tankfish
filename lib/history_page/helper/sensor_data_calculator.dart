class SensorDataCalculator {
  static dynamic calculateMax(List<dynamic> dataList) {
    return dataList
        .reduce((value, element) => value > element ? value : element);
  }

  static dynamic calculateMin(List<dynamic> dataList) {
    return dataList
        .reduce((value, element) => value < element ? value : element);
  }

  static dynamic calculateAverage(List<dynamic> dataList) {
    dynamic total = dataList.reduce((value, element) => value + element);
    return total / dataList.length;
  }
}
