import 'package:flutter/material.dart';
import 'package:app_tuan_08/app/page/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // initialRoute: "/",
      // onGenerateRoute: AppRoute.onGenerateRoute,  -> su dung auto route (pushName)
    );
  }
}
