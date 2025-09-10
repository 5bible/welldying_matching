import 'package:flutter/material.dart';
import 'funeral_intro.dart';                // FuneralMatchingScreen 클래스 포함
import 'funeral_location.dart';             // FmOptionsPage 클래스 포함
import 'funeral_results.dart';     // FmResultsPage 클래스 포함
import 'funeral_detail.dart';      // FmDetailPage 클래스 포함
import 'funeral_reservation.dart'; // FmReservationPage 클래스 포함
import 'funeral_complete.dart';    // FmReservationCompletePage 클래스 포함
import 'funeral_cancel.dart';      // FmCancelPage 클래스 포함
import 'funeral_cancel_complete.dart'; // FmCancelCompletePage 클래스 포함
// 새가족 매칭 import
import 'new_family_intro.dart';
import 'new_family_guide.dart';
import 'new_family_conditions.dart';
import 'new_family_care_experience.dart';
import 'new_family_questionnaire.dart';
import 'new_family_results.dart';
import 'new_family_detail.dart';
import 'new_family_application.dart';



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
        // Funeral routes (기존 클래스명 사용)
        '/funeral/intro': (_) => const FuneralMatchingScreen(),
        '/funeral/location': (_) => const FmOptionsPage(),
        '/funeral/results': (_) => const FmResultsPage(),
        '/funeral/detail': (_) => const FmDetailPage(),
        '/funeral/reservation': (_) => const FmReservationPage(),
        '/funeral/complete': (_) => const FmReservationCompletePage(),
        '/funeral/cancel': (_) => const FmCancelPage(),
        '/funeral/cancel_complete': (_) => const FmCancelCompletePage(),

        // New Family routes  
        '/family/intro': (_) => const NewFamilyIntroScreen(),
        '/family/conditions': (_) => const NewFamilyConditionsPage(),
        '/family/guide': (_) => const NewFamilyGuidePage(),
        '/family/care_experience': (_) => const NewFamilyCareExperiencePage(),
        '/family/questionnaire': (_) => const NewFamilyQuestionnairePage(),
        '/family/results': (_) => const NewFamilyResultsPage(),
        '/family/detail': (_) => const NewFamilyDetailPage(),
        '/family/application': (_) => const NewFamilyApplicationPage(),
        // '/family/complete': (_) => const NewFamilyCompletePage(),
      },
      home: const FuneralMatchingScreen(),
    );
  }
}