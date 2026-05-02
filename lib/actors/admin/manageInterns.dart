import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';

class ManageInternsPage extends StatefulWidget {
  const ManageInternsPage({super.key});

  @override
  State<ManageInternsPage> createState() => _ManageInternsPageState();
}

class _ManageInternsPageState extends State<ManageInternsPage> {

  List<Map<String, dynamic>> interns = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadInterns();
  }
  void loadInterns() async {
    final data = await UserService.getUsers();

    if (!mounted) return;

    setState(() {
      interns = List<Map<String, dynamic>>.from(data);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Manage Interns"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: interns.length,
          itemBuilder: (context, index) {
            return _buildInternCard(index, interns[index]);
          },
        ),
      ),
    );
  }

  Widget _buildInternCard(int index, Map<String, dynamic> intern) {
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
                onPressed: () async {
                  final result = await UserService.updateUserStatus(
                    intern["id"].toString(),
                    "approved",
                  );

                  if (result["success"] == true) {
                    setState(() {
                      interns[index]["status"] = "approved";
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Intern approved")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result["message"])),
                    );
                  }
                },
              ),

              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () async {
                  final result = await UserService.updateUserStatus(
                    intern["id"].toString(),
                    "rejected",
                  );

                  if (result["success"] == true) {
                    setState(() {
                      interns[index]["status"] = "rejected";
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Intern rejected")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result["message"])),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}