import 'package:flutter/material.dart';

class FuneralMatchingScreen extends StatefulWidget {
  const FuneralMatchingScreen({super.key});

  @override
  State<FuneralMatchingScreen> createState() => _FuneralMatchingScreenState();
}

class _FuneralMatchingScreenState extends State<FuneralMatchingScreen> {
  // 상태 변수들
  String selectedLocation = '서울 강남구';
  String selectedBudget = '50-100만원';
  String selectedSchedule = '3일 이내';
  String selectedPetSize = '소형';
  bool showAIRecommendations = true;
  bool isAIChatVisible = false;

  // 옵션들
  final List<String> locationOptions = ['서울 강남구', '서울 송파구', '서울 서초구', '부산 해운대구'];
  final List<String> budgetOptions = ['50만원 이하', '50-100만원', '100-200만원', '200만원 이상'];
  final List<String> scheduleOptions = ['긴급', '3일 이내', '일주일 이내'];
  final List<String> petSizeOptions = ['소형', '중형', '대형'];

  // AI 추천 데이터 (실제로는 서버에서 가져옴)
  final Map<String, String> aiRecommendations = {
    'location': '서울 강남구',
    'budget': '50-100만원',
    'schedule': '3일 이내',
    'petSize': '소형',
    'reason': '매생이(미니어처푸들, 8살)의 프로필을 분석한 결과입니다',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),
            if (showAIRecommendations) _buildAIRecommendationSection(),
            if (showAIRecommendations) const SizedBox(height: 20),
            _buildEmotionalSupportSection(),
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
            const SizedBox(height: 20),
            if (isAIChatVisible) _buildAIChatSection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE6DC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.pets,
                  color: Color(0xFF8B5A3C),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '가까운 곳에서 편안하게\n믿을 수 있는 시설을 찾아드려요',
                  style: TextStyle(
                    fontSize: 16,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5A3C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF8B5A3C).withOpacity(0.2)),
            ),
            child: const Text(
              '작은 상실 • 매생이를 위한 마지막 배웅 준비',
              style: TextStyle(
                color: Color(0xFF8B5A3C),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F4FD), Color(0xFFF0F8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.smart_toy,
                  color: Colors.blue,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'AI 맞춤 추천',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => setState(() => showAIRecommendations = false),
                icon: const Icon(Icons.close, size: 18, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            aiRecommendations['reason']!,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildAIRecommendationChip('위치: ${aiRecommendations['location']}', true),
              _buildAIRecommendationChip('예산: ${aiRecommendations['budget']}', true),
              _buildAIRecommendationChip('일정: ${aiRecommendations['schedule']}', true),
              _buildAIRecommendationChip('크기: ${aiRecommendations['petSize']}', true),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton.icon(
                onPressed: _showAIExplanation,
                icon: const Icon(Icons.help_outline, size: 16),
                label: const Text('왜 이렇게 추천했나요?'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _applyAIRecommendations,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('추천 적용하기'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationChip(String label, bool isRecommended) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isRecommended ? Colors.blue.shade600 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isRecommended) 
            const Icon(Icons.check, size: 14, color: Colors.white),
          if (isRecommended) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isRecommended ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionalSupportSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🤍 힘든 시기에 함께하는 AI 가이드',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() => isAIChatVisible = !isAIChatVisible),
                child: Text(
                  isAIChatVisible ? '접기' : '더보기',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '매생이와의 소중한 시간을 기억하며, 가장 적합한 시설을 찾아드릴게요. 궁금한 점이 있으시면 언제든 물어보세요.',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return _buildSection(
      '📍 현재 위치',
      '서울 강남구',
      [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '✨ AI 추천',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '단골병원에서 3km · 평균 이동시간 15분',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {}, // 위치 변경 화면으로 이동
          icon: const Icon(Icons.location_on, size: 16),
          label: const Text('위치 변경'),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF8B5A3C),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetSection() {
    return _buildSection(
      '💰 예산 범위',
      null,
      [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: budgetOptions.map((budget) {
            final isSelected = selectedBudget == budget;
            final isAIRecommended = budget == aiRecommendations['budget'];
            
            return Stack(
              children: [
                ChoiceChip(
                  label: Text(budget),
                  selected: isSelected,
                  selectedColor: const Color(0xFF8B5A3C),
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: isSelected 
                          ? const Color(0xFF8B5A3C) 
                          : Colors.grey.shade300,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  onSelected: (v) => setState(() => selectedBudget = budget),
                ),
                if (isAIRecommended && !isSelected)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildScheduleSection() {
    return _buildSection(
      '📅 희망 일정',
      null,
      [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: scheduleOptions.map((schedule) {
            final isSelected = selectedSchedule == schedule;
            return ChoiceChip(
              label: Text(schedule),
              selected: isSelected,
              selectedColor: const Color(0xFF8B5A3C),
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  color: isSelected 
                      ? const Color(0xFF8B5A3C) 
                      : Colors.grey.shade300,
                ),
              ),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              onSelected: (v) => setState(() => selectedSchedule = schedule),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPetSizeSection() {
    return _buildSection(
      '🐾 반려동물 크기',
      null,
      [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: petSizeOptions.map((size) {
            final isSelected = selectedPetSize == size;
            final isAIRecommended = size == aiRecommendations['petSize'];
            
            return Stack(
              children: [
                ChoiceChip(
                  label: Text(size),
                  selected: isSelected,
                  selectedColor: const Color(0xFF8B5A3C),
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: isSelected 
                          ? const Color(0xFF8B5A3C) 
                          : Colors.grey.shade300,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  onSelected: (v) => setState(() => selectedPetSize = size),
                ),
                if (isAIRecommended && !isSelected)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String? subtitle, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFindButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // 다음 화면으로 이동
          Navigator.pushNamed(context, '/location_setting');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5A3C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          '맞춤 시설 찾기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAIChatSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💬 AI 상담사와 대화',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI 상담사',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '안녕하세요. 매생이를 위한 장례 준비를 도와드리겠습니다. 어떤 부분이 가장 걱정되시나요?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '메시지를 입력하세요...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF8B5A3C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAIExplanation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI 추천 이유',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildExplanationItem(
              Icons.location_on,
              '위치 추천',
              '단골 병원(강남 동물병원)에서 3km 거리로 가장 가까운 시설들이 있습니다.',
            ),
            _buildExplanationItem(
              Icons.monetization_on,
              '예산 추천',
              '미니어처 푸들 크기의 평균 장례 비용이 50-100만원대입니다.',
            ),
            _buildExplanationItem(
              Icons.schedule,
              '일정 추천',
              '8살 고령견의 경우 3일 이내 진행을 권장합니다.',
            ),
            _buildExplanationItem(
              Icons.pets,
              '크기 분류',
              '매생이(3kg)는 소형견에 해당되며, 소형견 전용 시설이 더 적합합니다.',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5A3C),
                ),
                child: const Text('확인', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanationItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
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

  void _applyAIRecommendations() {
    setState(() {
      selectedLocation = aiRecommendations['location']!;
      selectedBudget = aiRecommendations['budget']!;
      selectedSchedule = aiRecommendations['schedule']!;
      selectedPetSize = aiRecommendations['petSize']!;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI 추천이 적용되었습니다'),
        backgroundColor: Colors.green,
      ),
    );
  }
}