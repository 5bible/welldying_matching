import 'package:flutter/material.dart';

/// 색상 토큰 (클로드 제안 색상 유지)
const kPrimaryColor = Color(0xFF8B5A3C);
const kAccentOrange = Color(0xFFD2691E);
const kBgColor = Color(0xFFF5F5F5);
const kCardColor = Color(0xFFF0E6D6);
const kGreenColor = Color(0xFF4CAF50);

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String selectedFilter = '전체';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          '시설 찾기',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _summaryCard(),
          _filterChips(),
          _sortingRow(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _facilityCard(
                  name: '평안 동물병원 장례식장',
                  rating: 4.8,
                  reviewCount: 124,
                  distance: '1.2km',
                  travelTime: '5분 거리',
                  priceInfo: '예상 비용 : 85만원(조건 맞춤)',
                  services: ['오늘 예약 가능', '오후 2시부터'],
                  tags: ['24시간', '픽업서비스', '개별추도식'],
                  features: ['화장시설', '주차가능'],
                  buttonColor: kGreenColor,
                  buttonText: '당일예약',
                  usageCount: 130,
                ),
                const SizedBox(height: 16),
                _facilityCard(
                  name: '사랑 펫 메모리얼',
                  rating: 4.6,
                  reviewCount: 89,
                  distance: '1.8km',
                  travelTime: '7분 거리',
                  priceInfo: '예상 비용 : 72만원 (15%할인 적용)',
                  services: ['내일 예약 가능', '오전 9시부터'],
                  tags: ['24시간', '픽업서비스'],
                  features: [],
                  buttonColor: kAccentOrange,
                  buttonText: '할인중',
                  isDiscounted: true,
                  usageCount: 98,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 상단 요약 카드
  Widget _summaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('총 12개 시설 찾음',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            Row(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.bookmark_border,
                      size: 16, color: Colors.grey.shade700),
                  const SizedBox(width: 4),
                  Text('북록',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade700)),
                ]),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.map, size: 16, color: Colors.grey.shade700),
                  const SizedBox(width: 4),
                  Text('지도',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade700)),
                ]),
              ),
            ]),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kPrimaryColor, width: 2),
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('검색조건',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Row(children: const [
                      Icon(Icons.location_on, size: 14, color: Colors.black87),
                      SizedBox(width: 4),
                      Text('서울시 강남구', style: TextStyle(fontSize: 12)),
                    ]),
                    const SizedBox(height: 2),
                    Row(children: const [
                      Icon(Icons.calendar_month,
                          size: 14, color: Colors.black87),
                      SizedBox(width: 4),
                      Text('3일 이내', style: TextStyle(fontSize: 12)),
                    ]),
                  ]),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: const [
                      Icon(Icons.attach_money,
                          size: 14, color: Colors.black87),
                      SizedBox(width: 4),
                      Text('50-100만원', style: TextStyle(fontSize: 12)),
                    ]),
                    const SizedBox(height: 2),
                    Row(children: const [
                      Icon(Icons.pets, size: 14, color: Colors.black87),
                      SizedBox(width: 4),
                      Text('소형', style: TextStyle(fontSize: 12)),
                    ]),
                  ]),
            ),
          ]),
        ),
      ]),
    );
  }

  // 필터 칩
  Widget _filterChips() {
    final filters = [
      {'label': '전체', 'count': 12},
      {'label': '당일예약', 'count': 5},
      {'label': '24시간', 'count': 8},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
          children: filters.map((f) {
        final isSelected = selectedFilter == f['label'];
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text('${f['label']} ${f['count']}'),
            selected: isSelected,
            selectedColor: kPrimaryColor,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected ? kPrimaryColor : Colors.grey.shade300,
              ),
            ),
            onSelected: (_) =>
                setState(() => selectedFilter = f['label'].toString()),
          ),
        );
      }).toList()),
    );
  }

  // 정렬 영역
  Widget _sortingRow() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
        Text('가까운 순으로 정렬됨',
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        Row(children: [
          Text('정렬 변경',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 16),
        ]),
      ]),
    );
  }

  // 시설 카드
  Widget _facilityCard({
    required String name,
    required double rating,
    required int reviewCount,
    required String distance,
    required String travelTime,
    required String priceInfo,
    required List<String> services,
    required List<String> tags,
    required List<String> features,
    required Color buttonColor,
    required String buttonText,
    required int usageCount,
    bool isDiscounted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.local_hospital, color: kAccentOrange, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating.floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.orange,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(width: 4),
                Text('$rating($reviewCount)',
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                Text('$usageCount회 이용',
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.location_on, color: Colors.red, size: 14),
                const SizedBox(width: 2),
                Text(distance, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 8),
                const Icon(Icons.directions_car,
                    color: Colors.grey, size: 14),
                const SizedBox(width: 2),
                Text(travelTime, style: const TextStyle(fontSize: 12)),
              ]),
            ]),
          ),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          const Icon(Icons.attach_money, color: kGreenColor, size: 16),
          const SizedBox(width: 4),
          Text(
            priceInfo,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDiscounted ? Colors.red : Colors.black87,
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          const Icon(Icons.schedule, color: Colors.blue, size: 16),
          const SizedBox(width: 4),
          Text(services.join(' • '),
              style:
                  const TextStyle(fontSize: 12, color: Colors.black87)),
        ]),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...tags.map((t) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kGreenColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(t,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                )),
            ...features.map((f) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(f,
                      style: const TextStyle(
                          color: Colors.black87, fontSize: 10)),
                )),
          ],
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.favorite, color: Colors.blue, size: 16),
                    SizedBox(width: 4),
                    Text('관심',
                        style:
                            TextStyle(color: Colors.blue, fontSize: 12)),
                  ]),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Text('상담',
                        style:
                            TextStyle(color: Colors.red, fontSize: 12)),
                  ]),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text('상세확인',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12)),
                  ]),
            ),
          ),
        ]),
      ]),
    );
  }
}
