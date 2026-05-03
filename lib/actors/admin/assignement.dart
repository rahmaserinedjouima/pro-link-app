import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';

class AssignInternPage extends StatefulWidget {
  const AssignInternPage({super.key});

  @override
  State<AssignInternPage> createState() => _AssignInternPageState();
}

class _AssignInternPageState extends State<AssignInternPage> {

  String? selectedIntern;
  String? selectedMentor;
  String? selectedDepartment;

  List<dynamic> interns = [];
  List<dynamic> mentors = [];
  bool isLoading = true;

  final List<String> departments = [
    "IT",
    "HR",
    "Finance",
  ];

  List<Map<String, String>> assignments = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final internsData = await UserService.getApprovedInterns();
    final mentorsData = await UserService.getApprovedMentors();
    final assignmentsData = await UserService.getAssignments();

    setState(() {
      interns = internsData;
      mentors = mentorsData;

      assignments = assignmentsData.map<Map<String, String>>((item) {
        return {
          "intern": item["intern_name"].toString(),
          "mentor": item["mentor_name"].toString(),
          "department": item["department"].toString(),
        };
      }).toList();

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Assign Interns"),
        backgroundColor: const Color(0xFF3B3B6D),
      ),

      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
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

            _buildUserDropdown(
              hint: "Select Intern",
              value: selectedIntern,
              items: interns,
              onChanged: (val) {
                setState(() => selectedIntern = val);
              },
            ),

            const SizedBox(height: 15),

            _buildUserDropdown(
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

  Widget _buildUserDropdown({
    required String hint,
    required String? value,
    required List<dynamic> items,
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
        items: items.map((user) {
          return DropdownMenuItem<String>(
            value: user["id"].toString(),
            child: Text(user["name"]),
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


  void assignIntern() async {
    if (selectedIntern == null ||
        selectedMentor == null ||
        selectedDepartment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select all fields")),
      );
      return;
    }

    final result = await UserService.addAssignment(
      selectedIntern!,
      selectedMentor!,
      selectedDepartment!,
    );

    if (result["success"] == true) {
      final internName = interns.firstWhere(
            (user) => user["id"].toString() == selectedIntern,
      )["name"];

      final mentorName = mentors.firstWhere(
            (user) => user["id"].toString() == selectedMentor,
      )["name"];

      setState(() {
        assignments.add({
          "intern": internName,
          "mentor": mentorName,
          "department": selectedDepartment!,
        });

        selectedIntern = null;
        selectedMentor = null;
        selectedDepartment = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Assignment saved")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"])),
      );
    }
  }

}