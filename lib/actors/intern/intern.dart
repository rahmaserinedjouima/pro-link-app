import 'package:flutter/material.dart';
import 'package:pro_link/actors/intern/schedule.dart';
import 'package:pro_link/actors/intern/trainingFiles.dart';
import 'package:pro_link/actors/intern/workId.dart';
import '../../welcome/welcome.dart';
import 'marks.dart';
import 'package:pro_link/actors/intern/internAttendance.dart';

class InternPage extends StatelessWidget {
  const InternPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Intern Dashboard"),
        backgroundColor: const Color(0xFF3B3B6D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false,
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              "assets/logo.png",
              width: 70,
              height: 70,
            ),
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;

          int columns = 1;

          if (screenWidth > 900) {
            columns = 4;
          } else if (screenWidth > 600) {
            columns = 3;
          } else if (screenWidth > 400) {
            columns = 2;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: screenWidth > 600 ? 1.1 : 0.85,

              children: [

                _buildCard(
                  title: "Work ID",
                  image: "assets/id.png",
                  icon: Icons.badge,
                  description: "Your digital identity card",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkIdPage()),
                    );
                  },
                ),

                _buildCard(
                  title: "Schedule",
                  image: "assets/schedule.png",
                  icon: Icons.schedule,
                  description: "Weekly internship timetable",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SchedulePage()),
                    );
                  },
                ),

                _buildCard(
                  title: "Marks",
                  image: "assets/marks.png",
                  icon: Icons.bar_chart,
                  description: "Performance evaluation",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MarksPage()),
                    );
                  },
                ),

                _buildCard(
                  title: "Attendance",
                  image: "assets/attendance.png",
                  icon: Icons.check_circle,
                  description: "View your attendance",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InternAttendancePage()),
                    );
                  },
                ),

                _buildCard(
                  title: "Training",
                  image: "assets/training.png",
                  icon: Icons.folder,
                  description: "Learning resources",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrainingFilesPage()),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String image,
    required IconData icon,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              image,
              width: 65,
              height: 65,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}