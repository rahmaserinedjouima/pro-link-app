import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';

class InternAttendancePage extends StatefulWidget {
  const InternAttendancePage({super.key});

  @override
  State<InternAttendancePage> createState() => _InternAttendancePageState();
}

class _InternAttendancePageState extends State<InternAttendancePage> {
  List<dynamic> attendance = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  void loadAttendance() async {
    final data = await UserService.getAttendance();

    setState(() {
      attendance = data;
      isLoading = false;
    });
  }

  String getStatusText(String status) {
    if (status == "P") return "Present";
    if (status == "A") return "Absent";
    if (status == "L") return "Late";
    return status;
  }

  Color getStatusColor(String status) {
    if (status == "P") return Colors.green;
    if (status == "A") return Colors.red;
    if (status == "L") return Colors.orange;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("My Attendance"),
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
                child: attendance.isEmpty
                    ? const Center(child: Text("No attendance yet"))
                    : ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (context, index) {
                    final item = attendance[index];

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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item["attendance_date"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3B3B6D),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(item["status"]),
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: Text(
                              getStatusText(item["status"]),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}