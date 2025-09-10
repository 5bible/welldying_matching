import 'package:flutter/material.dart';
import 'funeral_matching_1.dart';
import 'funeral_matching_2.dart';
import 'funeral_matching_3.dart';
import 'funeral_matching_4.dart';
import 'funeral_matching_5.dart'; // 새로 추가

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welldying',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'NotoSans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: false,
        ),
      ),
      routes: {
        '/fm/intro'      : (_) => const FuneralMatchingScreen(),
        '/fm/options'    : (_) => const FmOptionsPage(),
        '/fm/results'    : (_) => const FmResultsPage(),
        '/fm/detail'     : (_) => const FmDetailPage(),
        '/fm/reservation': (_) => const FmReservationPage(), // 새로 추가
      },
      initialRoute: '/fm/intro',
    );
  }
}