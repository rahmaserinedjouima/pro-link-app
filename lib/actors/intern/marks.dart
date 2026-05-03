import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';

class MarksPage extends StatefulWidget {
  const MarksPage({super.key});

  @override
  State<MarksPage> createState() => _MarksPageState();
}

class _MarksPageState extends State<MarksPage> {
  List<dynamic> marks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMarks();
  }

  void loadMarks() async {
    final data = await UserService.getEvaluations();

    setState(() {
      marks = data;
      isLoading = false;
    });
  }

  Color getMarkColor(int mark) {
    if (mark >= 15) return Colors.green;
    if (mark >= 10) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Performance Evaluation"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Evaluation",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: marks.isEmpty
                  ? const Center(child: Text("No marks yet"))
                  : ListView.builder(
                itemCount: marks.length,
                itemBuilder: (context, index) {
                  final item = marks[index];
                  final mark = int.parse(item["mark"].toString());

                  return _buildMarkCard(
                    intern: item["intern_name"],
                    mentor: item["mentor_name"],
                    mark: mark,
                    feedback: item["feedback"],
                    color: getMarkColor(mark),
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
    required String intern,
    required String mentor,
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
          Text(
            "Intern: $intern",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B3B6D),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Mentor: $mentor",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mark",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3B6D),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$mark/20",
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
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}