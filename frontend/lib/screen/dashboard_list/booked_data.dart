class Booked {
  final String propertyId;
  final String userId;
  final String propertyAddress;
  final String propertyLocality;
  final int propertyRent;
  final String propertyType;
  final int propertyBalconyCount;
  final int propertyBedroomCount;
  final DateTime propertyDate;
  int bookingRemaining;
  String? email;
  int? phone;
  String? names; // Change from final to regular instance variable

  Booked({
    required this.propertyId,
    required this.userId,
    required this.propertyAddress,
    required this.propertyLocality,
    required this.propertyRent,
    required this.propertyType,
    required this.propertyBalconyCount,
    required this.propertyBedroomCount,
    required this.propertyDate,
    required this.bookingRemaining,
  });

  factory Booked.fromJson(Map<String, dynamic> json) {
    return Booked(
      propertyId: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      propertyAddress: json['propertyAddress'] ?? '',
      propertyLocality: json['propertyLocality'] ?? '',
      propertyRent: json['propertyRent'] ?? 0,
      propertyType: json['propertyType'] ?? '',
      propertyBalconyCount: json['propertyBalconyCount'] ?? 0,
      propertyBedroomCount: json['propertyBedroomCount'] ?? 0,
      propertyDate: json['propertyDate'] != null
          ? DateTime.parse(json['propertyDate'])
          : DateTime.now(),
      bookingRemaining: json['bookingRemaining'] ?? 0,
    );
  }
}
