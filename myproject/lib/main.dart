import 'package:flutter/material.dart';

void main() {
  runApp(const TempMeterApp());
}

class TempMeterApp extends StatelessWidget {
  const TempMeterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            HeaderSection(),
            Expanded(child: DeviceListSection()),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}

// ส่วน Header
class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tempmeter",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.person),
        ],
      ),
    );
  }
}

// ส่วนแสดงรายการอุปกรณ์
class DeviceListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DeviceGrid(),
            const SizedBox(height: 20),
            SelectedDeviceInfo(),
          ],
        ),
      ),
    );
  }
}

class DeviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "อุปกรณ์ทั้งหมด",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) => DeviceCard(index: index + 1)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(label: "เพิ่ม", color: Colors.green),
              SizedBox(width: 10),
              ActionButton(label: "ลบ", color: Colors.red),
              SizedBox(width: 10),
              ActionButton(label: "แก้ไข", color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final int index;

  const DeviceCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text("อุปกรณ์ $index", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

// ปุ่มกด
class ActionButton extends StatelessWidget {
  final String label;
  final Color color;

  const ActionButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () {},
      child: Text(label),
    );
  }
}

// ข้อมูลอุปกรณ์ที่เลือก
class SelectedDeviceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            "อุปกรณ์ 1",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionButton(label: "เริ่ม", color: Colors.green),
              ActionButton(label: "หยุด", color: Colors.red),
            ],
          ),
          const SizedBox(height: 10),
          TemperatureDisplay(),
        ],
      ),
    );
  }
}

// ส่วนแสดงอุณหภูมิ
class TemperatureDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("อุณหภูมิ", style: TextStyle(fontSize: 18, color: Colors.white)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Celsius (°C)", style: TextStyle(color: Colors.white)),
                  Text(
                    "32C",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Fahrenheit (°F)",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "44D",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.gps_fixed), label: "track"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
      ],
    );
  }
}
