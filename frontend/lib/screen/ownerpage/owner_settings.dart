import 'package:flutter/material.dart';

import '../Tenantpages/aboutus.dart';
import '../Tenantpages/privacypolicy.dart';

class OwnerSettings extends StatelessWidget {
  // const OwnerSettings({Key? key}) : super(key: key);
  final String? names;
  final String? email;
  final int? phone;
  final String? id;

  OwnerSettings({
    this.id,
    this.names,
    this.email,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  color: Colors.white,
                ),
                Positioned(
                  height: 200,
                  width: 300,
                  top: 50,
                  left: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/modern.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 700,
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${names}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(Icons.person),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${email}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(Icons.email),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Contact',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '+977-${phone}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(Icons.phone),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.privacy_tip),
                          title: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicy()));
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            'About Us',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUsPage()));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
