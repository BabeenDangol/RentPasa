import 'package:flutter/material.dart';
import 'package:loginuicolors/screen/dashboard_list/roomdetailpage.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/post_data.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomDetailPage(
                  post: post,
                  context: context,
                ),
              ),
            ),
            child: Hero(
              tag: post.imagePath, // Unique tag for each room
              child: Container(
                width: 250,
                height: 400,
                margin: const EdgeInsets.fromLTRB(0, 15, 5, 20),
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
                        post.imagePath,
                        height: 125,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
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
                                    post.description,
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
                                  Text(" Rs ${post.amount}"),
                                ],
                              ),
                              RatingBar.builder(
                                itemSize: 20,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
