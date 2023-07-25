import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loginuicolors/screen/ownerpage/myproperty.dart';
import 'dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'package:loginuicolors/home.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

final log = logger;

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _showEmptyFieldErrorMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty Fields'),
            content: Text('Please fill in all the fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  void _showLoginFailedMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Incorrect email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  bool _validateFields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showEmptyFieldErrorMessage(context);
      return false;
    }
    return true;
  }

  void loginUser() async {
    if (!_validateFields()) return;

    var reqBody = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    var response = await http.post(Uri.parse(login),
        headers: {"Content-type": "application/JSON"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    log.i("JSON response: $jsonResponse");
    if (jsonResponse['status']) {
      var id = jsonResponse['id'];
      var email = jsonResponse['email'];
      var myToken = jsonResponse['token'];
      var jwtDecodedToken = JwtDecoder.decode(myToken);
      var userRole = jwtDecodedToken['role'];
      var names = jsonResponse['names'];
      var phone = jsonResponse['phone'];

      prefs.setString('token', myToken);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    token: myToken,
                    role: userRole,
                    names: names,
                    phone: phone,
                    email: email,
                    id: id,
                  )));
    } else {
      _showLoginFailedMessage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18),
                                fillColor: Color.fromARGB(255, 215, 209, 209),
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18),
                                fillColor: Color.fromARGB(255, 215, 209, 209),
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Sign In"),
                              onPressed: loginUser,
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                primary: Color.fromARGB(255, 120, 100, 2),
                                onPrimary: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                textStyle: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 8,
                                      backgroundColor: Colors.blueGrey),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 91, 105, 143),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
