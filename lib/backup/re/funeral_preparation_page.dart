import 'package:flutter/material.dart';
import 'funeral_matching_1.dart'; // FmIntroPage(맞춤 시설 찾기) 화면

class FuneralPreparationScreen extends StatelessWidget {
  const FuneralPreparationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '장례 준비',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6D6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('가까운 곳에서 편안하게\n믿을 수 있는 시설을 찾아드려요',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('매생이를 위한 마지막 배웅 준비',
                    style:
                        TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.search),
            label: const Text('맞춤 시설 찾기'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FmIntroPage()),
                // 또는 라우트 네임 사용 시: Navigator.pushNamed(context, '/fm/intro');
              );
            },
          ),
        ],
      ),
    );
  }
}
