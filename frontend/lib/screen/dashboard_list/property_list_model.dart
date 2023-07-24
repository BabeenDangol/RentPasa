import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool status;
  List<PropertyList> booking;

  Welcome({
    required this.status,
    required this.booking,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        booking: List<PropertyList>.from(
            json["property"].map((x) => PropertyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
      };
}

class PropertyList {
  int bookingRemaining;
  String id;
  String propertyAddress;
  String? ownerName;
  String? propertyLocality;
  int propertyRent;
  String propertyType;
  int propertyBalconyCount;
  int propertyBedroomCount;
  DateTime propertyDate;
  int v;
  String? propertyDescriptions;

  PropertyList({
    required this.bookingRemaining,
    required this.id,
    required this.propertyAddress,
    this.ownerName,
    this.propertyLocality,
    required this.propertyRent,
    required this.propertyType,
    required this.propertyBalconyCount,
    required this.propertyBedroomCount,
    required this.propertyDate,
    required this.v,
    this.propertyDescriptions,
  });

  factory PropertyList.fromJson(Map<String, dynamic> json) => PropertyList(
        bookingRemaining: json["bookingRemaining"] ?? 0,
        id: json["_id"],
        propertyAddress: json["propertyAddress"],
        ownerName: json["ownerName"],
        propertyLocality: json["propertyLocality"],
        propertyRent: json["propertyRent"],
        propertyType: json["propertyType"],
        propertyBalconyCount: json["propertyBalconyCount"],
        propertyBedroomCount: json["propertyBedroomCount"],
        propertyDate: DateTime.parse(json["propertyDate"]),
        v: json["__v"],
        propertyDescriptions: json["propertyDescriptions"],
      );

  Map<String, dynamic> toJson() => {
        "bookingRemaining": bookingRemaining,
        "_id": id,
        "propertyAddress": propertyAddress,
        "propertyLocality": propertyLocality,
        "propertyRent": propertyRent,
        "propertyType": propertyType,
        "propertyBalconyCount": propertyBalconyCount,
        "propertyBedroomCount": propertyBedroomCount,
        "propertyDate": propertyDate.toIso8601String(),
        "__v": v,
        "propertyDescriptions": propertyDescriptions,
      };
}
