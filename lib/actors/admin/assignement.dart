import 'package:flutter/material.dart';

class AssignInternPage extends StatefulWidget {
  const AssignInternPage({super.key});

  @override
  State<AssignInternPage> createState() => _AssignInternPageState();
}

class _AssignInternPageState extends State<AssignInternPage> {

  String? selectedIntern;
  String? selectedMentor;
  String? selectedDepartment;

  final List<String> interns = [
    "Ahmed Benali",
    "Sara Khelifa",
    "Yacine Bouzid",
  ];

  final List<String> mentors = [
    "Dr. Karim",
    "Ms. Nadia",
    "Mr. Samir",
  ];

  final List<String> departments = [
    "IT",
    "HR",
    "Finance",
  ];

  List<Map<String, String>> assignments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Assign Interns"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Create Assignment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 20),

            _buildDropdown(
              hint: "Select Intern",
              value: selectedIntern,
              items: interns,
              onChanged: (val) {
                setState(() => selectedIntern = val);
              },
            ),

            const SizedBox(height: 15),

            _buildDropdown(
              hint: "Select Mentor",
              value: selectedMentor,
              items: mentors,
              onChanged: (val) {
                setState(() => selectedMentor = val);
              },
            ),

            const SizedBox(height: 15),

            _buildDropdown(
              hint: "Select Department",
              value: selectedDepartment,
              items: departments,
              onChanged: (val) {
                setState(() => selectedDepartment = val);
              },
            ),

            const SizedBox(height: 20),

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

                onPressed:assignIntern,

                child: const Text("Assign",style: TextStyle(color: Colors.white,))
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Assigned Interns",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  final item = assignments[index];

                  return _buildAssignmentCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧩 Dropdown widget
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: DropdownButton<String>(
        value: value,
        hint: Text(hint),
        isExpanded: true,
        underline: const SizedBox(),

        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),

        onChanged: onChanged,
      ),
    );
  }

  Widget _buildAssignmentCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Intern: ${item["intern"]}"),
          Text("Mentor: ${item["mentor"]}"),
          Text("Department: ${item["department"]}"),
        ],
      ),
    );
  }


  void assignIntern() {
    if (selectedIntern == null ||
        selectedMentor == null ||
        selectedDepartment == null) {
      return;
    }

    assignments.add({
      "intern": selectedIntern!,
      "mentor": selectedMentor!,
      "department": selectedDepartment!,
    });

    setState(() {
      selectedIntern = null;
      selectedMentor = null;
      selectedDepartment = null;
    });
  }
}