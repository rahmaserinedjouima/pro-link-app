import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<String> interns = [
    "Ahmed Benali",
    "Sara Khelifa",
    "Yacine Bouzid",
    "Nour El Houda",
  ];

  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
  ];

  String selectedDay = "Sunday";

  Map<String, Map<String, String>> attendance = {};

  @override
  void initState() {
    super.initState();

    for (var day in days) {
      attendance[day] = {};
      for (var intern in interns) {
        attendance[day]![intern] = "None";
      }
    }
  }

  void handleAttendance(String day, String intern, String status, {bool save = false}) {
    if (save) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Attendance saved")),
      );
      return;
    }

    setState(() {
      attendance[day]![intern] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Weekly Attendance"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Select Day",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: days.map((day) {
                  bool isSelected = day == selectedDay;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = day;
                      });
                    },

                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3B3B6D)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Attendance - $selectedDay",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: interns.length,
                itemBuilder: (context, index) {
                  String name = interns[index];
                  String status = attendance[selectedDay]![name]!;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3B3B6D),
                          ),
                        ),

                        Row(
                          children: [

                            _btn("P", Colors.green, status == "P", () {
                              handleAttendance(selectedDay, name, "P");
                            }),

                            _btn("A", Colors.red, status == "A", () {
                              handleAttendance(selectedDay, name, "A");
                            }),

                            _btn("L", Colors.orange, status == "L", () {
                              handleAttendance(selectedDay, name, "L");
                            }),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3B6D),
                  padding: const EdgeInsets.all(14),
                ),

                onPressed: () => handleAttendance("", "", "", save: true),

                child: const Text("Save Attendance"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(String text, Color color, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          color: selected ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),

        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}