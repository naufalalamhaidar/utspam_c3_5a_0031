import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'utspam_c3_5a_0031',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          primary: Colors.amber[700],
          secondary: Colors.amber[700],
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.amber.shade50,
      ),
      home: const LoginPage(),
    );
  }
}
