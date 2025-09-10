import 'package:flutter/material.dart';
import 'funeral_matching_1.dart';
import 'funeral_matching_2.dart';
import 'funeral_matching_3.dart';

void main() => runApp(const MyApp());

class AppRoutes {
  static const fmIntro = '/fm/intro';
  static const fmOptions = '/fm/options';
  static const fmResults = '/fm/results';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 개발 지침에 따른 정확한 색상값
    const primaryBrown = Color(0xFF8C6239);    // 갈색 (주 색상)
    const accentOrange = Color(0xFFD2691E);    // 액센트 오렌지
    const bg = Color(0xFFF5F5F5);              // 라이트 배경
    const card = Color(0xFFEDE6DC);            // 베이지 카드

    return MaterialApp(
      title: 'Welldying',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,  // Material 3 비활성화로 색상 자동 생성 방지
        primarySwatch: Colors.brown,
        primaryColor: primaryBrown,
        colorScheme: const ColorScheme.light(
          primary: primaryBrown,
          secondary: accentOrange,
          surface: bg,
          background: bg,
        ),
        scaffoldBackgroundColor: bg,
        cardColor: card,
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
        ),
        chipTheme: const ChipThemeData(
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        // FilledButton 테마도 갈색으로 설정
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primaryBrown,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: AppRoutes.fmIntro,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.fmIntro:
            return MaterialPageRoute(builder: (_) => const FmIntroPage());
          case AppRoutes.fmOptions:
            return MaterialPageRoute(builder: (_) => const FmOptionsPage());
          case AppRoutes.fmResults:
            return MaterialPageRoute(
              builder: (_) => FmResultsPage(
                args: settings.arguments is FmSearchArgs
                    ? settings.arguments as FmSearchArgs
                    : const FmSearchArgs(),
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => const FmIntroPage());
        }
      },
    );
  }
}