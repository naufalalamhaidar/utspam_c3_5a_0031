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
