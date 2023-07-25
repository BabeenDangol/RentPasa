import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:loginuicolors/propertydetails.dart';
import 'package:loginuicolors/screen/Provider/propertyList.dart';
import 'package:loginuicolors/screen/ownerpage/myproperty.dart';
import 'package:provider/provider.dart';
import '/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'register.dart';
import 'package:khalti/khalti.dart';

final log = logger;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('token');
  final jwtDecodedToken =
      userToken != null ? JwtDecoder.decode(userToken) : null;
  final userRole = jwtDecodedToken != null ? jwtDecodedToken['role'] : null;
  final names = jwtDecodedToken != null ? jwtDecodedToken['names'] : null;

  log.i('JSON response: $jwtDecodedToken');
  runApp(MyApp(
    token: userToken,
    role: userRole,
    names: names != null ? names.toString() : null,
  ));
}

class MyApp extends StatelessWidget {
  final token;
  final String? role;
  final String? names;
  final int? phone;
  final String? id;
  final String? email;

  const MyApp({
    required this.token,
    required this.role,
    this.phone,
    this.id,
    this.email,
    this.names,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PropertyListProvider(),
        ),
      ],
      child: KhaltiScope(
        publicKey: 'test_public_key_f0ef86cb580946bd8d2e6eea13d26639',
        enabledDebugging: true,
        builder: (context, navKey) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          initialRoute: (token != null && JwtDecoder.isExpired(token) == false)
              ? 'dashboard'
              : 'login',
          routes: {
            'login': (context) => MyLogin(),
            'register': (context) => MyRegister(),
            'dashboard': (context) => Dashboard(
                  token: token!,
                  role: role!,
                  names: names,
                  phone: phone,
                  id: id,
                  email: email,
                ),
            'propertydetails': (context) => PropertyDetailPage(),
          },
          navigatorKey: navKey,
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
