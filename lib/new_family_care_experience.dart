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

class NewFamilyCareExperiencePage extends StatefulWidget {
  const NewFamilyCareExperiencePage({super.key});

  @override
  State<NewFamilyCareExperiencePage> createState() => _NewFamilyCareExperiencePageState();
}

class _NewFamilyCareExperiencePageState extends State<NewFamilyCareExperiencePage> {
  // 케어 경험 관련 답변들
  String? petExperience;
  String? separationExperience;
  String? emergencyPreparedness;
  String? financialPreparedness;
  String? dailyCareTime; // 🔧 수정: 변수명 통일
  List<String> careSkills = [];

  // 옵션들
  final List<String> experienceOptions = ['처음이에요', '기르다가 하늘나라로 보낸 경험 있어요', '현재도 키우고 있어요'];
  final List<String> separationOptions = ['경험해본 적 없어요', '힘들었지만 극복했어요', '여러 번 경험했어요'];
  final List<String> emergencyOptions = ['전혀 모르겠어요', '기본적인 응급처치는 알아요', '응급상황 대처에 자신 있어요'];
  final List<String> financialOptions = ['월 10만원 이하', '월 10-30만원', '월 30만원 이상 가능'];
  final List<String> dailyCareOptions = ['하루 1시간 정도', '하루 2-3시간', '하루 4시간 이상']; // 🔧 수정: 변수명 변경
  final List<String> skillOptions = ['기본 건강관리', '미용 관리', '행동 훈련', '응급처치', '약물 투여', '특별 케어'];

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
                      _buildImportantNotice(),
                      const SizedBox(height: 24),
                      _buildPetExperienceSection(),
                      const SizedBox(height: 24),
                      _buildSeparationSection(),
                      const SizedBox(height: 24),
                      _buildEmergencySection(),
                      const SizedBox(height: 24),
                      _buildFinancialSection(),
                      const SizedBox(height: 24),
                      _buildDailyCareSection(),
                      const SizedBox(height: 24),
                      _buildSkillsSection(),
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
                onPressed: _isFormValid() ? _onNextPressed : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: _isFormValid() ? AppColors.brown : Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '다음 단계',
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w600, 
                    color: _isFormValid() ? Colors.white : Colors.grey[600],
                  ),
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
                    '2',
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
                  '케어 경험을 알려주세요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Text(
                '2/3',
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
            '반려동물과 함께하는 경험과 준비 상태를\n솔직하게 알려주세요',
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

  // 중요 안내사항
  Widget _buildImportantNotice() {
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
          Icon(Icons.info_outline, color: AppColors.warningYellow, size: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '진솔한 답변이 중요해요',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '경험이 없어도 괜찮습니다. 정확한 정보를 바탕으로 가장 적합한 친구를 찾아드려요.',
                  style: TextStyle(
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

  // 반려동물 경험 섹션
  Widget _buildPetExperienceSection() {
    return _buildQuestionSection(
      '반려동물과 함께해본 경험이 있나요?',
      Icons.pets,
      _SingleChoiceChips(
        options: experienceOptions,
        value: petExperience,
        onChanged: (v) => setState(() => petExperience = v),
      ),
    );
  }

  // 이별 경험 섹션
  Widget _buildSeparationSection() {
    return _buildQuestionSection(
      '반려동물과의 이별을 경험해보셨나요?',
      Icons.favorite_border,
      _SingleChoiceChips(
        options: separationOptions,
        value: separationExperience,
        onChanged: (v) => setState(() => separationExperience = v),
      ),
    );
  }

  // 응급상황 준비 섹션
  Widget _buildEmergencySection() {
    return _buildQuestionSection(
      '응급상황에 대한 준비는 어느 정도인가요?',
      Icons.local_hospital,
      _SingleChoiceChips(
        options: emergencyOptions,
        value: emergencyPreparedness,
        onChanged: (v) => setState(() => emergencyPreparedness = v),
      ),
    );
  }

  // 경제적 준비 섹션
  Widget _buildFinancialSection() {
    return _buildQuestionSection(
      '월 평균 반려동물 관련 지출 가능 금액은?',
      Icons.account_balance_wallet,
      _SingleChoiceChips(
        options: financialOptions,
        value: financialPreparedness,
        onChanged: (v) => setState(() => financialPreparedness = v),
      ),
    );
  }

  // 일일 케어 시간 섹션
  Widget _buildDailyCareSection() {
    return _buildQuestionSection(
      '하루에 얼마나 많은 시간을 함께 할 수 있나요?',
      Icons.access_time,
      _SingleChoiceChips(
        options: dailyCareOptions,
        value: dailyCareTime,
        onChanged: (v) => setState(() => dailyCareTime = v),
      ),
    );
  }

  // 케어 스킬 섹션
  Widget _buildSkillsSection() {
    return _buildQuestionSection(
      '어떤 케어 경험이 있으신가요? (복수선택)',
      Icons.healing,
      _MultiChoiceChips(
        options: skillOptions,
        values: careSkills,
        onChanged: (v) => setState(() => careSkills = v),
      ),
    );
  }

  // 질문 섹션 빌더
  Widget _buildQuestionSection(String question, IconData icon, Widget choiceWidget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                question,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        choiceWidget,
      ],
    );
  }

  // 폼 유효성 검사
  bool _isFormValid() {
    return petExperience != null &&
           separationExperience != null &&
           emergencyPreparedness != null &&
           financialPreparedness != null &&
           dailyCareTime != null;
  }

  // 다음 단계로
  void _onNextPressed() {
    Navigator.pushNamed(context, '/family/questionnaire');
  }
}

// 단일 선택 칩
class _SingleChoiceChips extends StatelessWidget {
  final List<String> options;
  final String? value;
  final ValueChanged<String> onChanged;

  const _SingleChoiceChips({
    required this.options,
    required this.value,
    required this.onChanged,
  });

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

// 다중 선택 칩
class _MultiChoiceChips extends StatelessWidget {
  final List<String> options;
  final List<String> values;
  final ValueChanged<List<String>> onChanged;

  const _MultiChoiceChips({
    required this.options,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final selected = values.contains(opt);
        return FilterChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(opt),
          ),
          selected: selected,
          onSelected: (isSelected) {
            final newValues = List<String>.from(values);
            if (isSelected) {
              newValues.add(opt);
            } else {
              newValues.remove(opt);
            }
            onChanged(newValues);
          },
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
          backgroundColor: Colors.white,
          selectedColor: AppColors.brown,
          checkmarkColor: Colors.white,
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
            '2/3',
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