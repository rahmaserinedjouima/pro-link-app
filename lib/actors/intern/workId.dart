import 'package:flutter/material.dart';

class WorkIdPage extends StatefulWidget {
  const WorkIdPage({super.key});

  @override
  State<WorkIdPage> createState() => _WorkIdPageState();
}

class _WorkIdPageState extends State<WorkIdPage> {

  String name = "";
  String department = "";
  String id = "";
  String image = "";

  @override
  void initState() {
    super.initState();
    loadInternInfo();
  }

  void loadInternInfo() {
    setState(() {
      name = "John Doe";
      department = "Software Engineering";
      id = "INT-2026-001";
      image = "assets/profile.png";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B3B6D),

      appBar: AppBar(
        title: const Text("Work ID"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Center(
        child: _buildIdCard(),
      ),
    );
  }

  Widget _buildIdCard() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage(image),
          ),

          const SizedBox(height: 12),

          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B3B6D),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "Department: $department",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "ID: $id",
            style: const TextStyle(fontSize: 12),
          ),

          const SizedBox(height: 20),

          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF3B3B6D),
              borderRadius: BorderRadius.circular(10),
            ),

            child: const Center(
              child: Text(
                "INTERN CARD",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}