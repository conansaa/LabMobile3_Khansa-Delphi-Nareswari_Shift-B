import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugastiga/home_page.dart';
import 'package:tugastiga/login_page.dart';
import 'package:tugastiga/about_page.dart';
import 'package:tugastiga/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return snapshot.data ?? false ? HomePage() : LoginPage();
        },
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
