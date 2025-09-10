import 'package:flutter/material.dart';

// 색상 토큰
class AppColors {
  static const brown = Color(0xFF8C6239);
  static const lightBrown = Color(0xFFF0E6D6);
  static const background = Color(0xFFF5F5F5);
  static const border = Color(0xFFE1D7C7);

  static const accent = Color(0xFFD2691E);
  static const header = Color(0xFFEDE6DC);
  static const infoBlue = Color(0xFF1E88E5);
  static const infoBlueLight = Color(0xFFE8F4FF);
  static const infoBlueBorder = Color(0xFF90CAF9);
  static const infoGreen = Color(0xFFEFF7E9);
  static const greenAccent = Color(0xFF4CAF50);
}

class NewFamilyIntroScreen extends StatefulWidget {
  const NewFamilyIntroScreen({super.key});

  @override
  State<NewFamilyIntroScreen> createState() => _NewFamilyIntroScreenState();
}

class _NewFamilyIntroScreenState extends State<NewFamilyIntroScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MediaQuery(
      data: mq.copyWith(textScaleFactor: mq.textScaleFactor.clamp(1.0, 1.1)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _HeaderBar(onBack: () => Navigator.maybePop(context)),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        _buildHeroSection(),
                        const SizedBox(height: 60),
                        _buildSupportCard(),
                        const SizedBox(height: 40),
                        _buildStatsSection(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // 중앙 히어로 섹션
  Widget _buildHeroSection() {
    return Column(
      children: [
        // 새싹 아이콘
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 흙 부분
              Positioned(
                bottom: 0,
                child: Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513), // 갈색 흙
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              // 새싹 부분
              Positioned(
                top: 0,
                child: Container(
                  width: 40,
                  height: 50,
                  child: Stack(
                    children: [
                      // 줄기
                      Positioned(
                        left: 18,
                        top: 20,
                        child: Container(
                          width: 4,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // 왼쪽 잎
                      Positioned(
                        left: 5,
                        top: 10,
                        child: Container(
                          width: 18,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF66BB6A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      // 오른쪽 잎
                      Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          width: 18,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 40),
        
        // 메인 제목
        const Text(
          '새로운 시작을 함께 해요',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // 부제목
        const Column(
          children: [
            Text(
              '충분히 마음의 준비가 되셨나요?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              '새 가족을 맞이하는 것은 소중한 결정입니다.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              '"모든 생명은 사람답 자격이 있어요."',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  // 도움 지원 카드
  Widget _buildSupportCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '우리가 도와드릴게요',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildSupportItem(
            Icons.smart_toy,
            'AI 맞춤 추천으로 최적의 친구 찾기',
            const Color(0xFFE91E63),
          ),
          _buildSupportItem(
            Icons.verified_user,
            '검증된 보호소와 안전한 입양 연계',
            const Color(0xFF4CAF50),
          ),
          _buildSupportItem(
            Icons.favorite,
            '입양 후 적응 가이드와 의료 지원',
            const Color(0xFF2196F3),
          ),
          _buildSupportItem(
            Icons.groups,
            '새 가족 커뮤니티와 경험 공유',
            const Color(0xFFFF9800),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportItem(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 통계 섹션
  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('2,847', '성공한 매칭'),
          Container(
            width: 1,
            height: 40,
            color: AppColors.border,
          ),
          _buildStatItem('96%', '만족도'),
          Container(
            width: 1,
            height: 40,
            color: AppColors.border,
          ),
          _buildStatItem('127', '제휴 보호소'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.brown,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // 하단 버튼들
  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _onGuidePressed,
                icon: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.brown,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.menu_book, color: Colors.white, size: 12),
                ),
                label: const Text(
                  '준비 가이드 보기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _onStartMatching,
                icon: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 12),
                ),
                label: const Text(
                  '매칭 시작하기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 매칭 시작
  void _onStartMatching() {
    Navigator.pushNamed(context, '/family/conditions');
  }

  // 가이드 보기
  void _onGuidePressed() {
    Navigator.pushNamed(context, '/family/guide');
  }
}

// 상단 커스텀 헤더
class _HeaderBar extends StatelessWidget {
  final VoidCallback onBack;
  const _HeaderBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            tooltip: '뒤로',
          ),
          const SizedBox(width: 4),
          const Text(
            '새 가족 매칭',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}