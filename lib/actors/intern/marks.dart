import 'package:flutter/material.dart';

class MarksPage extends StatefulWidget {
  const MarksPage({super.key});

  @override
  State<MarksPage> createState() => _MarksPageState();
}

class _MarksPageState extends State<MarksPage> {

  List<Map<String, dynamic>> marks = [];

  @override
  void initState() {
    super.initState();
    loadMarks();
  }

  void loadMarks() {
    setState(() {
      marks = [
        {
          "skill": "Flutter Development",
          "mark": 18,
          "feedback": "Good understanding of widgets and layout.",
          "color": Colors.green,
        },
        {
          "skill": "Database Design",
          "mark": 17,
          "feedback": "Needs improvement in normalization.",
          "color": Colors.orange,
        },
        {
          "skill": "Team Collaboration",
          "mark": 12,
          "feedback": "Excellent communication and teamwork.",
          "color": Colors.blue,
        },
        {
          "skill": "Problem Solving",
          "mark": 16,
          "feedback": "Try to improve algorithmic thinking.",
          "color": Colors.red,
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Performance Evaluation"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Your Skill Assessment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: marks.length,
                itemBuilder: (context, index) {
                  final item = marks[index];

                  return _buildMarkCard(
                    skill: item["skill"],
                    mark: item["mark"],
                    feedback: item["feedback"],
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

  Widget _buildMarkCard({
    required String skill,
    required int mark,
    required String feedback,
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

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                skill,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3B6D),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  "$mark",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            feedback,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}