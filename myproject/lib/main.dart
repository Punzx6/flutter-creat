import 'package:flutter/material.dart';
import 'ui/moisture_page.dart';
import 'ui/login_page.dart'; // นำเข้า login_page.dart ด้วย

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soil Moisture App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginPage(), // เปลี่ยนจาก MoisturePage เป็น LoginPage
    );
  }
}
