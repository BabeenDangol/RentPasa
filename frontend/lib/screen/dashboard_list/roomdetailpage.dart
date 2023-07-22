// import 'dart:js';
import 'package:flutter/material.dart';
// import 'dashboard_items.dart';
// import 'dashboard_list.dart';
import '/models/post_data.dart';
// import 'paymentpage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class RoomDetailPage extends StatelessWidget {
  final String referenceId = "";
  final Post post;
  final BuildContext context;

  RoomDetailPage({Key? key, required this.post, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: '${post.imagePath}_image',
            child: Image.asset(
              post.imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  post.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Rent: ${post.amount}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Perform any action when the button is clicked
                  },
                  child: Text('Book Now'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    payWithKhaltiInApp(); // Perform any action when the button is clicked
                  },
                  child: Text('Pay with Khalti'),
                ),
                Text(referenceId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "Product id",
          productName: "Product Name"),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Payment Successful!"),
            actions: [
              SimpleDialogOption(
                child: Text("OK"),
                onPressed: () {
                  // setState(() {
                  //   referenceId = success.idx;
                  // });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint("Cancelled");
  }
}
