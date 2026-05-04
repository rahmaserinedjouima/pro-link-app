import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<dynamic> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  void openPdf(String filePath) async {
    final url = Uri.parse("http://localhost/flutter_api/$filePath");

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  void loadSchedules() async {
    final data = await UserService.getSchedules();

    setState(() {
      schedules = data;
      isLoading = false;
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

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double containerWidth = screenWidth > 700 ? 700 : screenWidth;

          return Center(
            child: SizedBox(
              width: containerWidth,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Uploaded Schedules",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B3B6D),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Expanded(
                      child: schedules.isEmpty
                          ? const Center(
                        child: Text("No schedules uploaded yet"),
                      )
                          : ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final item = schedules[index];

                          return GestureDetector(
                            onTap: () {
                              openPdf(item["file_path"]);
                            },
                            child: _buildScheduleCard(
                              title: item["title"],
                              fileName: item["file_name"],
                              filePath: item["file_path"],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleCard({
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

      child: Row(
        children: [
          const Icon(
            Icons.picture_as_pdf,
            color: Color(0xFF3B3B6D),
            size: 35,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B3B6D),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  filePath,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
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