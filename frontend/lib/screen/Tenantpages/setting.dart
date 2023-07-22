import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.key),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text('FAQ'),
            trailing: Icon(Icons.arrow_right),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('About Us'),
            trailing: Icon(Icons.arrow_right),
          ),
          Divider(),
        ],
      ),
    );
  }
}
