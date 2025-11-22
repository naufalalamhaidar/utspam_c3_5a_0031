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
      title: 'CarRentApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          primary: Colors.yellow,
          secondary: Colors.yellow,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.yellow.shade50,
      ),
      home: const LoginPage(),
    );
  }
}
