import 'package:flutter/material.dart';

class ManageInternsPage extends StatefulWidget {
  const ManageInternsPage({super.key});

  @override
  State<ManageInternsPage> createState() => _ManageInternsPageState();
}

class _ManageInternsPageState extends State<ManageInternsPage> {

  List<Map<String, String>> interns = [
    {"name": "Ahmed Benali", "status": "Pending"},
    {"name": "Sara Khelifa", "status": "Pending"},
    {"name": "Yacine Bouzid", "status": "Approved"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Manage Interns"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView.builder(
          itemCount: interns.length,
          itemBuilder: (context, index) {
            var intern = interns[index];

            return _buildInternCard(index, intern);
          },
        ),
      ),
    );
  }

  Widget _buildInternCard(int index, Map<String, String> intern) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                intern["name"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3B6D),
                ),
              ),
              Text(
                "Status: ${intern["status"]}",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          Row(
            children: [

              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  setState(() {
                    interns[index]["status"] = "Approved";
                  });
                },
              ),

              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    interns[index]["status"] = "Rejected";
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}