import 'package:flutter/material.dart';

class PropertyDetailPage extends StatefulWidget {
  const PropertyDetailPage({Key? key}) : super(key: key);

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: BackButton(),
        title: Text("Property Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 45, 173, 161)),
                  height: 200,
                ),
              ],
            ),
            Row(
              children: [
                Text("Rs 5000"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
