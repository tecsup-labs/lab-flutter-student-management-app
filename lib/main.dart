import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Alumnos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFFF7A00),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7A00),
          primary: const Color(0xFFFF7A00),
          surface: const Color(0xFFFFF9F5),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF9F5),
        // Configuración de tipografía por defecto limpia
        fontFamily: 'Outfit',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold, color: Color(0xFF2B231E)),
          bodyLarge: TextStyle(fontFamily: 'Outfit', color: Color(0xFF2B231E)),
          bodyMedium: TextStyle(fontFamily: 'Outfit', color: Color(0xFF70655E)),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
