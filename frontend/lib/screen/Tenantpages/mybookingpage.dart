import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:loginuicolors/config.dart';
import '../dashboard_list/booking_list.dart';

import 'bookingpage.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  List<Booking> bookings = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(getUserBookings));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == true && jsonData['booking'] is List) {
          setState(() {
            bookings = (jsonData['booking'] as List<dynamic>)
                .map((item) => Booking.fromJson(item))
                .toList();
          });
          print("Booking Details${jsonData}");
        } else {
          print('Invalid response format or no booking data');
        }
      } else {
        print('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> searchBookings(String pattern) {
    return bookings
        .where((booking) =>
            booking.propertyAddress
                .toLowerCase()
                .contains(pattern.toLowerCase()) ||
            booking.propertyLocality
                .toLowerCase()
                .contains(pattern.toLowerCase()))
        .map((booking) => booking.propertyAddress)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeAheadField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return searchBookings(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      searchController.text = suggestion;
                    },
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      constraints: BoxConstraints(maxHeight: 210.0),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final searchPattern = searchController.text.toLowerCase();
                      if (searchPattern.isNotEmpty &&
                          !booking.propertyAddress
                              .toLowerCase()
                              .contains(searchPattern) &&
                          !booking.propertyLocality
                              .toLowerCase()
                              .contains(searchPattern)) {
                        return Container();
                      }
                      return Container();
                      // CardList(
                      //   id: widget.id,
                      //   booking: booking,
                      //   names: widget.names,
                      //   email: widget.email,
                      //   phone: widget.phone,
                      // );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class CardList extends StatefulWidget {
  final Booking booking;
  final String? names;
  final String? email;
  final int? phone;
  final String? id;

  CardList(
      {required this.booking, this.id, this.email, this.names, this.phone});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isBookingFull = false;

  @override
  void initState() {
    super.initState();
    checkBookingFull();
  }

  void checkBookingFull() {
    if (widget.booking.bookingRemaining <= 0) {
      setState(() {
        isBookingFull = true;
      });
    } else {
      setState(() {
        isBookingFull = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(widget.booking.propertyAddress),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: Rs. ${widget.booking.propertyRent}'),
                    Text('Address: ${widget.booking.propertyLocality}'),
                    Text('Address: ${widget.names}'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                              booking: widget.booking,
                              names: widget.names,
                              id: widget.id),
                        ),
                      );
                    },
                    child: Text('ℹ️ Get Information'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: () {
                      if (!isBookingFull) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              booking: widget.booking,
                              names: widget.names,
                              email: widget.email,
                              phone: widget.phone,
                              id: widget.id,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('📅 Book Now'),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
          if (isBookingFull)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.red,
                child: Text(
                  'Booking Full',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
