import 'package:flutter/material.dart';

class FuneralMatchingScreen extends StatefulWidget {
  const FuneralMatchingScreen({super.key});

  @override
  State<FuneralMatchingScreen> createState() => _FuneralMatchingScreenState();
}

class _FuneralMatchingScreenState extends State<FuneralMatchingScreen> {
  // 피그마와 동일한 초기값으로 설정
  String selectedLocation = '서울 강남구';
  String selectedBudget = '50만원 이하';
  String selectedSchedule = '3일 이내';
  String selectedService = '대형';

  // 옵션
  final List<String> budgetOptions = ['50만원 이하', '50-100만원', '100-200만원', '200만원 이상'];
  final List<String> scheduleOptions = ['긴급', '3일 이내', '일주일 이내'];
  final List<String> serviceOptions = ['소형', '중형', '대형'];

  // 피그마 디자인과 동일한 색상
  static const kPrimary = Color(0xFF8B5A3C);
  static const kAccent  = Color(0xFFD2691E);
  static const kBg      = Color(0xFFF5F5F5);
  static const kHeader  = Color(0xFFEDE6DC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          '장례 준비',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 30),
            _buildAiRecommendationSection(),
            const SizedBox(height: 30),
            _buildLocationSection(),
            const SizedBox(height: 30),
            _buildBudgetSection(),
            const SizedBox(height: 30),
            _buildScheduleSection(),
            const SizedBox(height: 30),
            _buildPetSizeSection(),
            const SizedBox(height: 40),
            _buildFindButton(),
          ],
        ),
      ),
    );
  }

  // 피그마와 동일한 간결한 헤더
  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kHeader,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.home, color: kAccent, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  '가까운 곳에서 편안하게\n믿을 수 있는 시설을 찾아드려요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDEB887),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '매생이를 위한 마지막 배웅 준비',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 피그마와 동일한 AI 추천 섹션 (크기 축소)
  Widget _buildAiRecommendationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF90CAF9), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.smart_toy, color: Color(0xFF1976D2), size: 18),
              SizedBox(width: 6),
              Text(
                'AI 맞춤 추천',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '매생이(미니어처푸들, 8살)의 프로필을 분석한 결과입니다.',
            style: TextStyle(
              color: Color(0xFF1976D2),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildSmallChipTag('위치 : $selectedLocation'),
              _buildSmallChipTag('예산 : $selectedBudget'),
              _buildSmallChipTag('일정 : $selectedSchedule'),
              _buildSmallChipTag('크기 : $selectedService'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallChipTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E88E5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }

  // 피그마와 동일한 현재 위치 섹션 (더 간결하게)
  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.place, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Text(
              '현재 위치',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF7E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'AI추천',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '단골병원에서 3km / 평균 이동시간 15분',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _onLocationChange,
                child: const Row(
                  children: [
                    Icon(Icons.my_location, color: Colors.red, size: 18),
                    SizedBox(width: 6),
                    Text(
                      '위치 변경',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 예산 섹션
  Widget _buildBudgetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.attach_money, color: kAccent, size: 20),
            SizedBox(width: 8),
            Text(
              '예산 범위',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: budgetOptions.map((budget) {
            final selected = selectedBudget == budget;
            return ChoiceChip(
              label: Text(budget),
              selected: selected,
              selectedColor: kPrimary,
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(color: selected ? kPrimary : Colors.grey.shade300),
              ),
              labelStyle: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              onSelected: (_) => setState(() => selectedBudget = budget),
            );
          }).toList(),
        ),
      ],
    );
  }

  // 일정 섹션
  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.calendar_today, color: kAccent, size: 20),
            SizedBox(width: 8),
            Text(
              '희망 일정',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: scheduleOptions.map((schedule) {
            final selected = selectedSchedule == schedule;
            return ChoiceChip(
              label: Text(schedule),
              selected: selected,
              selectedColor: kPrimary,
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(color: selected ? kPrimary : Colors.grey.shade300),
              ),
              labelStyle: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              onSelected: (_) => setState(() => selectedSchedule = schedule),
            );
          }).toList(),
        ),
      ],
    );
  }

  // 반려동물 크기 섹션
  Widget _buildPetSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.pets, color: kAccent, size: 20),
            SizedBox(width: 8),
            Text(
              '반려동물 크기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: serviceOptions.map((service) {
            final selected = selectedService == service;
            return ChoiceChip(
              label: Text(service),
              selected: selected,
              selectedColor: kPrimary,
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(color: selected ? kPrimary : Colors.grey.shade300),
              ),
              labelStyle: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              onSelected: (_) => setState(() => selectedService = service),
            );
          }).toList(),
        ),
      ],
    );
  }

  // 찾기 버튼
  Widget _buildFindButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _onFindStores,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: const Text(
          '맞춤 시설 찾기',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _onLocationChange() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('위치 변경'),
        content: const Text('위치 선택 화면으로 이동합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _onFindStores() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('맞춤 시설을 찾고 있습니다...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('검색이 완료되었습니다!'),
          backgroundColor: kPrimary,
        ),
      );
    });
  }
}