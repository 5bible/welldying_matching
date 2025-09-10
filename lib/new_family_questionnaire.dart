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

// 🔧 추가: SurveyAnswers 모델 (results 파일과 연동)
class SurveyAnswers {
  final String housingLabel;
  final String spaceLabel;
  final bool hasKids;
  final String workTypeLabel;
  final String experienceLabel;
  final String activityLabel;
  final String budgetLabel;
  final String readinessLabel;
  final double? userLat;
  final double? userLng;
  final List<String> preferredTraits;

  const SurveyAnswers({
    required this.housingLabel,
    required this.spaceLabel,
    required this.hasKids,
    required this.workTypeLabel,
    required this.experienceLabel,
    required this.activityLabel,
    required this.budgetLabel,
    required this.readinessLabel,
    this.userLat,
    this.userLng,
    this.preferredTraits = const [],
  });
}

class NewFamilyQuestionnairePage extends StatefulWidget {
  const NewFamilyQuestionnairePage({super.key});

  @override
  State<NewFamilyQuestionnairePage> createState() => _NewFamilyQuestionnairePageState();
}

class _NewFamilyQuestionnairePageState extends State<NewFamilyQuestionnairePage> {
  // 🔧 수정: 미래 계획과 의지 관련 답변들 (중복 제거)
  String? adaptationPlan;
  String? unexpectedSituation;
  String? lifestyleChange;
  String? responsibilityLevel;  // 🔄 변경: 더 구체적인 이름
  String? socialConsideration;
  List<String> preparationPlans = [];

  // 🔧 수정: 옵션들 (중복 제거 및 개선)
  final List<String> adaptationOptions = [
    '1주일 정도 적응 기간 계획', 
    '1개월 정도 천천히 적응', 
    '상황에 따라 유연하게 대응'
  ];
  
  final List<String> unexpectedOptions = [
    '전문가와 상담 후 해결', 
    '가족과 상의해서 결정', 
    '최선을 다해 끝까지 돌봄'
  ];
  
  final List<String> lifestyleOptions = [
    '현재 생활 패턴 유지', 
    '반려동물 중심으로 일부 조정', 
    '생활 전반을 크게 변경할 의향'
  ];
  
  // 🔧 개선: 책임감 수준을 더 구체적으로
  final List<String> responsibilityOptions = [
    '완전한 평생 책임 각오', 
    '건강한 동안은 함께할 수 있음', 
    '상황 변화시 유연하게 대처'
  ];
  
  final List<String> socialOptions = [
    '이웃들에게 미리 양해 구할 예정', 
    '문제 생기면 그때 해결', 
    '주변 신경 쓰지 않음'
  ];
  
  final List<String> preparationOptions = [
    '응급 상황 대비책', 
    '주변 동물병원 알아보기', 
    '반려동물용품 미리 준비', 
    '가족 역할 분담 정하기', 
    '교육 프로그램 참여', 
    '보험 가입 검토'
  ];

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
                      _buildAdaptationSection(),
                      const SizedBox(height: 24),
                      _buildUnexpectedSection(),
                      const SizedBox(height: 24),
                      _buildLifestyleSection(),
                      const SizedBox(height: 24),
                      _buildResponsibilitySection(),
                      const SizedBox(height: 24),
                      _buildSocialSection(),
                      const SizedBox(height: 24),
                      _buildPreparationSection(),
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
                  '매칭 결과 보기',
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
                    '3',
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
                  '마음의 준비를 확인해요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Text(
                '3/3',
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
            '새 가족과 함께할 미래 계획을\n구체적으로 세워보세요',
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
          const Icon(Icons.lightbulb, color: AppColors.infoBlue, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '구체적인 계획을 세울수록 더 성공적인 입양이 됩니다. 현실적으로 답변해주세요.',
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

  // 적응 계획 섹션
  Widget _buildAdaptationSection() {
    return _buildQuestionSection(
      '입양 후 처음 적응 기간을 어떻게 계획하고 계신가요?',
      Icons.calendar_today,
      _SingleChoiceChips(
        options: adaptationOptions,
        value: adaptationPlan,
        onChanged: (v) => setState(() => adaptationPlan = v),
      ),
    );
  }

  // 예상치 못한 상황 섹션
  Widget _buildUnexpectedSection() {
    return _buildQuestionSection(
      '예상과 다른 문제가 생긴다면 어떻게 하실 건가요?',
      Icons.help_outline,
      _SingleChoiceChips(
        options: unexpectedOptions,
        value: unexpectedSituation,
        onChanged: (v) => setState(() => unexpectedSituation = v),
      ),
    );
  }

  // 생활 변화 의지 섹션
  Widget _buildLifestyleSection() {
    return _buildQuestionSection(
      '반려동물을 위해 생활 패턴을 얼마나 바꿀 수 있나요?',
      Icons.refresh,
      _SingleChoiceChips(
        options: lifestyleOptions,
        value: lifestyleChange,
        onChanged: (v) => setState(() => lifestyleChange = v),
      ),
    );
  }

  // 🔧 수정: 책임감 수준 섹션 (중복 제거)
  Widget _buildResponsibilitySection() {
    return _buildQuestionSection(
      '반려동물에 대한 책임감 수준은 어느 정도인가요?',
      Icons.favorite,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SingleChoiceChips(
            options: responsibilityOptions,
            value: responsibilityLevel,
            onChanged: (v) => setState(() => responsibilityLevel = v),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.infoGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.greenAccent, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '반려동물은 평균 12-15년을 함께 합니다',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 사회적 고려 섹션
  Widget _buildSocialSection() {
    return _buildQuestionSection(
      '이웃이나 주변 사람들에 대한 고려는 어떻게 하시겠어요?',
      Icons.groups,
      _SingleChoiceChips(
        options: socialOptions,
        value: socialConsideration,
        onChanged: (v) => setState(() => socialConsideration = v),
      ),
    );
  }

  // 준비 계획 섹션
  Widget _buildPreparationSection() {
    return _buildQuestionSection(
      '입양 전에 어떤 준비를 하실 계획인가요? (복수선택)',
      Icons.checklist,
      _MultiChoiceChips(
        options: preparationOptions,
        values: preparationPlans,
        onChanged: (v) => setState(() => preparationPlans = v),
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

  // 🔧 수정: 폼 유효성 검사
  bool _isFormValid() {
    return adaptationPlan != null &&
           unexpectedSituation != null &&
           lifestyleChange != null &&
           responsibilityLevel != null &&  // 변경된 변수명
           socialConsideration != null;
  }

  // 🔧 수정: 매칭 결과로 이동 (데이터 전달)
  void _onNextPressed() {
    // 이전 단계들의 데이터를 가져와야 하지만, 현재는 mock 데이터 사용
    final surveyAnswers = SurveyAnswers(
      // 1단계 데이터 (mock)
      housingLabel: '아파트',
      spaceLabel: '소형(20평 이하)',
      hasKids: true,
      workTypeLabel: '출근족',
      
      // 2단계 데이터 (mock)
      experienceLabel: '초보자',
      activityLabel: '낮음',
      budgetLabel: '중간',
      
      // 3단계 데이터 (현재 입력값)
      readinessLabel: responsibilityLevel ?? '보통',
      userLat: 37.4979,  // 강남역 근처 (예시)
      userLng: 127.0276,
      preferredTraits: preparationPlans,
    );

    Navigator.pushNamed(
      context, 
      '/family/results',
      arguments: surveyAnswers,
    );
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
            '3/3',
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