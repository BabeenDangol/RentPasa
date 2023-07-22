import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loginuicolors/screen/Tenantpages/profile.dart';
import 'package:loginuicolors/screen/Tenantpages/postlisting.dart';
import 'package:loginuicolors/screen/Tenantpages/search.dart';
import 'package:loginuicolors/screen/Tenantpages/setting.dart';
import 'package:loginuicolors/screen/Tenantpages/tenant_view.dart';
import 'package:loginuicolors/utils/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors/colors.dart';
import 'login.dart';
import 'add_property_form.dart';

class Dashboard extends StatefulWidget {
  final String token;
  final String? role;
  final String? names;
  final int? phone;
  final String? id;
  final String? email;

  const Dashboard({
    required this.token,
    required this.role,
    required this.names,
    required this.phone,
    required this.id,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String id;
  late String email;
  late String names;
  late int phone;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    id = jwtDecodedToken['_id'];
    email = jwtDecodedToken['email'];
    names = jwtDecodedToken['names'];
    phone = jwtDecodedToken['phone'];
    print("Dashboard:${phone}");
    // phone = jwtDecodedToken['phone'];
  }

  @override
  void didUpdateWidget(Dashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.names != oldWidget.names ||
        // widget.phone != oldWidget.phone ||
        widget.id != oldWidget.id ||
        widget.email != oldWidget.email) {
      setState(() {
        names = widget.names!;
        // phone = widget.phone!;
        id = widget.id!;
        email = widget.email!;
      });
    }
  }

  Future<void> _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyLogin()),
    );
  }

  void _navigateToAddPropertyForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyForm(
            // token: widget.token,
            // role: widget.role,
            ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    if (widget.role == 'tenant') {
      return _buildTenantDashboard();
    } else if (widget.role == 'owner') {
      return _buildOwnerDashboard();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Invalid role'),
          SizedBox(height: 20),
          _buildLogoutButton(),
        ],
      );
    }
  }

  Widget _buildTenantDashboard() {
    final List<Map<String, dynamic>> appBarTitles = [
      {
        'icon': Icons.home,
        'label': "Home",
      },
      {
        'icon': Icons.search,
        'label': "Search",
      },
      {
        'icon': Icons.list,
        'label': "Listings",
      },
      {
        'icon': Icons.person,
        'label': "Profile",
      },
      {
        'icon': Icons.settings,
        'label': "Settings",
      },
    ];
    List<Widget> _buildScreens() {
      return [
        TenantViewPage(),
        Search(),
        GetDataPage(
          email: email,
          names: names,
          phone: phone,
          id: id,
        ),
        ProfilePage(
          email: email,
          names: names,
          phone: phone,
          id: id,
        ),
        Setting(),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(appBarTitles[_currentIndex]['icon']),
            Text(
              appBarTitles[_currentIndex]['label'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 150,
            ),
            _buildLogoutButton(),
          ],
        ),
      ),
      body: _buildScreens()[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 103, 129, 124),
          selectedItemColor: tdpurple3,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_outlined),
              label: "Post Listing",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerDashboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome Owner: $email'),
        Text('Welcome Owner: $names'),
        Text('Welcome Owner: $phone'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _navigateToAddPropertyForm,
          child: Text('Add Property'),
        ),
        SizedBox(height: 20),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: () {
        showAboutDialog(context: context, children: [
          AlertDialog(
            content: Text("Hello"),
            actions: [
              Title(
                color: Colors.black,
                child: Text("Are you sure?"),
              )
            ],
          )
        ]);
      },
      child: Icon(Icons.logout, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDashboardContent();
  }
}
