import 'package:flutter/material.dart';

class MarkingPage extends StatefulWidget {
  const MarkingPage({super.key});

  @override
  State<MarkingPage> createState() => _MarkingPageState();
}

class _MarkingPageState extends State<MarkingPage> {

  final TextEditingController _markController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  String selectedModule = "Flutter Development";

  final List<String> modules = [
    "Flutter Development",
    "Database Design",
    "Team Collaboration",
    "Problem Solving",
  ];

  // 📊 STORE EVALUATIONS HERE
  List<Map<String, dynamic>> evaluations = [];

  // 📌 UPDATE PERFORMANCE FUNCTION
  void updatePerformance() {
    if (_markController.text.isEmpty || _feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      evaluations.add({
        "module": selectedModule,
        "mark": _markController.text,
        "feedback": _feedbackController.text,
      });

      _markController.clear();
      _feedbackController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Evaluation saved successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Evaluate Intern"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Intern Evaluation Form",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 20),

            // 📌 MODULE
            const Text("Select module"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedModule,
                isExpanded: true,
                underline: const SizedBox(),

                items: modules.map((module) {
                  return DropdownMenuItem(
                    value: module,
                    child: Text(module),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedModule = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            // 🎯 MARKS
            const Text("Mark (/20)"),
            TextField(
              controller: _markController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 15),

            // 📝 FEEDBACK
            const Text("Feedback"),
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 20),

            // 🚀 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3B6D),
                  padding: const EdgeInsets.all(14),
                ),

                onPressed: updatePerformance,

                child: const Text(
                  "Save Evaluation",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📊 SHOW SAVED EVALUATIONS
            const Text(
              "Saved Evaluations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: evaluations.length,
                itemBuilder: (context, index) {
                  final item = evaluations[index];

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Module: ${item["module"]}"),
                        Text("Mark: ${item["mark"]}"),
                        Text("Feedback: ${item["feedback"]}"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}