import 'package:flutter/material.dart';

/// 색상 토큰
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
  static const textGrey = Color(0xFF666666);
  static const warningYellow = Color(0xFFFFC107);
  static const warningYellowLight = Color(0xFFFFF8E1);
}

class NewFamilyApplicationPage extends StatefulWidget {
  const NewFamilyApplicationPage({super.key});

  @override
  State<NewFamilyApplicationPage> createState() => _NewFamilyApplicationPageState();
}

class _NewFamilyApplicationPageState extends State<NewFamilyApplicationPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 3;

  // 입양 동기 및 추가 질문 (실제로 새로 입력받을 항목들)
  final _motivationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _preparationController = TextEditingController();
  bool _agreeToTerms = false;
  bool _agreeToVisit = false;

  // Mock 데이터 (실제로는 이전 화면들과 회원정보에서 가져올 것)
  final String petName = '바둑이';
  
  // 회원 정보 (Mock)
  final Map<String, String> userInfo = {
    'name': '김춘식',
    'phone': '010-1111-2222',
    'email': 'kimcs@email.com',
    'address': '서울시 강남구 테헤란로 123',
    'job': '회사원',
  };

  // 설문조사 결과 (Mock)
  final Map<String, String> surveyAnswers = {
    'housing': '아파트',
    'space': '소형 (20평 이하)',
    'hasKids': '있음',
    'workType': '출근족',
    'experience': '초보자',
    'activity': '낮음',
    'budget': '중간',
    'preferredTraits': '온순함, 조용함, 아이친화적',
  };

  @override
  void dispose() {
    _motivationController.dispose();
    _experienceController.dispose();
    _preparationController.dispose();
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
            _buildProgressIndicator(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPersonalInfoConfirmStep(),
                  _buildSurveyConfirmStep(),
                  _buildMotivationStep(),
                ],
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: List.generate(_totalSteps, (index) {
              final isActive = index <= _currentStep;
              
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.brown : AppColors.border,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (index < _totalSteps - 1) const SizedBox(width: 8),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            '${_currentStep + 1}단계 / $_totalSteps단계',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  // 1단계: 회원 정보 확인
  Widget _buildPersonalInfoConfirmStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            '회원 정보를 확인해주세요',
            '입양 신청서에 사용될 정보입니다',
            Icons.person_outline,
          ),
          const SizedBox(height: 24),
          _buildInfoCard('기본 정보', [
            _buildInfoRow('이름', userInfo['name']!, Icons.person),
            _buildInfoRow('연락처', userInfo['phone']!, Icons.phone),
            _buildInfoRow('이메일', userInfo['email']!, Icons.email),
            _buildInfoRow('주소', userInfo['address']!, Icons.home),
            _buildInfoRow('직업', userInfo['job']!, Icons.work),
          ]),
          const SizedBox(height: 16),
          _buildEditButton('회원정보 수정하기'),
          const SizedBox(height: 24),
          _buildInfoNotice(
            '개인정보 활용 동의',
            '입양 신청 처리를 위해 회원정보가 보호소에 전달됩니다.',
          ),
        ],
      ),
    );
  }

  // 2단계: 설문조사 결과 확인
  Widget _buildSurveyConfirmStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            '매칭 정보를 확인해주세요',
            '$petName 선택 시 참고된 설문조사 결과입니다',
            Icons.quiz_outlined,
          ),
          const SizedBox(height: 24),
          _buildInfoCard('생활 환경', [
            _buildInfoRow('거주 형태', surveyAnswers['housing']!, Icons.home_outlined),
            _buildInfoRow('생활 공간', surveyAnswers['space']!, Icons.square_foot),
            _buildInfoRow('가족 구성', surveyAnswers['hasKids'] == '있음' ? '자녀 있음' : '자녀 없음', Icons.family_restroom),
            _buildInfoRow('근무 형태', surveyAnswers['workType']!, Icons.work_outline),
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('반려동물 경험', [
            _buildInfoRow('경험 수준', surveyAnswers['experience']!, Icons.psychology),
            _buildInfoRow('활동량', surveyAnswers['activity']!, Icons.directions_run),
            _buildInfoRow('예산', surveyAnswers['budget']!, Icons.account_balance_wallet),
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('선호 성향', [
            _buildTraitChips(surveyAnswers['preferredTraits']!.split(', ')),
          ]),
          const SizedBox(height: 16),
          _buildEditButton('매칭 설문 다시하기'),
        ],
      ),
    );
  }

  // 3단계: 입양 동기 및 추가 질문
  Widget _buildMotivationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            '입양에 대해 알려주세요',
            '보호소에서 신중한 입양을 위해 추가로 확인하는 내용입니다',
            Icons.favorite_outline,
          ),
          const SizedBox(height: 24),
          _buildQuestionCard(
            '1. 반려동물을 입양하려는 이유는 무엇인가요?',
            _motivationController,
            '예: 가족에게 즐거움을 주고 싶어서, 외로움을 달래고 싶어서 등',
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            '2. 반려동물을 키워본 경험이 있다면 자세히 말해주세요.',
            _experienceController,
            '예: 어떤 동물을, 얼마나 오래 키웠는지, 어떤 어려움이 있었는지 등\n(경험이 없다면 "없음"이라고 적어주세요)',
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            '3. 입양 후 어떤 준비를 하고 계신가요?',
            _preparationController,
            '예: 용품 구매, 병원 알아보기, 가족 역할 분담 등',
          ),
          const SizedBox(height: 24),
          _buildImportantNotice(),
          const SizedBox(height: 24),
          _buildCheckboxTile(
            '입양 조건에 동의합니다',
            '정기 건강검진, 평생 책임, 중성화 수술 등',
            _agreeToTerms,
            (value) => setState(() => _agreeToTerms = value!),
          ),
          const SizedBox(height: 12),
          _buildCheckboxTile(
            '보호소 방문 상담에 동의합니다',
            '입양 전 직접 만나보는 시간을 가집니다',
            _agreeToVisit,
            (value) => setState(() => _agreeToVisit = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildStepHeader(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.header,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.brown,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 18),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraitChips(List<String> traits) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: traits.map((trait) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.brown,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          trait,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildEditButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          _showToast('해당 화면으로 이동합니다');
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: const BorderSide(color: AppColors.brown),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.brown,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoNotice(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoBlueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.infoBlueBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.infoBlue, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question, TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.textGrey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.brown),
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String title, String subtitle, bool value, ValueChanged<bool?> onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.brown,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warningYellowLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warningYellow.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.warningYellow, size: 20),
              const SizedBox(width: 8),
              const Text(
                '입양 전 꼭 알아두세요',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '• 반려동물은 평균 12-15년을 함께합니다\n'
            '• 매월 최소 10-30만원의 관리비가 필요합니다\n'
            '• 질병, 사고 등 응급상황에 대비해야 합니다\n'
            '• 충분한 시간과 관심을 쏟아야 합니다',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '이전',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: _currentStep > 0 ? 1 : 1,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _currentStep == _totalSteps - 1 ? '신청 완료' : '확인 완료',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitApplication();
    }
  }

  void _submitApplication() {
    // 마지막 단계에서 필수 입력 검증
    if (_motivationController.text.trim().isEmpty ||
        _experienceController.text.trim().isEmpty ||
        _preparationController.text.trim().isEmpty) {
      _showToast('모든 질문에 답변해주세요');
      return;
    }
    
    if (!_agreeToTerms || !_agreeToVisit) {
      _showToast('필수 동의 항목을 확인해주세요');
      return;
    }

    // 신청 완료 다이얼로그 표시
    _showApplicationCompleteDialog();
  }

  void _showApplicationCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 완료 아이콘
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.greenAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              
              // 완료 메시지
              const Text(
                '신청이 완료되었습니다!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              Text(
                '$petName와의 만남을 위한\n첫 걸음을 내디뎠어요',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textGrey,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // 안내사항
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.infoBlueLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.infoBlueBorder),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: AppColors.infoBlue, size: 18),
                        SizedBox(width: 8),
                        Text(
                          '다음 단계 안내',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '• 2-3일 내 보호소에서 연락드립니다\n'
                      '• 방문 일정을 조율하게 됩니다\n'
                      '• 직접 만나보는 시간을 가집니다\n'
                      '• 최종 입양 절차를 진행합니다',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/family/intro', 
                    (route) => false, // 모든 이전 화면 제거하고 처음 화면으로
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.brown,
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
            '입양 신청',
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