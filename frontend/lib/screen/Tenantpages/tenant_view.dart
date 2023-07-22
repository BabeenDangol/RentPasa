import 'package:flutter/material.dart';
import 'package:loginuicolors/utils/route_names.dart';

import '../../models/post_data.dart';
import '../dashboard_list/dashboard_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

List<String> imageList = [
  'assets/exide-ad.jpg',
  'assets/gulab-ad.jpg',
  'assets/nimb-ad.jpg',
  // Add more image paths here
];

class TenantViewPage extends StatefulWidget {
  const TenantViewPage({Key? key}) : super(key: key);

  @override
  State<TenantViewPage> createState() => _TenantViewPageState();
}

class _TenantViewPageState extends State<TenantViewPage> {
  final List<Post> postList = [
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
              Dashboardlist(posts: postList),

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