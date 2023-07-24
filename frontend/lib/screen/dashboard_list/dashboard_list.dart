// import 'package:flutter/material.dart';
// import 'package:loginuicolors/screen/Provider/propertyList.dart';
// import 'package:provider/provider.dart';

// import '../../models/post_data.dart';
// import 'dashboard_items.dart';

// class Dashboardlist extends StatelessWidget {
//   final List<Post> posts;

//   const Dashboardlist({Key? key, required this.posts}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PropertyListProvider>(builder: (context, provider, child) {
//       return Container(
//         height: 400,
//         child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               final propertylists = provider.propertylist[index];
//               return Container(
//                 height: 200,
//                 child: DashboardItem(
//                   post: propertylists,
//                 ),
//               );
//             }),
//       );
//     });
//   }
// }
