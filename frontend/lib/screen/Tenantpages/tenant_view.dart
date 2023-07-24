import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loginuicolors/screen/Tenantpages/bookingpage.dart';
import 'package:loginuicolors/utils/route_names.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import '../Provider/propertyList.dart';

import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loginuicolors/utils/logger.dart';

List<String> imageList = [
  'assets/exide-ad.jpg',
  'assets/gulab-ad.jpg',
  'assets/nimb-ad.jpg',
  // Add more image paths here
];
final log = logger;

class TenantViewPage extends StatefulWidget {
  const TenantViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TenantViewPage> createState() => _TenantViewPageState();
}

class _TenantViewPageState extends State<TenantViewPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
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
              SlideableList(),
              // Dashboardlist(posts: postList),
              SizedBox(
                height: 25,
              ),
              IconRow(),
              SizedBox(
                height: 25,
              ),

              // IconRow(),
              // SizedBox(
              //   height: 25,
              // ),
              SizedBox(
                  height: 200,
                  child: CarouselSlider(
                    items: imageList.map((imagePath) {
                      return Container(
                          // Set the desired fixed width
                          child: ClipRRect(
                        child: Image.asset(
                          imagePath,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ));
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 22 / 8,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 6),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  )),
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

class SlideableList extends StatelessWidget {
  const SlideableList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyListProvider>(
      builder: (context, provider, child) => SingleChildScrollView(
        scrollDirection:
            Axis.horizontal, // Set the scroll direction to horizontal
        child: Row(
          children: List.generate(
            3,
            (index) {
              final property = provider.propertylist[index];
              return Container(
                width: 250,
                height: 300,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Bounce(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(booking: property),
                    ),
                  ),
                  duration: const Duration(milliseconds: 95),
                  child: Hero(
                    tag: property.id,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.asset(
                              'assets/modern.jpg',
                              height: 125,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property.propertyAddress,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${property.propertyLocality}',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 55),
                                Row(
                                  children: [
                                    Icon(Icons.money),
                                    Text(" Rs ${property.propertyRent}"),
                                  ],
                                ),
                                RatingBar.builder(
                                  itemSize: 20,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (value) =>
                                      (value) => log.i(value),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
