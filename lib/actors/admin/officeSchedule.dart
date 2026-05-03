import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pro_link/services/user_service.dart';

class UploadSchedulePage extends StatefulWidget {
  const UploadSchedulePage({super.key});

  @override
  State<UploadSchedulePage> createState() => _UploadSchedulePageState();
}

class _UploadSchedulePageState extends State<UploadSchedulePage> {
  final TextEditingController _titleController = TextEditingController();

  String? fileName;
  String? filePath;

  void uploadSchedule() async {
    if (_titleController.text.isEmpty || fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add title and file")),
      );
      return;
    }

    final result = await UserService.uploadSchedule(
      _titleController.text,
      filePath!,
    );

    if (result["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF3B3B6D),
          content: Text("Schedule saved successfully"),
        ),
      );

      _titleController.clear();

      setState(() {
        fileName = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"])),
      );
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Upload Office Schedule"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Schedule / Policy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Enter title (e.g. Weekly Schedule)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.upload_file,
                      color: Color(0xFF3B3B6D),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        fileName ?? "Tap here to upload PDF",
                        style: TextStyle(
                          color: fileName == null ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3B6D),
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: uploadSchedule,
                child: const Text(
                  "Upload",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}