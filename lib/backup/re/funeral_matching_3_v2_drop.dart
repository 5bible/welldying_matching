import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FmSearchArgs {
  final String location;
  final String budget;
  final String schedule;
  final String petSize;
  
  const FmSearchArgs({
    this.location = '서울시 강남구',
    this.budget = '50-100만원',
    this.schedule = '3일 이내',
    this.petSize = '소형',
  });
}

class FmResultsPage extends StatefulWidget {
  final FmSearchArgs args;
  const FmResultsPage({super.key, required this.args});

  @override
  State<FmResultsPage> createState() => _FmResultsPageState();
}

class _FmResultsPageState extends State<FmResultsPage> {
  bool isMapView = false;
  int selectedFilter = 0; // 0: 전체, 1: 당일예약, 2: 24시간
  final Set<String> favorites = {};

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('전화를 걸 수 없습니다.')),
        );
      }
    }
  }

  void _toggleFavorite(String facilityId) {
    setState(() {
      if (favorites.contains(facilityId)) {
        favorites.remove(facilityId);
      } else {
        favorites.add(facilityId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('시설 찾기', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // 상단 헤더
          Row(
            children: [
              const Text(
                '총 12개 시설 찾음',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              // 목록/지도 토글
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildToggleButton('목록', !isMapView, () => setState(() => isMapView = false)),
                    _buildToggleButton('지도', isMapView, () => setState(() => isMapView = true)),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // AI 추천 이유
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF90CAF9)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🤖', style: TextStyle(fontSize: 14)),
                SizedBox(width: 6),
                Text(
                  'AI 추천 이유: 소형견 전문 케어/상담 고평점/예산 적합',
                  style: TextStyle(color: Color(0xFF1976D2), fontSize: 11),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 검색조건 카드
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6D6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('검색조건', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildConditionChip(Icons.place, args.location),
                    _buildConditionChip(Icons.monetization_on, args.budget),
                    _buildConditionChip(Icons.schedule, args.schedule),
                    _buildConditionChip(Icons.pets, args.petSize),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 필터 칩들
          Row(
            children: [
              _buildFilterChip('전체', 0, 12),
              const SizedBox(width: 8),
              _buildFilterChip('당일예약', 1, 5),
              const SizedBox(width: 8),
              _buildFilterChip('24시간', 2, 8),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 시설 리스트
          if (!isMapView) ...[
            // 평안 동물병원 장례식장
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('🕯️', style: TextStyle(fontSize: 16)),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text(
                                    '평안 동물병원 장례식장',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.star, color: Colors.orange, size: 14),
                                SizedBox(width: 2),
                                Text('4.8', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                Text(' (7124명) · 5분 거리 · 1.2km', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.monetization_on_outlined, size: 14, color: Color(0xFF8B5A3C)),
                                SizedBox(width: 4),
                                Text('예상 비용 : 85만원(조건 맞춤)', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text('오늘 예약 가능 · 오후 2시부터', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _buildServiceTag('24시간'),
                                _buildServiceTag('픽업서비스'),
                                _buildServiceTag('개별추모식'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '당일예약',
                          style: TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _toggleFavorite('f1'),
                          icon: Icon(
                            favorites.contains('f1') ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: favorites.contains('f1') ? Colors.red : const Color(0xFF1976D2),
                          ),
                          label: const Text('관심', style: TextStyle(color: Color(0xFF1976D2), fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF1976D2)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _makePhoneCall('02-1234-5678'),
                          icon: const Icon(Icons.call, size: 16, color: Colors.red),
                          label: const Text('상담', style: TextStyle(color: Colors.red, fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            foregroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('상세 정보를 확인합니다.')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF424242),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          '상세확인',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // 사랑 펫 메모리얼
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('🕯️', style: TextStyle(fontSize: 16)),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text(
                                    '사랑 펫 메모리얼',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.star, color: Colors.orange, size: 14),
                                SizedBox(width: 2),
                                Text('4.6', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                Text(' (6890명) · 7분 거리 · 1.8km', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.monetization_on_outlined, size: 14, color: Color(0xFF8B5A3C)),
                                SizedBox(width: 4),
                                Text('예상 비용 : 72만원(15%할인 적용)', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text('내일 예약 가능 · 오전 9시부터', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _buildServiceTag('24시간'),
                                _buildServiceTag('픽업서비스'),
                                _buildServiceTag('개별추모식'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE0B2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '할인중',
                          style: TextStyle(color: Color(0xFFFF8F00), fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _toggleFavorite('f2'),
                          icon: Icon(
                            favorites.contains('f2') ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: favorites.contains('f2') ? Colors.red : const Color(0xFF1976D2),
                          ),
                          label: const Text('관심', style: TextStyle(color: Color(0xFF1976D2), fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF1976D2)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _makePhoneCall('02-1111-2222'),
                          icon: const Icon(Icons.call, size: 16, color: Colors.red),
                          label: const Text('상담', style: TextStyle(color: Colors.red, fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('상세 정보를 확인합니다.')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF424242),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          '상세확인',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            // 지도 뷰
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xFFF0E6D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '지도 뷰 준비 중',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildToggleButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF8B5A3C) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
  
  Widget _buildConditionChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF8B5A3C)),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip(String label, int index, int count) {
    final selected = selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF8B5A3C).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF8B5A3C) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? const Color(0xFF8B5A3C) : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF8B5A3C) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServiceTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFB8E6B8)),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Color(0xFF2E7D32),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}