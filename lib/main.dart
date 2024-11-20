import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/daftar.dart';
import '../pages/listpage.dart'; 

void main() {
  runApp(const AplikasiSaya());
}

class AplikasiSaya extends StatelessWidget {
  const AplikasiSaya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => HalamanLogin(),
        '/register': (context) => HalamanRegister(),
        '/home': (context) => RestaurantListPage(),
      },
    );
  }
}
