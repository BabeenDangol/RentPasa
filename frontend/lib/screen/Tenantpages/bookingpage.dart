import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:loginuicolors/screen/Tenantpages/postlisting.dart';
import 'package:loginuicolors/screen/dashboard_list/property_list_model.dart';
import '../../config.dart';
import '../../utils/loggers.dart';

final log = logger;

class BookingPage extends StatefulWidget {
  final PropertyList booking;
  final String? names;
  final String? email;
  final int? phone;
  final String? id;

  BookingPage(
      {required this.booking, this.id, this.names, this.email, this.phone});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String referenceId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Rs.${widget.booking.propertyRent} |',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.booking.propertyBedroomCount} Bedroom Size',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text("Postd on ${widget.booking.propertyDate.toString()}"),
                  Text("Postd by ${widget.booking.ownerName.toString()}"),
                ],
              ),
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Society | Tol",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${widget.booking.propertyLocality}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Address", style: TextStyle(fontSize: 16)),
                          Text(
                            "${widget.booking.propertyAddress}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Property Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balcony",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Type",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Property ID",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.booking.propertyBalconyCount}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("${widget.booking.propertyType}"),
                          SizedBox(
                            height: 20,
                          ),
                          Text("${widget.booking.id}"),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.teal),
                      elevation: MaterialStatePropertyAll(8),
                    ),
                    onPressed: bookProperty,
                    child: Text(
                      'Book Property',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 60),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(8),
                      backgroundColor: MaterialStatePropertyAll(Colors.teal),
                    ),
                    onPressed: payWithKhaltiInApp,
                    child: Text(
                      'Book in Advance',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bookProperty() async {
    final Map<String, dynamic> requestBody = {
      'userId': widget.id,
      'userName': widget.names,
      'phone': widget.phone,
      'ownerId': widget.booking.ownerId,
      'propertyAddress': widget.booking.propertyAddress,
      'propertyLocality': widget.booking.propertyLocality,
      'propertyRent': widget.booking.propertyRent,
      'propertyType': widget.booking.propertyType,
      'propertyBalconyCount': widget.booking.propertyBalconyCount,
      'propertyBedroomCount': widget.booking.propertyBedroomCount,
      'propertyDate': widget.booking.propertyDate.toString(),
      'bookingRemaining': widget.booking.bookingRemaining.toString(),
    };

    final response = await http.post(
      Uri.parse(createBook),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    log.i('Response status: ${response.statusCode}');
    log.i('Response body: ${response.body}');

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking successful'),
            duration: Duration(seconds: 2),
          ),
        );
        // Redirect to ShowPropertyPage after successful booking
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book property'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      log.i('Server responded with status code ${response.statusCode}');
    }
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "Product id",
          productName: "Product Name"),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Payment Successful!"),
            actions: [
              SimpleDialogOption(
                child: Text("OK"),
                onPressed: () {
                  setState(() {
                    referenceId = success.idx;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint("Cancelled");
  }
}
