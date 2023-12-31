import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:loginuicolors/config.dart';
import 'package:loginuicolors/screen/dashboard_list/booked_data.dart';
import 'package:loginuicolors/screen/dashboard_list/property_list_model.dart';

import '../../utils/logger.dart';

class BookedProperty extends StatefulWidget {
  final String names;
  final String id;
  const BookedProperty({Key? key, required this.names, required this.id})
      : super(key: key);

  @override
  State<BookedProperty> createState() => _BookedPropertyState();
}

class _BookedPropertyState extends State<BookedProperty> {
  final log = logger;
  List<Booked> bookings = [];
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
      final response = await http.get(Uri.parse(getbooks));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        log.i(jsonData);
        if (jsonData['status'] == true && jsonData['getbooks'] is List) {
          setState(() {
            bookings = (jsonData['getbooks'] as List<dynamic>)
                .map((item) => Booked.fromJson(item))
                .toList();
          });
          log.i("Booking Details${jsonData}");
        } else {
          log.i('Invalid response format or no booking data');
        }
      } else {
        log.i('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (error) {
      log.i('Error: $error');
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
    log.i(widget.id);
    return Scaffold(
      appBar: AppBar(),
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
                      bool IsOwenrbooked = booking.ownerId == widget.id;

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
                      if (!IsOwenrbooked) {
                        return Container();
                      }
                      return CardList(
                        booking: booking,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class CardList extends StatefulWidget {
  final Booked booking;
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
      elevation: 8,
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
                    Text('Booked by: Rs. ${widget.booking.userName}'),
                    Text('Phone no:${widget.booking.phone}'),
                    Text('Address: ${widget.booking.propertyAddress}'),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BookingPage(
                      //         booking: ,
                      //         names: widget.names,
                      //         id: widget.id),
                      //   ),
                      // );
                    },
                    child: Text('ℹ️ Get Information'),
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
