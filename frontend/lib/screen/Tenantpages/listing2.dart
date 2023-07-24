import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginuicolors/screen/Provider/propertyList.dart';
import 'package:loginuicolors/screen/Tenantpages/bookingpage.dart';
import 'package:provider/provider.dart';

// Your existing ListData widget code remains unchanged

class ListData extends StatelessWidget {
  const ListData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PropertyListProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Consumer<PropertyListProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Container(
          height:
              size.height - const CupertinoNavigationBar().preferredSize.height,
          width: size.width,
          child: ListView.builder(
              itemCount: provider.propertylist.length,
              itemBuilder: (context, index) => Card(
                    color: Colors.amber,
                    elevation: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                                "${provider.propertylist[index].propertyAddress}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${provider.propertylist[index].propertyRent}"),
                                Text(
                                    "${provider.propertylist[index].propertyDate}"),
                                Text(
                                    "${provider.propertylist[index].propertyLocality}"),
                              ],
                            ),
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
                                          booking:
                                              provider.propertylist[index])),
                                );
                              },
                              child: Text('ℹ️ Get Information'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                              onPressed: () {
                                if (provider
                                        .propertylist[index].bookingRemaining <=
                                    3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingPage(
                                        booking: provider.propertylist[index],
                                      ),
                                    ),
                                  );
                                } else if (provider
                                        .propertylist[index].bookingRemaining <=
                                    0) {
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
                                  );
                                }
                              },
                              child: Text('📅 Book Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
