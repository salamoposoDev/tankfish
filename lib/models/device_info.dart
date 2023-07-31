class DeviceInfo {
  int? rssi;
  String? ipAddr;
  String? macAddr;

  DeviceInfo({this.rssi, this.ipAddr, this.macAddr});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    rssi = json['rssi'] ?? 0;
    ipAddr = json['ipAddr'] ?? '';
    macAddr = json['macAddr'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rssi'] = this.rssi;
    data['ipAddr'] = this.ipAddr;
    data['macAddr'] = this.macAddr;
    return data;
  }
}
