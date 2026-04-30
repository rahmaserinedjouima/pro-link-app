import 'package:flutter/material.dart';

class TrainingFilesPage extends StatefulWidget {
  const TrainingFilesPage({super.key});

  @override
  State<TrainingFilesPage> createState() => _TrainingFilesPageState();
}

class _TrainingFilesPageState extends State<TrainingFilesPage> {

  List<Map<String, String>> files = [];

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  void loadFiles() {
    setState(() {
      files = [
        {
          "title": "Flutter Basics",
          "type": "PDF Document",
        },
        {
          "title": "Database Design Guide",
          "type": "PDF Document",
        },
        {
          "title": "Internship Rules & Policies",
          "type": "Document",
        },
        {
          "title": "Training Video: Git Basics",
          "type": "Video",
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Training Files"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Available Learning Resources",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final item = files[index];

                  return _buildFileCard(
                    title: item["title"]!,
                    type: item["type"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileCard({
    required String title,
    required String type,
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

      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B3B6D),
          ),
        ),

        subtitle: Text(type),

        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

        onTap: () {},
      ),
    );
  }
}