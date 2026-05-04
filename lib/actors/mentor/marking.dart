import 'package:flutter/material.dart';
import 'package:pro_link/services/user_service.dart';

class MarkingPage extends StatefulWidget {
  const MarkingPage({super.key});

  @override
  State<MarkingPage> createState() => _MarkingPageState();
}

class _MarkingPageState extends State<MarkingPage> {
  final TextEditingController _markController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  List<dynamic> interns = [];
  String? selectedIntern;
  bool isLoading = true;

  List<Map<String, dynamic>> evaluations = [];

  @override
  void initState() {
    super.initState();
    loadInterns();
    loadEvaluations();
  }
  void loadEvaluations() async {
    final data = await UserService.getEvaluations();

    setState(() {
      evaluations = data.map<Map<String, dynamic>>((item) {
        return {
          "intern": item["intern_name"],
          "mark": item["mark"],
          "feedback": item["feedback"],
        };
      }).toList();
    });
  }

 /*void loadInterns() async {
    final data = await UserService.getAssignedInterns();

    setState(() {
      interns = data;
      isLoading = false;
    });
  }*/
  // ---- keep assigned interns to theat teacher only if theyre approved
  void loadInterns() async {
    final assigned = await UserService.getAssignedInterns();
    final approved = await UserService.getApprovedInterns();

    List filtered = [];
    print("🔵 ASSIGNED:");
    print(assigned);

    print("🟢 APPROVED:");
    print(approved);
    for (var a in assigned) {
      for (var p in approved) {
        if (a["id"].toString() == p["id"].toString()) {
          filtered.add(a);
          break;
        }
      }
    }

    setState(() {
      interns = filtered;
      isLoading = false;
    });
  }

  void updatePerformance() async {
    if (selectedIntern == null ||
        _markController.text.isEmpty ||
        _feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final result = await UserService.addEvaluation(
      selectedIntern!,
      _markController.text,
      _feedbackController.text,
    );

    if (result["success"] == true) {
      final internName = interns.firstWhere(
            (user) => user["id"].toString() == selectedIntern,
      )["name"];

      setState(() {
        evaluations.add({
          "intern": internName,
          "mark": _markController.text,
          "feedback": _feedbackController.text,
        });

        selectedIntern = null;
        _markController.clear();
        _feedbackController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Evaluation saved successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Evaluate Intern"),
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
              "Intern Evaluation Form",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Select intern"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedIntern,
                hint: const Text("Choose intern"),
                isExpanded: true,
                underline: const SizedBox(),
                items: interns.map((intern) {
                  return DropdownMenuItem<String>(
                    value: intern["id"].toString(),
                    child: Text(intern["name"]),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedIntern = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            const Text("Mark (/20)"),
            TextField(
              controller: _markController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 15),

            const Text("Feedback"),
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3B6D),
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: updatePerformance,
                child: const Text(
                  "Save Evaluation",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Saved Evaluations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B6D),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: evaluations.length,
                itemBuilder: (context, index) {
                  final item = evaluations[index];

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Intern: ${item["intern"]}"),
                        Text("Mark: ${item["mark"]}/20"),
                        Text("Feedback: ${item["feedback"]}"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}