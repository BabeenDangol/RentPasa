import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loginuicolors/screen/Provider/propertyList.dart';
import 'package:loginuicolors/screen/Tenantpages/bookingpage.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

// Your existing ListData widget code remains unchanged
final logger = Logger();

class MyProperty extends StatefulWidget {
  final String? token;
  final String id;
  MyProperty({
    Key? key,
    required this.token,
    required this.id,
  }) : super(key: key);

  @override
  State<MyProperty> createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty> {
  final log = logger;
  late String id;
  late String email;
  late String names;
  late int phone;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PropertyListProvider>(context, listen: false)
          .filteredPropertyList;
      Map<String, dynamic> jwtDecodedToken =
          JwtDecoder.decode('${widget.token}');
      id = jwtDecodedToken['_id'];
      email = jwtDecodedToken['email'];
      names = jwtDecodedToken['names'];
      phone = jwtDecodedToken['phone'];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // log.d(widget.id);

    return Consumer<PropertyListProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(),
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
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    itemCount: provider.filteredPropertyList.length,
                    itemBuilder: (context, index) {
                      final property = provider.filteredPropertyList[index];
                      log.i("OwnerId:${property.ownerId}");
                      log.i("CurrentId:${widget.id}");
                      bool isOwnnerId = property.ownerId == widget.id;
                      if (!isOwnnerId) {
                        return Container();
                      }
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
                                      Text("${property.ownerName}"),
                                      Text("${property.propertyRent}"),
                                      Text("${property.propertyDate}"),
                                      Text("${property.propertyLocality}"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingPage(
                                                    booking: property,
                                                  ),
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
