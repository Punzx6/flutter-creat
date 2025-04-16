import 'package:flutter/material.dart';
import 'package:myproject/ui/moisture_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorText = "";

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // ตรวจสอบแบบง่าย ๆ
    if (username == "admin" && password == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MoisturePage()),
      );
    } else {
      setState(() {
        errorText = "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                "เข้าสู่ระบบ",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "ชื่อผู้ใช้",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "รหัสผ่าน",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (errorText.isNotEmpty)
                Text(errorText, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text("เข้าสู่ระบบ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
