class ComplaintData {
  final String name;
  final String phone;
  final String complaint;
  final String imageBase64;

  ComplaintData({
    required this.name,
    required this.phone,
    required this.complaint,
    required this.imageBase64,
  });

  factory ComplaintData.fromJson(Map<String, dynamic> json) {
    return ComplaintData(
      name: json['name'],
      phone: json['phone'],
      complaint: json['complaint'],
      imageBase64: json['imageBase64'],
    );
  }
}
