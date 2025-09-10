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
}

class FuneralMatchingScreen extends StatefulWidget {
  const FuneralMatchingScreen({super.key});

  @override
  State<FuneralMatchingScreen> createState() => _FuneralMatchingScreenState();
}

class _FuneralMatchingScreenState extends State<FuneralMatchingScreen> {
  String selectedLocation = '서울 강남구';
  String selectedBudget = '50만원 이하';
  String selectedSchedule = '3일 이내';
  String selectedPetSize = '대형';

  final _budgetOptions = const ['50만원 이하', '50-100만원', '100-200만원', '200만원 이상'];
  final _scheduleOptions = const ['긴급', '3일 이내', '일주일 이내'];
  final _petSizeOptions = const ['소형', '중형', '대형'];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MediaQuery(
      data: mq.copyWith(textScaleFactor: mq.textScaleFactor.clamp(1.0, 1.1)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _HeaderBar(onBack: () => Navigator.maybePop(context)),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroCard(),
                      const SizedBox(height: 24),
                      _buildAiRecommendation(),
                      const SizedBox(height: 24),
                      _buildCurrentLocation(),
                      const SizedBox(height: 24),
                      const _SectionTitle(icon: Icons.attach_money, label: '예산 범위'),
                      const SizedBox(height: 12),
                      _ChipWrap(
                        options: _budgetOptions,
                        value: selectedBudget,
                        onChanged: (v) => setState(() => selectedBudget = v),
                      ),
                      const SizedBox(height: 24),
                      const _SectionTitle(icon: Icons.calendar_today, label: '희망 일정'),
                      const SizedBox(height: 12),
                      _ChipWrap(
                        options: _scheduleOptions,
                        value: selectedSchedule,
                        onChanged: (v) => setState(() => selectedSchedule = v),
                      ),
                      const SizedBox(height: 24),
                      const _SectionTitle(icon: Icons.pets, label: '반려동물 크기'),
                      const SizedBox(height: 12),
                      _ChipWrap(
                        options: _petSizeOptions,
                        value: selectedPetSize,
                        onChanged: (v) => setState(() => selectedPetSize = v),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onFind,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  '맞춤 시설 찾기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 상단 히어로 카드
  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.header,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.lightBrown,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.home, color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '가까운 곳에서 편안하게\n믿을 수 있는 시설을 찾아드려요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                _HeroPill(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiRecommendation() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.infoBlueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.infoBlueBorder, width: 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          children: [
            Icon(Icons.smart_toy, color: Color(0xFF1976D2), size: 18),
            SizedBox(width: 6),
            Text('AI 맞춤 추천', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          '매생이(미니어처푸들, 8살)의 프로필을 분석한 결과입니다.',
          style: TextStyle(fontSize: 12, color: Color(0xFF1976D2)),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _blueTag('위치 : $selectedLocation'),
            _blueTag('예산 : $selectedBudget'),
            _blueTag('일정 : $selectedSchedule'),
            _blueTag('크기 : $selectedPetSize'),
          ],
        ),
      ]),
    );
  }

  Widget _blueTag(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: AppColors.infoBlue, borderRadius: BorderRadius.circular(16)),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500)),
      );

  Widget _buildCurrentLocation() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(
        children: [
          Icon(Icons.place, color: Colors.red, size: 20),
          SizedBox(width: 8),
          Text('현재 위치', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.infoGreen, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(12)),
              child: const Text('AI추천',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('단골병원에서 3km / 평균 이동시간 15분',
                  style: TextStyle(fontSize: 14, color: Colors.black87)),
            ),
          ]),
          const SizedBox(height: 10),
          InkWell(
            onTap: _onLocationChange,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.my_location, color: Colors.red, size: 18),
                SizedBox(width: 6),
                Text('위치 변경', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ]),
      ),
    ]);
  }

  // ▶ 2번 화면으로 이동
  void _onFind() {
    Navigator.pushNamed(context, '/funeral/results'); // ✅ 3번 결과 페이지로 이동
  }

  void _onLocationChange() async {
    // 2번: 위치 설정 화면으로 이동하고, 선택한 값을 돌려받음
    final selected = await Navigator.pushNamed(context, '/funeral/location');

    if (selected is String && selected.isNotEmpty) {
      setState(() {
        selectedLocation = selected; // ✅ 상단/AI 추천의 '위치'가 즉시 갱신됨
      });
    }
  }
}

// —————————————————— 여기까지가 State 클래스의 끝입니다 ——————————————————

// 상단 히어로 카드의 보조 필
class _HeroPill extends StatelessWidget {
  const _HeroPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDEB887),
      ),
      child: const Text(
        '매생이를 위한 마지막 배웅 준비',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}

// 섹션 타이틀
class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: AppColors.accent, size: 20),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    ]);
  }
}

// 칩 그룹
class _ChipWrap extends StatelessWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String> onChanged;

  const _ChipWrap({required this.options, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final selected = value == opt;
        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(opt),
          ),
          selected: selected,
          onSelected: (_) => onChanged(opt),
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
          backgroundColor: Colors.white,
          selectedColor: AppColors.brown,
          shape: StadiumBorder(
            side: BorderSide(color: selected ? AppColors.brown : AppColors.border, width: 1),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.comfortable,
        );
      }).toList(),
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
            '장례 준비',
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
