import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  List<Map<String, dynamic>> schedule = [];

  @override
  void initState() {
    super.initState();
    loadSchedule();
  }

  void loadSchedule() {
    setState(() {
      schedule = [
        {
          "day": "Sunday",
          "time": "09:00 - 11:00",
          "task": "Evaluation & Feedback",
          "color": Colors.red,
        },
        {
          "day": "Monday",
          "time": "08:00 - 12:00",
          "task": "Software Development Training",
          "color": Colors.blue,
        },
        {
          "day": "Tuesday",
          "time": "09:00 - 13:00",
          "task": "Project Work with Mentor",
          "color": Colors.green,
        },
        {
          "day": "Wednesday",
          "time": "10:00 - 14:00",
          "task": "Database Practice & Tasks",
          "color": Colors.orange,
        },
        {
          "day": "Thursday",
          "time": "08:00 - 12:00",
          "task": "Team Collaboration Session",
          "color": Colors.purple,
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Shift Schedule"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Weekly Internship Schedule",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: schedule.length,
                itemBuilder: (context, index) {
                  final item = schedule[index];

                  return _buildScheduleCard(
                    day: item["day"],
                    time: item["time"],
                    task: item["task"],
                    color: item["color"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard({
    required String day,
    required String time,
    required String task,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 6,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B3B6D),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  task,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}