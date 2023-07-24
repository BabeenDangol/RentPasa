import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginuicolors/screen/Provider/propertyList.dart';
import 'package:loginuicolors/screen/Tenantpages/bookingpage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// Your existing ListData widget code remains unchanged

class PostListing extends StatelessWidget {
  final String email;
  final String names;
  final int? phone;
  final String id;
  PostListing(
      {Key? key,
      required this.email,
      required this.names,
      this.phone,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<PropertyListProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Container(
          height:
              size.height - const CupertinoNavigationBar().preferredSize.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 213, 211, 208),
                    label: Text("search"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    provider.updateSearch(value);
                    print(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    itemCount: provider.filteredPropertyList.length,
                    itemBuilder: (context, index) {
                      final property = provider.filteredPropertyList[index];
                      return Column(
                        children: [
                          Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16),
                                ListTile(
                                  title: Text(
                                    "${property.propertyAddress}",
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${property.propertyRent}"),
                                      Text("${property.propertyDate}"),
                                      Text("${property.propertyLocality}"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        itemSize: 25,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingPage(
                                                    booking: property,
                                                    id: id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('ℹ️ Get Information'),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              if (provider.propertylist[index]
                                                      .bookingRemaining <=
                                                  3) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingPage(
                                                      booking: provider
                                                          .propertylist[index],
                                                    ),
                                                  ),
                                                );
                                              } else if (provider
                                                      .propertylist[index]
                                                      .bookingRemaining <=
                                                  0) {
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    color: Colors.red,
                                                    child: Text(
                                                      'Booking Full',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text('📅 Book Now'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  16), // Add a gap of 16 pixels between each Card
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
