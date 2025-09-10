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

class NewFamilyConditionsPage extends StatefulWidget {
  const NewFamilyConditionsPage({super.key});

  @override
  State<NewFamilyConditionsPage> createState() => _NewFamilyConditionsPageState();
}

class _NewFamilyConditionsPageState extends State<NewFamilyConditionsPage> {
  // 선택된 조건들
  String selectedHouseType = '아파트';
  String selectedSpaceSize = '소형 (20평 이하)';
  String selectedAge = '1-3세';
  String selectedSize = '소형견';

  // 옵션들
  final List<String> houseTypes = ['아파트', '단독주택', '원룸/오피스텔', '기타'];
  final List<String> spaceSizes = ['소형 (20평 이하)', '중형 (20-40평)', '대형 (40평 이상)'];
  final List<String> ageOptions = ['1년 미만', '1-3세', '중성견 (4-7세)', '어른견 (8세 이상)'];
  final List<String> sizeOptions = ['소형견', '중형견', '대형견'];

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
                      _buildProgressHeader(),
                      const SizedBox(height: 24),
                      _buildHelpCard(),
                      const SizedBox(height: 24),
                      _buildHouseTypeSection(),
                      const SizedBox(height: 24),
                      _buildSpaceSizeSection(),
                      const SizedBox(height: 24),
                      _buildAgeSection(),
                      const SizedBox(height: 24),
                      _buildSizeSection(),
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
                onPressed: _onNextPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  '다음 단계',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 진행률 헤더
  Widget _buildProgressHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.header,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.greenAccent,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '환경을 알려주세요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Text(
                '1/3',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '우리 집 환경에 맞는 친구를\n찾아드릴게요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // 도움말 카드
  Widget _buildHelpCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.infoBlueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.infoBlueBorder, width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.infoBlue, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '모든 조건을 나중에 변경할 수 있어요. 지금은 대략적인 선호도를 알려주세요.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.infoBlue,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 거주 환경 섹션
  Widget _buildHouseTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(icon: Icons.home, label: '거주 환경'),
        const SizedBox(height: 12),
        _ChipWrap(
          options: houseTypes,
          value: selectedHouseType,
          onChanged: (v) => setState(() => selectedHouseType = v),
        ),
      ],
    );
  }

  // 공간 크기 섹션
  Widget _buildSpaceSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(icon: Icons.square_foot, label: '생활 공간 크기'),
        const SizedBox(height: 12),
        _ChipWrap(
          options: spaceSizes,
          value: selectedSpaceSize,
          onChanged: (v) => setState(() => selectedSpaceSize = v),
        ),
      ],
    );
  }

  // 나이 섹션
  Widget _buildAgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(icon: Icons.cake, label: '선호 연령'),
        const SizedBox(height: 12),
        _ChipWrap(
          options: ageOptions,
          value: selectedAge,
          onChanged: (v) => setState(() => selectedAge = v),
        ),
      ],
    );
  }

  // 크기 섹션
  Widget _buildSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(icon: Icons.pets, label: '선호 크기'),
        const SizedBox(height: 12),
        _ChipWrap(
          options: sizeOptions,
          value: selectedSize,
          onChanged: (v) => setState(() => selectedSize = v),
        ),
      ],
    );
  }

  // 다음 단계로
  void _onNextPressed() {
    Navigator.pushNamed(context, '/family/care_experience');
  }
}

// 섹션 타이틀
class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
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
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
            '새 가족 매칭',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Text(
            '1/3',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}