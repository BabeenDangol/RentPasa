import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:loginuicolors/screen/Tenantpages/postlisting.dart';
import 'package:loginuicolors/screen/dashboard_list/property_list_model.dart';
import '../../config.dart';
import '../dashboard_list/booking_list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
            // Container(
            //   height: 200,
            //   width: double.infinity,
            //   color: Colors.grey,
            // ),
            Image.asset(
              'assets/room.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
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
                  Text("Postd by ${widget.booking.ownerId.toString()}")
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
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Rating",
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
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            itemSize: 30,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              // print(rating);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    "Property Description",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("${widget.booking.propertyDescriptions}"),
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
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      elevation: MaterialStatePropertyAll(5),
                    ),
                    onPressed: bookPropertyMethod,
                    child: Text(
                      'Book Property',
                      style: TextStyle(
                        color: Color(0xFF6B4C85),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(8),
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: payWithKhaltiInApp,
                    child: Text(
                      'Book in Advance',
                      style: TextStyle(
                        color: Color(0xFF6B4C85),
                      ),
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

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

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
      // print('Server responded with status code ${response.statusCode}');
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

  bookPropertyMethod() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Room Booked !"),
            content: Text(
                "Your room has been booked. We will contact your shortly."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        });
  }
}
