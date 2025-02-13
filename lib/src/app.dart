import 'package:flutter/material.dart';
import 'package:headphones_app/src/overview/presentation/overview_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 0, 195, 254),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 0, 195, 254),
      ),
      home: const OverviewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
