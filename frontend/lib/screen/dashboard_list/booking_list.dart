class Booking {
  final String propertyId;
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

  Booking({
    required this.propertyId,
    required this.propertyAddress,
    required this.propertyLocality,
    required this.propertyRent,
    required this.propertyType,
    required this.propertyBalconyCount,
    required this.propertyBedroomCount,
    required this.propertyDate,
    required this.bookingRemaining,
    this.email,
    this.phone,
    this.names,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      propertyId: json['_id'] ?? '',
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
      email: json['email'],
      phone: json['phone'],
      names: json['names'],
    );
  }
}
