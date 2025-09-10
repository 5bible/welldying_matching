import 'package:flutter/material.dart';

/// 4번 파일: 시설 상세 화면 (오버플로우 수정 버전)

class AppColors {
  static const brown = Color(0xFF8C6239);
  static const lightBrown = Color(0xFFF0E6D6);
  static const background = Color(0xFFF5F5F5);
  static const border = Color(0xFFE1D7C7);
  static const accent = Color(0xFFD2691E);
  static const textGrey = Color(0xFF666666);
  static const cardBg = Color(0xFFEDE6DC);
}

class FmDetailPage extends StatefulWidget {
  const FmDetailPage({super.key});

  @override
  State<FmDetailPage> createState() => _FmDetailPageState();
}

class _FmDetailPageState extends State<FmDetailPage> {
  late String facilityName;
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  
  // 기본 서비스 (기본으로 포함되는 서비스)
  bool _basicCremation = true; // 기본 화장 서비스 (기본 선택)
  
  // 선택 가능한 서비스들
  bool _service49 = false;
  bool _premiumCoffin = false;
  bool _memorialFlower = false;
  
  // 추가 서비스들
  bool _additionalMemorial = false; // 개별 추모실

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    facilityName = args as String? ?? '평안 동물병원 장례식장';
  }

  int get totalPrice {
    int total = 500000; // 기본 화장 서비스 50만원 (필수)
    if (_additionalMemorial) total += 300000; // 개별 추모실 30만원
    if (_service49) total += 500000; // 49재 서비스 50만원
    if (_premiumCoffin) total += 500000; // 프리미엄 유골함 50만원
    if (_memorialFlower) total += 100000; // 추모 꽃바구니 10만원
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          '시설 상세',
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
              _showToast(_isFavorite ? '관심 목록에 추가했습니다' : '관심 목록에서 제거했습니다');
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.black87,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            const SizedBox(height: 20),
            _buildFacilityInfo(),
            const SizedBox(height: 20),
            _buildPetMatchingCard(),
            const SizedBox(height: 20),
            _buildBasicServices(),
            const SizedBox(height: 20),
            _buildOptionalServices(),
            const SizedBox(height: 20),
            _buildReviews(),
            const SizedBox(height: 20),
            _buildSpecialOffer(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 250,
      color: AppColors.cardBg,
      child: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo_camera, size: 48, color: AppColors.accent),
                SizedBox(height: 8),
                Text(
                  '시설 사진 갤러리',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentImageIndex 
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.business, color: AppColors.accent, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  facilityName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() => _isFavorite = !_isFavorite);
                  _showToast(_isFavorite ? '관심 목록에 추가했습니다' : '관심 목록에서 제거했습니다');
                },
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Row(
                children: List.generate(5, (i) => const Icon(Icons.star, size: 16, color: Colors.orange)),
              ),
              const SizedBox(width: 8),
              const Text('4.8 · 124개 리뷰 · 130회 이용', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildBadge('당일예약가능', const Color(0xFFE8F5E9)),
              _buildBadge('24시간 운영', const Color(0xFFE3F2FD)),
              _buildBadge('픽업 서비스', const Color(0xFFFFF3E0)),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.place, '서울특별시 강남구 테헤란로 123길 45 · 1.2km'),
          _buildInfoRow(Icons.phone, '02-1234-1234'),
          _buildInfoRow(Icons.access_time, '24시간 운영 (연중무휴)'),
          _buildInfoRow(Icons.local_parking, '무료 주차 20대 (대형차 가능)'),
          _buildInfoRow(Icons.local_shipping, '강남구 전지역 픽업 서비스'),
        ],
      ),
    );
  }

  Widget _buildPetMatchingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.pets, color: AppColors.accent),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              '매생이 (미니어처푸들, 3kg) 맞춤견적',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.brown,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '서비스 선택 & 가격 계산',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicServices() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '기본 서비스',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            '기본 화장 서비스',
            '개별 화장 + 기본 추모 용품 포함',
            '50만원',
            '필수',
            _basicCremation,
            null, // 필수 서비스라 변경 불가
          ),
          _buildServiceItem(
            '개별 추모실',
            '가족만의 공간에서 마지막 인사',
            '+30만원',
            '선택',
            _additionalMemorial,
            (value) => setState(() => _additionalMemorial = value),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionalServices() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '추가 선택 서비스',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            '49재 서비스',
            '49일 추도 의식 및 관련 용품',
            '+50만원',
            '선택',
            _service49,
            (value) => setState(() => _service49 = value),
          ),
          _buildServiceItem(
            '프리미엄 유골함',
            '고급 원목 유골함으로 업그레이드',
            '+50만원',
            '선택',
            _premiumCoffin,
            (value) => setState(() => _premiumCoffin = value),
          ),
          _buildServiceItem(
            '추모 꽃바구니',
            '제철 꽃으로 구성된 추모 화환',
            '+10만원',
            '선택',
            _memorialFlower,
            (value) => setState(() => _memorialFlower = value),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String subtitle, String price, String badge, bool value, ValueChanged<bool>? onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: badge == '필수' ? Colors.red.shade100 : AppColors.lightBrown,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: badge == '필수' ? Colors.red : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brown,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.brown,
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '이용 후기',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Column(
                children: [
                  Text(
                    '4.8',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: AppColors.brown),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('124개 리뷰', style: TextStyle(color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar('5점', 99, Colors.orange),
                    _buildRatingBar('4점', 19, Colors.grey[300]!),
                    _buildRatingBar('3점', 4, Colors.grey[300]!),
                    _buildRatingBar('2점', 1, Colors.grey[300]!),
                    _buildRatingBar('1점', 1, Colors.grey[300]!),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (i) => const Icon(Icons.star, size: 16, color: Colors.orange)),
                    ),
                    const SizedBox(width: 8),
                    const Text('충청도 프로도', style: TextStyle(fontWeight: FontWeight.w600)),
                    const Spacer(),
                    const Text('2주 전', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '마지막까지 정성스럽게 배웅해주셔서 감사합니다. 시설도 깨끗하고 직원분들이 친절하게 안내해주셔서 좋았어요. 힘든 서비스도 신속하고 정중하게 처리해주셔서 감사합니다.',
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                widthFactor: count / 100,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('$count', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSpecialOffer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text('🎁', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '총 예상 비용',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '타 업체 대비 15% 저렴',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${(totalPrice / 10000).toInt()}만원',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
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
                onPressed: () => _showPhoneConsultDialog(),
                icon: const Icon(Icons.phone, color: Colors.red),
                label: const Text(
                  '전화 상담',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/funeral/reservation');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  '예약하기',
                  style: TextStyle(
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

  void _showPhoneConsultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.phone, color: AppColors.accent),
            SizedBox(width: 8),
            Text('전화 상담'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '평안 동물병원 장례식장',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('📞 02-1234-1234'),
            SizedBox(height: 4),
            Text('🕐 24시간 운영 (연중무휴)'),
            SizedBox(height: 12),
            Text(
              '전문 상담사가 친절하게 안내해드립니다.',
              style: TextStyle(color: AppColors.textGrey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _showToast('전화 앱으로 연결됩니다.');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
            ),
            icon: const Icon(Icons.phone, color: Colors.white),
            label: const Text(
              '전화걸기',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.brown,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}