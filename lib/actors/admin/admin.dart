import 'package:flutter/material.dart';
import 'package:pro_link/actors/admin/assignement.dart';
import 'package:pro_link/actors/admin/officeSchedule.dart';

import '../../welcome/welcome.dart';
import 'manageInterns.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Admin Dashboard"),
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

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85,

          children: [

            _buildCard(
              title: "Manage Interns",
              image: "assets/interns.png",
              description: "approve ,reject interns",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const  ManageInternsPage()),
                );

              },
            ),

           /* _buildCard(
              title: "Corporate Validation",
              image: "assets/verify.png",
              description: "Approve company registrations",
              onTap: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const  ManageInternsPage()),
              );},
            ),*/

            _buildCard(
              title: "Assign Mentors",
              image: "assets/assign.png",
              description: "Link interns to mentors and departments",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const  AssignInternPage()),
                );

              },
            ),

            _buildCard(
              title: "Schedules & Policies",
              image: "assets/schedule.png",
              description: "Upload office schedules & handbooks",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const  UploadSchedulePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String image,
    required String description,
    required VoidCallback onTap,
  }) {
   return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}