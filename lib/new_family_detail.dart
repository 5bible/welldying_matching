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
}

class NewFamilyDetailPage extends StatefulWidget {
  const NewFamilyDetailPage({super.key});

  @override
  State<NewFamilyDetailPage> createState() => _NewFamilyDetailPageState();
}

class _NewFamilyDetailPageState extends State<NewFamilyDetailPage> {
  bool _isFavorite = false;
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  // Mock 데이터 - 실제로는 arguments로 받아올 것
  final String petName = '바둑이';
  final String petBreed = '믹스견';
  final int petAge = 3;
  final String petGender = '수컷(중성화 완료)';
  final String petWeight = '15kg';
  final int matchPercentage = 94;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 상단 이미지와 헤더
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: const Text(
              '매칭 결과 상세',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() => _isFavorite = !_isFavorite);
                },
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.black,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageGallery(),
            ),
          ),
          
          // 컨텐츠 영역
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildPetBasicInfo(),
                const SizedBox(height: 16),
                _buildShelterInfo(),
                const SizedBox(height: 16),
                _buildPersonalitySection(),
                const SizedBox(height: 16),
                _buildHealthSection(),
                const SizedBox(height: 16),
                _buildStorySection(),
                const SizedBox(height: 16),
                _buildCareRequirements(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildImageGallery() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: const BoxDecoration(
            color: Color(0xFFFFB347), // 오렌지 배경
          ),
          child: const Center(
            child: Text(
              '🐕',
              style: TextStyle(fontSize: 120),
            ),
          ),
        ),
        
        // 매칭도 뱃지
        Positioned(
          top: 100,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.brown,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$matchPercentage% 매칭',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        
        // 이미지 인디케이터
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: index == _currentImageIndex 
                    ? Colors.white 
                    : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            )),
          ),
        ),
      ],
    );
  }

  Widget _buildPetBasicInfo() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            petName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('🐕', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                petBreed,
                style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
              const SizedBox(width: 16),
              const Text('😊', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                '${petAge}세',
                style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
              const SizedBox(width: 16),
              const Text('⚖️', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                '중형($petWeight)',
                style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('🚹', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                petGender,
                style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShelterInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                '서울 강남 동물보호소',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '서울시 강남구 테헤란로 123 · 2.1km 거리',
            style: TextStyle(fontSize: 14, color: AppColors.textGrey),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 16),
              SizedBox(width: 4),
              Text(
                '4.8점 (128명 평가)',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              SizedBox(width: 16),
              Icon(Icons.phone, color: Colors.red, size: 16),
              SizedBox(width: 4),
              Text(
                '02-1234-5678',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalitySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('🌟', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                '성격 특성',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPersonalityGrid(),
        ],
      ),
    );
  }

  Widget _buildPersonalityGrid() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildPersonalityItem('😊', '활발함', '매우 높음'),
              const SizedBox(height: 12),
              _buildPersonalityItem('🔇', '조용함', '높음'),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              _buildPersonalityItem('⚽', '활동성', '보통'),
              const SizedBox(height: 12),
              _buildPersonalityItem('✅', '훈련 용이성', '높음'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalityItem(String emoji, String trait, String level) {
    Color levelColor;
    switch (level) {
      case '매우 높음':
        levelColor = AppColors.greenAccent;
        break;
      case '높음':
        levelColor = AppColors.greenAccent;
        break;
      case '보통':
        levelColor = Colors.blue;
        break;
      default:
        levelColor = AppColors.textGrey;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            trait,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: levelColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              level,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('🏥', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                '건강 정보',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHealthGrid(),
        ],
      ),
    );
  }

  Widget _buildHealthGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildHealthItem('💉', '예방접종', '완료', AppColors.greenAccent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildHealthItem('✂️', '중성화', '완료', AppColors.greenAccent),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildHealthItem('❤️', '건강상태', '건강', Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildHealthItem('🐕', '칩야', '해당됨', AppColors.brown),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHealthItem(String emoji, String category, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('📖', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                '바둑이의 이야기',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.infoGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '"바둑이는 길에서 발견되어 보호소에 온 지 3개월이 되었어요. '
              '처음에는 조금 무서워했지만 이제는 사람들을 정말 좋아하고 '
              '다른 강아지들과도 잘 어울려요. 산책을 좋아하고 옆 번지기 '
              '게임을 특히 좋아합니다. 새로운 가족과 함께 행복한 시간을 보내고 '
              '싶어해요."',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareRequirements() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('📝', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                '입양 조건',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCareRequirementItem('산책', '하루 2회 (아침, 저녁) 각 30분씩', true),
          _buildCareRequirementItem('사회화', '다른 반려동물과 함께 키워도 좋아요', true),
          _buildCareRequirementItem('환경', '아파트/주택 모두 가능 (소음 적음)', true),
          _buildCareRequirementItem('주의사항', '혼자 오래있으면 외로워해요 (8시간 이내)', true),
        ],
      ),
    );
  }

  Widget _buildCareRequirementItem(String title, String description, bool isGood) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.greenAccent,
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 12,
            ),
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
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
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
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showContactDialog(),
                icon: const Icon(Icons.phone, color: Colors.red),
                label: const Text(
                  '전화 상담',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showAdoptionDialog(),
                icon: const Icon(Icons.diamond, color: Colors.white),
                label: const Text(
                  '입양 신청',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('전화 상담'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('서울 강남 동물보호소'),
            SizedBox(height: 8),
            Text('📞 02-1234-5678'),
            SizedBox(height: 8),
            Text('🕘 운영시간: 매일 09:00-18:00'),
            SizedBox(height: 8),
            Text('바둑이에 대해 더 자세히 문의하실 수 있습니다.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showToast('전화 연결 중...');
            },
            child: const Text('전화하기'),
          ),
        ],
      ),
    );
  }

  void _showAdoptionDialog() {
    Navigator.pushNamed(context, '/family/application');
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