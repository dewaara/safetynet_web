class BrowsingData {
  final String email;
  final String androidId;
  final String urls;
  final int timestamp;

  BrowsingData({
    required this.email,
    required this.androidId,
    required this.urls,
    required this.timestamp,
  });

  factory BrowsingData.fromJson(Map<String, dynamic> json) {
    return BrowsingData(
      email: json['email'] ?? '',
      androidId: json['androidId'] ?? '',
      urls: json['urls'] ?? '',
      timestamp: json['timestamp'] is int
          ? json['timestamp']
          : int.tryParse(json['timestamp'].toString()) ?? 0,
    );
  }
}
