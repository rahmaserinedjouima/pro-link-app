import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_link/actors/intern/intern.dart';
import '../welcome/welcome.dart';
import 'actors/mentor/mentor.dart';
import 'actors/admin/admin.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF3B3B6D),
          secondary: Color(0xFF000000)
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F6F8),
        textTheme: GoogleFonts.interTextTheme(),
      ),

     // home: const AdminPage(),
    home: const WelcomePage(),
     // home: const InternPage(),
    );
  }
}