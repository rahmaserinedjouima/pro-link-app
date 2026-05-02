import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static String currentUserId = "";
  static const String baseUrl = "http://localhost/flutter_api";

  // GET ALL USERS
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_users.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
  // LOGIN USER
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login.php"),
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed");
    }
  }
  // UPDATE USER STATUS
  static Future<Map<String, dynamic>> updateUserStatus(
      String id,
      String status,
      ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/update_user_status.php"),
      body: {
        "id": id,
        "status": status,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to update status");
    }
  }
  // GET APPROVED INTERNS
  static Future<List<dynamic>> getApprovedInterns() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_interns.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load interns");
    }
  }

// GET APPROVED MENTORS
  static Future<List<dynamic>> getApprovedMentors() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_mentors.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load mentors");
    }
  }
  // ADD ASSIGNMENT
  static Future<Map<String, dynamic>> addAssignment(
      String internId,
      String mentorId,
      String department,
      ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add_assignment.php"),
      body: {
        "intern_id": internId,
        "mentor_id": mentorId,
        "department": department,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to save assignment");
    }
  }
  // GET ASSIGNMENTS
  static Future<List<dynamic>> getAssignments() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_assignments.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load assignments");
    }
  }
  // UPLOAD SCHEDULE
  static Future<Map<String, dynamic>> uploadSchedule(
      String title,
      String filePath,
      ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/upload_schedule.php"),
    );

    request.fields['title'] = title;

    request.files.add(
      await http.MultipartFile.fromPath('file', filePath),
    );

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    print(responseData);

    return jsonDecode(responseData);
  }

  // GET SCHEDULES
  static Future<List<dynamic>> getSchedules() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_schedules.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load schedules");
    }
  }
  // UPLOAD TRAINING FILE
  static Future<Map<String, dynamic>> uploadTraining(
      String title,
      String filePath,
      ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/upload_training.php"),
    );

    request.fields['title'] = title;
    request.fields['uploaded_by'] = "2";

    request.files.add(
      await http.MultipartFile.fromPath('file', filePath),
    );

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    print(responseData);

    return jsonDecode(responseData);
  }

// GET TRAINING FILES
  static Future<List<dynamic>> getTrainingFiles() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_training.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load training files");
    }
  }
  // ADD ATTENDANCE
  static Future<Map<String, dynamic>> addAttendance(
      String internId,
      String attendanceDate,
      String status,
      ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add_attendance.php"),
      body: {
        "intern_id": internId,
        "attendance_date": attendanceDate,
        "status": status,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to save attendance");
    }
  }
  // GET ATTENDANCE
  static Future<List<dynamic>> getAttendance() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_attendance.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load attendance");
    }
  }
  // ADD EVALUATION
  static Future<Map<String, dynamic>> addEvaluation(
      String internId,
      String mark,
      String feedback,
      ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add_evaluation.php"),
      body: {
        "intern_id": internId,
        "mentor_id": currentUserId,
        "mark": mark,
        "feedback": feedback,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to save evaluation");
    }
  }

// GET EVALUATIONS
  static Future<List<dynamic>> getEvaluations() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_evaluations.php"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load evaluations");
    }
  }
  // GET ASSIGNED INTERNS FOR MENTOR
  static Future<List<dynamic>> getAssignedInterns() async {
    final response = await http.get(
      Uri.parse("$baseUrl/read_assigned_interns.php?mentor_id=$currentUserId"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load assigned interns");
    }
  }
}
