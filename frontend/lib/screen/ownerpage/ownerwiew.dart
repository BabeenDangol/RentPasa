import 'package:flutter/material.dart';
import 'package:loginuicolors/screen/ownerpage/myproperty.dart';

import 'add_property.dart';
import 'bookedProperty.dart';

class OwnerViewPage extends StatefulWidget {
  final String names;
  final String id;
  final String token;
  const OwnerViewPage(
      {Key? key, required this.names, required this.token, required this.id})
      : super(key: key);
  @override
  State<OwnerViewPage> createState() => _OwnerViewPageState();
}

class _OwnerViewPageState extends State<OwnerViewPage> {
  void _openAddProperty() {
    // Method for adding expenses by user.
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: AddPropertyForm(
          token: widget.token,
        ),
      ), //must provide a function as a value.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 500,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    //Adding property Card
                    GridCard(
                      icons: Icon(Icons.add_a_photo_outlined),
                      text: Text(
                        "Add Property",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: const Color.fromARGB(255, 242, 242, 242),
                      onPressed: _openAddProperty,
                    ),
                    GridCard(
                      icons: Icon(Icons.add_a_photo_outlined),
                      text: Text(
                        "My Property",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: const Color.fromARGB(255, 247, 247, 247),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProperty(
                            token: widget.token,
                            id: widget.id,
                          ),
                        ),
                      ),
                    ),
                    GridCard(
                      icons: Icon(Icons.add_a_photo_outlined),
                      text: Text(
                        "Booked Property",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedProperty(
                            names: widget.names,
                            id: widget.id,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridCard extends StatelessWidget {
  final Color color;
  final Text text;
  final Icon icons;
  final VoidCallback onPressed;

  GridCard(
      {required this.text,
      required this.icons,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                blurRadius: 10.0,
                offset: Offset(0, 3),
              ),
            ],
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icons, text],
          )),
        ),
      ),
    );
  }
}

void navigateToPage(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}
