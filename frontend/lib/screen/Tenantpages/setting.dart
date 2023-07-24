import 'package:flutter/material.dart';
import 'package:loginuicolors/screen/Tenantpages/aboutus.dart';
import 'package:loginuicolors/screen/Tenantpages/privacypolicy.dart';

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
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('About Us'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
