import 'package:flutter/material.dart';
import 'funeral_matching_1.dart';
import 'funeral_matching_2.dart';

class AppRoutes {
  static const fmIntro   = '/fm/intro';
  static const fmOptions = '/fm/options';
  static const fmResults = '/fm/results';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.fmIntro:
      return MaterialPageRoute(builder: (_) => const FuneralMatchingScreen());
    case AppRoutes.fmOptions:
      return MaterialPageRoute(builder: (_) => const FmOptionsPage());
    case AppRoutes.fmResults:
      return MaterialPageRoute(builder: (_) => const _ResultsPlaceholder());
    default:
      return MaterialPageRoute(builder: (_) => const FuneralMatchingScreen());
  }
}

// 임시 결과 화면 (funeral_matching_3.dart 준비 전)
class _ResultsPlaceholder extends StatelessWidget {
  const _ResultsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(title: const Text('결과 보기')),
      body: const Center(
        child: Text(
          '결과 페이지는 준비 중입니다.\n라우트를 성공적으로 탐색했습니다!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
