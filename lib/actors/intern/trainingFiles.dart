import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingFilesPage extends StatefulWidget {
  const TrainingFilesPage({super.key});

  @override
  State<TrainingFilesPage> createState() => _TrainingFilesPageState();
}

class _TrainingFilesPageState extends State<TrainingFilesPage> {
  List<dynamic> files = [];
  List<dynamic> filteredFiles = [];
  List<dynamic> suggestions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  void loadFiles() async {
    final data = await UserService.getTrainingFiles();

    setState(() {
      files = data;
      filteredFiles = data;
      isLoading = false;
    });
  }
  //------------search files function
  void searchFiles(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredFiles = files;
        suggestions = [];
      });
      return;
    }

    final results = await UserService.searchTrainingFiles(query);

    setState(() {
      filteredFiles = results;
      suggestions = results.take(5).toList(); // simple suggestions
    });
  }
  void openFile(String filePath) async {
    final url = Uri.parse("http://localhost/flutter_api/$filePath");

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Training Files"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search training files...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
               searchFiles(value);
              },
            ),
            const SizedBox(height:10),
            //---------suggestions -----------
            if (suggestions.isNotEmpty)
              Container(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final item = suggestions[index];

                    return ListTile(
                      leading: const Icon(Icons.search),
                      title: Text(item["title"] ?? ""),
                      onTap: () {
                        openFile(item["file_path"]);

                        setState(() {
                          suggestions = [];
                        });
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 15),
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
              child: filteredFiles.isEmpty
                  ? const Center(child: Text("No training files yet"))
                  : ListView.builder(
                itemCount: filteredFiles.length,
               // itemCount: files.length,
                itemBuilder: (context, index) {
                  final item = filteredFiles[index];
                //  final item = files[index];

                  return _buildFileCard(
                    title: item["title"],
                    fileName: item["file_name"],
                    filePath: item["file_path"],
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
    required String fileName,
    required String filePath,
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
        leading: const Icon(
          Icons.picture_as_pdf,
          color: Color(0xFF3B3B6D),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B3B6D),
          ),
        ),
        subtitle: Text(fileName),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          openFile(filePath);
        },
      ),
    );
  }
}