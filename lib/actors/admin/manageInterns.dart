import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';

class ManageInternsPage extends StatefulWidget {
  const ManageInternsPage({super.key});

  @override
  State<ManageInternsPage> createState() => _ManageInternsPageState();
}

class _ManageInternsPageState extends State<ManageInternsPage> {

  List<Map<String, dynamic>> interns = [];
  List<dynamic> searchResults = [];
  List<dynamic> suggestions = [];
  List<Map<String, dynamic>> filteredInterns = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadInterns();
  }
  //---------------search interns------------------
  void searchInterns(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredInterns = interns;
        suggestions = [];
      });
      return;
    }

    try {
      final results = await UserService.searchInterns(query);

      final list = List<Map<String, dynamic>>.from(results);

      setState(() {
        filteredInterns = list;
        suggestions = list.take(5).toList();
      });
    } catch (e) {
      setState(() {
        filteredInterns = interns;
        suggestions = [];
      });

      print("Search error: $e");
    }
  }
  void loadInterns() async {
    final data = await UserService.getInterns();

    if (!mounted) return;

    setState(() {
      filteredInterns = interns;
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

 /*     body: isLoading
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
    );*/
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // 🔍 SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  hintText: "Search interns...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  searchInterns(value);
                },
              ),

              const SizedBox(height: 10),

              if (suggestions.isNotEmpty)
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final item = suggestions[index];

                      return ListTile(
                        title: Text(item["name"] ?? ""),
                        subtitle: Text(item["status"] ?? ""),
                        onTap: () {
                          setState(() {
                            filteredInterns = [item];
                            suggestions = [];
                          });
                        },
                      );
                    },
                  ),
                ),

              const SizedBox(height: 10),

              // 📋 LIST
              Expanded(
                child: ListView.builder(
                  itemCount: filteredInterns.isEmpty
                      ? interns.length
                      : filteredInterns.length,

                  itemBuilder: (context, index) {
                    final intern = filteredInterns.isEmpty
                        ? interns[index]
                        : filteredInterns[index];

                    return _buildInternCard(index, intern);
                  },
                ),
              ),
            ],
          ),
        ))
    ;
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

                      for (var i in filteredInterns) {
                        if (i["id"] == intern["id"]) {
                          i["status"] = "approved";
                        }
                      }
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
                      for (var i in filteredInterns) {
                        if (i["id"] == intern["id"]) {
                          i["status"] = "rejected";
                        }
                      }
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