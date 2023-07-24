import 'package:flutter/material.dart';
import 'package:loginuicolors/utils/route_names.dart';

import '../../models/post_data.dart';
import '../Provider/propertyList.dart';
import '../dashboard_list/booking_list.dart';
import '../dashboard_list/dashboard_list.dart';
import 'package:provider/provider.dart';

class TenantViewPage extends StatefulWidget {
  final Booking? booking;
  const TenantViewPage({Key? key, this.booking}) : super(key: key);

  @override
  State<TenantViewPage> createState() => _TenantViewPageState();
}

class _TenantViewPageState extends State<TenantViewPage> {
  final List<Post> imageList = [
    Post(
      'assets/modern.jpg',
      'Kathmandu',
      '5000',
      'Kathmandu,Kritipur',
    ),
    Post(
      'assets/modern.jpg',
      'Patan',
      '6000',
      'Lalitpur,Patan',
    ),
    Post(
      'assets/modern.jpg',
      'Kritipur',
      '7000',
      'Kathmandu,Kritipur',
    ),
  ];
  @override
  void initState() {
    super.initState();
    print(widget.booking);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyListProvider>(
      builder: (context, provider, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 290,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(0.0, 1.0),
                    color: Colors.grey,
                  )
                ]),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 30,
                      left: 5,
                      right: 5,
                      child: Image.asset(
                        'assets/modern.jpg',
                        width: 500,
                        height: 600,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 230.0,
                      left: 16.0,
                      right: 16.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ]),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Get Started With",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Handpicked apartments and rooms for you",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Dashboardlist(posts: imageList),
              SizedBox(
                height: 25,
              ),
              IconRow(),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconItem {
  final String name;
  final IconData icon;
  final String imageurl;
  IconItem({required this.icon, required this.name, required this.imageurl});
}

class IconRow extends StatelessWidget {
  final List<IconItem> icons = [
    IconItem(
        icon: Icons.location_city,
        name: "Baneshwor",
        imageurl: 'assets/Kathmandu.jpg'),
    IconItem(
        icon: Icons.location_city,
        name: "Kritipur",
        imageurl: 'assets/Patan.jpg'),
    IconItem(
        icon: Icons.location_city,
        name: "Lalitpur",
        imageurl: 'assets/Patan.jpg'),
    IconItem(
        icon: Icons.location_city,
        name: "Putalisadak",
        imageurl: 'assets/Kathmandu.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          const Text(
            "Rents Near By You",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: List.generate(
              icons.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RouteName.postview),
                  child: Column(
                    children: [
                      CircleAvatar(
                        maxRadius: 35,
                        backgroundImage: AssetImage(icons[index].imageurl),
                        // backgroundColor: Color.fromARGB(255, 69, 101, 95),
                        child: Icon(
                          icons[index].icon,
                          color: Colors.white,
                        ),
                      ),
                      Text(icons[index].name)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
