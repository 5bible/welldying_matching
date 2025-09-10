import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// =============================================================
/// 색상 토큰
/// =============================================================
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

/// =============================================================
/// 간단한 펫 카드용 모델
/// =============================================================
class PetProfile {
  final int id;
  final String name;
  final String breed;
  final String age;
  final String gender;
  final String size;
  final int matchPercentage;
  final String location;
  final String distance;
  final List<String> matchingPoints;
  final bool availableToday;
  final List<String> tags;

  PetProfile({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.size,
    required this.matchPercentage,
    required this.location,
    required this.distance,
    required this.matchingPoints,
    required this.availableToday,
    required this.tags,
  });
}

/// =============================================================
/// 매칭 결과 리스트 화면 (단순한 버전)
/// =============================================================
class NewFamilyResultsPage extends StatefulWidget {
  const NewFamilyResultsPage({super.key});

  @override
  State<NewFamilyResultsPage> createState() => _NewFamilyResultsPageState();
}

class _NewFamilyResultsPageState extends State<NewFamilyResultsPage> {
  // UI 상태
  String _selectedFilter = '전체';
  final List<String> filterOptions = ['전체', '높은 매칭도', '당일 만남 가능', '특별 케어'];
  final Set<int> _favoriteIds = {};

  // Mock 데이터 (실제로는 이전 화면에서 전달받음)
  final List<PetProfile> _displayPets = [
    PetProfile(
      id: 1,
      name: '바둑이',
      breed: '믹스견',
      age: '3세',
      gender: '중성화 완료',
      size: '중형견',
      matchPercentage: 94,
      location: '서울 강남 동물보호소',
      distance: '2.1km',
      matchingPoints: ['조용하고 온순한 성격', '소형 공간 적응 우수', '사람을 좋아함', '초보자도 키우기 쉬움'],
      availableToday: true,
      tags: ['높은 매칭도', '당일 만남 가능'],
    ),
    PetProfile(
      id: 2,
      name: '나비',
      breed: '코숏',
      age: '2세',
      gender: '중성화 완료',
      size: '소형묘',
      matchPercentage: 89,
      location: '서울 서초 보호소',
      distance: '3.2km',
      matchingPoints: ['실내 생활 컨력 적응', '예고가 많고 친화적', '관리가 쉬움', '조용한 성격'],
      availableToday: false,
      tags: ['높은 매칭도'],
    ),
    PetProfile(
      id: 3,
      name: '모카',
      breed: '퍼그',
      age: '7세',
      gender: '중성화 완료',
      size: '중형견',
      matchPercentage: 85,
      location: '서울 송파구 유기견보호소',
      distance: '4.5km',
      matchingPoints: ['온순함', '충성스러움', '어른스러움'],
      availableToday: true,
      tags: ['특별 케어', '당일 만남 가능'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _HeaderBar(onBack: () => Navigator.maybePop(context)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAIAnalysisCard(),
                    const SizedBox(height: 24),
                    _buildSectionTitle(),
                    const SizedBox(height: 16),
                    _buildPetList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AI 분석 결과 카드
  Widget _buildAIAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoBlueLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.infoBlueBorder),
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
                  color: AppColors.infoBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'AI 분석 결과',
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
            '소형 공간과 초보자에게 적합한 온순하고 친화적인 친구들을 추천드려요. 적응이 빠르고 사람을 좋아하는 특성을 가진 아이들입니다.',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 16),
          // 태그들
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('🏠 소형 공간 적합', AppColors.accent),
              _buildTag('😊 초보자 친화적', AppColors.greenAccent),
              _buildTag('🤗 온순한 성격', AppColors.infoBlue),
              _buildTag('⚡ 빠른 적응력', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 섹션 제목
  Widget _buildSectionTitle() {
    return Row(
      children: [
        const Icon(Icons.pets, color: AppColors.accent, size: 24),
        const SizedBox(width: 8),
        const Text(
          '총 3마리 발견',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // 펫 리스트 (간단한 카드 형태)
  Widget _buildPetList() {
    final filteredPets = _getFilteredPets();
    
    return Column(
      children: filteredPets.map((pet) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _buildSimplePetCard(pet),
      )).toList(),
    );
  }

  List<PetProfile> _getFilteredPets() {
    switch (_selectedFilter) {
      case '높은 매칭도':
        return _displayPets.where((pet) => pet.matchPercentage >= 90).toList();
      case '당일 만남 가능':
        return _displayPets.where((pet) => pet.availableToday).toList();
      case '특별 케어':
        return _displayPets.where((pet) => pet.tags.contains('특별 케어')).toList();
      default:
        return _displayPets;
    }
  }

  // 간단한 펫 카드 (리스트용)
  Widget _buildSimplePetCard(PetProfile pet) {
    final isFavorite = _favoriteIds.contains(pet.id);
    
    return GestureDetector(
      onTap: () => _navigateToDetail(pet),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단: 매칭도 + 하트
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.brown,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${pet.matchPercentage}% 매칭',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        _favoriteIds.remove(pet.id);
                      } else {
                        _favoriteIds.add(pet.id);
                      }
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : AppColors.textGrey,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // 중간: 펫 정보
            Row(
              children: [
                // 펫 아바타
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _getPetAvatarColor(pet.id),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _getPetEmoji(pet.breed),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // 펫 정보
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${pet.breed}, ${pet.age}, ${pet.gender}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red, size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${pet.location}, ${pet.distance}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 하단: 매칭 포인트 (간단히)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.infoGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.greenAccent, size: 16),
                      const SizedBox(width: 6),
                      const Text(
                        '매칭 포인트',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 매칭 포인트 4개 중 처음 2개만 표시
                  ...pet.matchingPoints.take(2).map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.greenAccent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  if (pet.matchingPoints.length > 2)
                    Text(
                      '+ ${pet.matchingPoints.length - 2}개 더',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textGrey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPetAvatarColor(int petId) {
    final colors = [
      const Color(0xFFFFB347), // 오렌지
      const Color(0xFF87CEEB), // 스카이블루  
      const Color(0xFFF0E68C), // 카키
    ];
    return colors[petId % colors.length];
  }

  String _getPetEmoji(String breed) {
    if (breed.contains('믹스')) return '🐕';
    if (breed.contains('코숏')) return '🐱';
    if (breed.contains('퍼그')) return '🐶';
    return '🐾';
  }

  void _navigateToDetail(PetProfile pet) {
    // 상세 화면으로 이동
    Navigator.pushNamed(
      context, 
      '/family/detail',
      arguments: pet, // 펫 정보 전달
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
            '매칭결과',
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