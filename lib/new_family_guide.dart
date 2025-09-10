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
  static const warningYellow = Color(0xFFFFC107);
  static const warningYellowLight = Color(0xFFFFF8E1);
}

class NewFamilyGuidePage extends StatefulWidget {
  const NewFamilyGuidePage({super.key});

  @override
  State<NewFamilyGuidePage> createState() => _NewFamilyGuidePageState();
}

class _NewFamilyGuidePageState extends State<NewFamilyGuidePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _HeaderBar(onBack: () => Navigator.maybePop(context)),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildPreparationPage(),
                  _buildCostPage(),
                  _buildHealthcarePage(),
                  _buildTipsPage(),
                ],
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // 1페이지: 기본 준비사항
  Widget _buildPreparationPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            '입양 전 준비사항',
            '새 가족을 맞이하기 전에\n꼭 준비해야 할 것들이에요',
            Icons.checklist,
            AppColors.greenAccent,
          ),
          const SizedBox(height: 24),
          _buildChecklistCard([
            '사료와 물그릇 준비',
            '편안한 잠자리 (방석, 이불)',
            '목줄과 인식표',
            '장난감 (씹을 수 있는 것)',
            '배변패드와 배변함',
            '기본 미용용품 (브러시, 손톱깎이)',
          ]),
          const SizedBox(height: 20),
          _buildWarningCard(
            '중요!',
            '입양 첫 주는 적응기간입니다. 조용하고 안전한 환경을 만들어주세요.',
          ),
        ],
      ),
    );
  }

  // 2페이지: 비용 안내
  Widget _buildCostPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            '예상 비용 안내',
            '반려동물과 함께하는 데\n필요한 비용을 미리 알아보세요',
            Icons.attach_money,
            AppColors.accent,
          ),
          const SizedBox(height: 24),
          _buildCostItem('초기 준비비용', '15-30만원', '사료, 용품, 기본 준비물'),
          _buildCostItem('예방접종', '10-15만원', '기본 백신, 광견병 등'),
          _buildCostItem('중성화 수술', '15-25만원', '건강과 행동 관리를 위해'),
          _buildCostItem('월 사료비', '3-8만원', '크기와 사료 종류에 따라'),
          _buildCostItem('정기 건강검진', '5-10만원', '6개월-1년마다'),
          const SizedBox(height: 20),
          _buildInfoCard(
            '반려동물은 평균 12-15년을 함께합니다. 장기간의 책임과 비용을 고려해주세요.',
          ),
        ],
      ),
    );
  }

  // 3페이지: 건강관리
  Widget _buildHealthcarePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            '건강관리 가이드',
            '건강한 새 가족과 오래도록\n함께하는 방법이에요',
            Icons.favorite,
            Colors.red,
          ),
          const SizedBox(height: 24),
          _buildHealthSection('예방접종 스케줄', [
            '6-8주: 1차 종합백신',
            '9-11주: 2차 종합백신',
            '12-14주: 3차 종합백신',
            '16주 이후: 광견병 백신',
          ]),
          const SizedBox(height: 20),
          _buildHealthSection('일상 관리', [
            '매일: 사료, 물, 산책',
            '주 2-3회: 브러싱',
            '월 1회: 목욕 (필요시)',
            '분기별: 건강검진',
          ]),
          const SizedBox(height: 20),
          _buildWarningCard(
            '응급상황 대비',
            '24시간 동물병원 연락처를 미리 저장해두세요. 갑작스런 증상 변화를 주의깊게 관찰하세요.',
          ),
        ],
      ),
    );
  }

  // 4페이지: 입양 팁
  Widget _buildTipsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            '성공적인 입양 팁',
            '새 가족과의 첫 만남을\n성공적으로 만드는 방법이에요',
            Icons.lightbulb,
            AppColors.warningYellow,
          ),
          const SizedBox(height: 24),
          _buildTipCard(
            '첫 만남에서',
            '차분하게 접근하고, 강제로 만지려 하지 마세요. 냄새를 맡게 해주고 스스로 다가올 때까지 기다리세요.',
            Icons.handshake,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            '집에 도착한 후',
            '처음 며칠은 한 공간에서 지내게 하여 안정감을 주세요. 너무 많은 자극은 스트레스를 줄 수 있어요.',
            Icons.home,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            '기존 반려동물이 있다면',
            '서로 적응할 시간을 충분히 주세요. 처음에는 분리된 공간에서 냄새로 익숙해지게 하세요.',
            Icons.pets,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            '훈련과 교육',
            '일관된 규칙과 긍정적 강화로 훈련하세요. 인내심을 갖고 천천히 진행하는 것이 중요해요.',
            Icons.school,
          ),
        ],
      ),
    );
  }

  // 페이지 헤더
  Widget _buildPageHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 체크리스트 카드
  Widget _buildChecklistCard(List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.greenAccent, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  // 비용 항목
  Widget _buildCostItem(String title, String cost, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            cost,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  // 건강관리 섹션
  Widget _buildHealthSection(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // 팁 카드
  Widget _buildTipCard(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoBlueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.infoBlueBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.infoBlue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 경고 카드
  Widget _buildWarningCard(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warningYellowLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warningYellow.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning, color: AppColors.warningYellow, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 정보 카드
  Widget _buildInfoCard(String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.greenAccent, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 하단 내비게이션
  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          // 페이지 인디케이터
          Row(
            children: List.generate(_totalPages, (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: index == _currentPage ? AppColors.brown : AppColors.border,
                shape: BoxShape.circle,
              ),
            )),
          ),
          const Spacer(),
          // 이전/다음 버튼
          if (_currentPage > 0)
            TextButton(
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: const Text('이전'),
            ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _currentPage == _totalPages - 1
                ? () => Navigator.maybePop(context)
                : () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brown,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              _currentPage == _totalPages - 1 ? '완료' : '다음',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
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
            '준비 가이드',
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