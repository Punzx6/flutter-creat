import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoisturePage extends StatefulWidget {
  const MoisturePage({super.key});

  @override
  State<MoisturePage> createState() => _MoisturePageState();
}

class _MoisturePageState extends State<MoisturePage> {
  String moisture = "รอข้อมูล...";
  List<String> moistureHistory = [];
  String temperature = "รอข้อมูล...";
  List<String> temperatureHistory = [];

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('moistureHistory');
    await prefs.remove('temperatureHistory'); // 👈 เพิ่มบรรทัดนี้ด้วย

    setState(() {
      moistureHistory.clear();
      temperatureHistory.clear(); // 👈 เพิ่มบรรทัดนี้ด้วย
    });
  }

  @override
  void initState() {
    super.initState();
    loadHistory(); // โหลดประวัติเมื่อเปิดแอป
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('moistureHistory', moistureHistory);
    prefs.setStringList('temperatureHistory', temperatureHistory);
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedHistory = prefs.getStringList('moistureHistory');
    final loadedTempHistory = prefs.getStringList('temperatureHistory');

    if (loadedHistory != null) {
      setState(() {
        moistureHistory = loadedHistory;
      });
    }

    if (loadedTempHistory != null) {
      setState(() {
        temperatureHistory = loadedTempHistory; // 👈 เพิ่ม
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Soil Moisture Monitor"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.water_drop, size: 100, color: Colors.blue.shade600),
              const SizedBox(height: 20),
              const Text(
                "ค่าความชื้น",
                style: TextStyle(fontSize: 24, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                moisture,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "ค่าอุณหภูมิ",
                style: TextStyle(fontSize: 24, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                temperature,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  final randomMoisture =
                      (30 + (20 * (DateTime.now().second % 5))).toString();
                  final randomTemp =
                      (20 + (5 * (DateTime.now().second % 3))).toString();
                  final timestamp = TimeOfDay.now().format(context);

                  final moistureEntry =
                      "ค่าความชื้น: $randomMoisture% เวลา: $timestamp";
                  final tempEntry = "อุณหภูมิ: $randomTemp°C เวลา: $timestamp";

                  setState(() {
                    moisture = "$randomMoisture%";
                    temperature = "$randomTemp°C";
                    moistureHistory.insert(0, moistureEntry);
                    temperatureHistory.insert(0, tempEntry);
                  });

                  saveHistory();
                },

                icon: const Icon(Icons.bluetooth),
                label: const Text("เชื่อมต่อ BLE"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 40), // เว้นระยะก่อนแสดงประวัติ
              const Text(
                "ประวัติ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200, // ความสูงของ list แสดงผล
                child: ListView.builder(
                  itemCount: moistureHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(moistureHistory[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16), // ระยะห่างก่อนปุ่ม

              ElevatedButton.icon(
                onPressed: clearHistory,
                icon: const Icon(Icons.delete_forever),
                label: const Text("ล้างประวัติ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
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
