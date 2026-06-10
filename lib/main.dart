import 'package:flutter/cupertino.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Gestor de Alumnos',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: Color(0xFFFF7A00),
        scaffoldBackgroundColor: Color(0xFFFFF9F5),
        textTheme: CupertinoTextThemeData(
          primaryColor: Color(0xFFFF7A00),
          textStyle: TextStyle(fontFamily: 'Outfit', color: Color(0xFF2B231E)),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
