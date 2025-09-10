import 'package:flutter/material.dart';
import 'funeral_matching_4.dart'; // FmFacilityDetailPage


/// 결과 리스트 페이지 (피그마 funeral_matching_3 반영)
/// - 전역 테마 간섭 최소화: 색/보더/라운드 로컬 고정
/// - 상단 요약/필터칩/리스트 카드
/// - '상세확인' / '관심' / '상담' 액션은 샘플 동작(SnackBar)

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
  static const textGrey = Color(0xFF666666);
}

class FmResultsPage extends StatefulWidget {
  const FmResultsPage({super.key});

  @override
  State<FmResultsPage> createState() => _FmResultsPageState();
}

class _FmResultsPageState extends State<FmResultsPage> {
  // 검색조건(1번/2번에서 넘어왔다고 가정한 값을 임시로 표시)
  final String _location = '서울시 강남구';
  final String _budget = '50-100만원';
  final String _schedule = '3일 이내';
  final String _petSize = '소형';

  // 필터 칩
  String _tab = '전체';
  final _tabs = const ['전체', '당일예약', '24시간'];

  // 관심 토글
  final Set<int> _favorites = {};

  // 더미 데이터(목업)
  late final List<Facility> _items = [
    Facility(
      name: '평안 동물병원 장례식장',
      rating: 4.8,
      reviews: 124,
      distanceKm: 1.2,
      timeMin: 5,
      price: '85만원',
      priceNote: '(조건 맞춤)',
      canReserveToday: '오늘 예약 가능 · 오후 2시부터',
      badges: const ['24시간', '픽업서비스', '개별추모실'],
      tag: '당일예약',
      addressBrief: '강남구 테헤란로 123길',
    ),
    Facility(
      name: '사랑 펫 메모리얼',
      rating: 4.6,
      reviews: 89,
      distanceKm: 1.8,
      timeMin: 7,
      price: '72만원',
      priceNote: '(15% 할인 적용)',
      canReserveToday: '내일 예약 가능 · 오전 9시부터',
      badges: const ['24시간', '픽업서비스', '개별추모실'],
      tag: '할인중',
      addressBrief: '서초구 반포대로 45',
    ),
    Facility(
      name: '하늘숲 동물장례문화원',
      rating: 4.7,
      reviews: 211,
      distanceKm: 3.1,
      timeMin: 12,
      price: '90만원',
      priceNote: '',
      canReserveToday: '오늘 예약 가능 · 상시',
      badges: const ['픽업서비스', '개별추모실'],
      tag: '24시간',
      addressBrief: '송파구 올림픽로 300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final results = _filtered(_items, _tab);
    return MediaQuery(
      data: mq.copyWith(textScaleFactor: mq.textScaleFactor.clamp(1.0, 1.1)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _HeaderBar(onBack: () => Navigator.maybePop(context))),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SummaryHeader(totalCount: _items.length),
                      const SizedBox(height: 12),
                      _AiReasonBanner(),
                      const SizedBox(height: 12),
                      _SearchConditionCard(
                        location: _location,
                        budget: _budget,
                        schedule: _schedule,
                        petSize: _petSize,
                      ),
                      const SizedBox(height: 12),
                      _FilterTabs(
                        tabs: _tabs,
                        active: _tab,
                        onChanged: (t) => setState(() => _tab = t),
                        totalCount: _items.length,
                        todayCount: _items.where((e) => e.tag == '당일예약').length,
                        allDayCount: _items.where((e) => e.tag == '24시간').length,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: results.length,
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.fromLTRB(20, i == 0 ? 8 : 6, 20, 6),
                  child: _FacilityCard(
                    facility: results[i],
                    isFavorite: _favorites.contains(results[i].hashCode),
                    onFavoriteToggle: () {
                      setState(() {
                        final h = results[i].hashCode;
                        if (_favorites.contains(h)) {
                          _favorites.remove(h);
                        } else {
                          _favorites.add(h);
                        }
                      });
                    },
                    onConsult: () => _toast(context, '상담 연결을 준비 중입니다.'),
                    onDetail: () {
                      // 상세 화면으로 이동하면서 시설 이름 전달
                      Navigator.pushNamed(
                        context, 
                        '/fm/detail',
                        arguments: results[i].name,
                      );
                    },


                    primaryColor: AppColors.brown,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }

  List<Facility> _filtered(List<Facility> list, String tab) {
    switch (tab) {
      case '당일예약':
        return list.where((e) => e.tag == '당일예약').toList();
      case '24시간':
        return list.where((e) => e.tag == '24시간').toList();
      default:
        return list;
    }
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.brown),
    );
  }
}

// ===== 모델 =====

class Facility {
  final String name;
  final double rating;
  final int reviews;
  final double distanceKm;
  final int timeMin;
  final String price;
  final String priceNote;
  final String canReserveToday;
  final List<String> badges;
  final String tag; // '당일예약' / '할인중' / '24시간' 등
  final String addressBrief;

  Facility({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.distanceKm,
    required this.timeMin,
    required this.price,
    required this.priceNote,
    required this.canReserveToday,
    required this.badges,
    required this.tag,
    required this.addressBrief,
  });
}

// ===== 상단 영역 =====

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
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back, color: Colors.black)),
          const SizedBox(width: 4),
          const Text('시설 찾기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const Spacer(),
          IconButton(
            onPressed: () {},
            tooltip: '목록',
            icon: const Icon(Icons.view_list_outlined, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {},
            tooltip: '지도',
            icon: const Icon(Icons.map_outlined, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  final int totalCount;
  const _SummaryHeader({required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('총 $totalCount개 시설 찾음',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sort, size: 18, color: Colors.black87),
          label: const Text('정렬', style: TextStyle(color: Colors.black87)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            foregroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

class _AiReasonBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.infoBlueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.infoBlueBorder, width: 1),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.smart_toy, color: AppColors.infoBlue, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'AI 추천 이유: 소형견 전문 케어 시설 / 응급 고품질 장례 환경 / 리뷰 평판 내 비교 가성비',
              style: TextStyle(fontSize: 12, color: AppColors.infoBlue),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchConditionCard extends StatelessWidget {
  final String location, budget, schedule, petSize;
  const _SearchConditionCard({
    required this.location,
    required this.budget,
    required this.schedule,
    required this.petSize,
  });

  @override
  Widget build(BuildContext context) {
    Widget pill(String t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.place, size: 18, color: Colors.black87),
          const SizedBox(width: 6),
          Expanded(child: Text(location, style: const TextStyle(fontSize: 14))),
          const SizedBox(width: 8),
          const Icon(Icons.pets, size: 18, color: Colors.black87),
          const SizedBox(width: 6),
          Text(petSize, style: const TextStyle(fontSize: 14)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          const Icon(Icons.event, size: 18, color: Colors.black87),
          const SizedBox(width: 6),
          Expanded(child: Text(schedule, style: const TextStyle(fontSize: 14))),
          const SizedBox(width: 8),
          const Icon(Icons.attach_money, size: 18, color: Colors.black87),
          const SizedBox(width: 6),
          Text(budget, style: const TextStyle(fontSize: 14)),
        ]),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          pill(location),
          pill(budget),
          pill(schedule),
          pill(petSize),
        ]),
      ]),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  final List<String> tabs;
  final String active;
  final void Function(String) onChanged;
  final int totalCount, todayCount, allDayCount;

  const _FilterTabs({
    required this.tabs,
    required this.active,
    required this.onChanged,
    required this.totalCount,
    required this.todayCount,
    required this.allDayCount,
  });

  @override
  Widget build(BuildContext context) {
    int countFor(String t) {
      switch (t) {
        case '당일예약':
          return todayCount;
        case '24시간':
          return allDayCount;
        default:
          return totalCount;
      }
    }

    return Wrap(
      spacing: 8,
      children: tabs.map((t) {
        final selected = t == active;
        return ChoiceChip(
          selected: selected,
          onSelected: (_) => onChanged(t),
          label: Text('$t ${countFor(t)}'),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : Colors.black87,
          ),
          backgroundColor: Colors.white,
          selectedColor: AppColors.brown,
          shape: StadiumBorder(
            side: BorderSide(color: selected ? AppColors.brown : AppColors.border),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }
}

// ===== 리스트 카드 =====


class _FacilityCard extends StatelessWidget {
  final Facility facility;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onConsult;
  final VoidCallback onDetail;
  final Color primaryColor;

  const _FacilityCard({
    required this.facility,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onConsult,
    required this.onDetail,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget tag(String text, {Color? bg, Color? fg}) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: bg ?? AppColors.lightBrown,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: fg ?? Colors.black87,
              )),
        );

    Widget badge(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 헤더(시설명 + 상태 뱃지)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(facility.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(width: 8),
            if (facility.tag == '당일예약') tag('당일예약', bg: const Color(0xFFE8F5E9), fg: const Color(0xFF2E7D32)),
            if (facility.tag == '할인중') tag('할인중', bg: const Color(0xFFFFF3E0), fg: AppColors.accent),
            if (facility.tag == '24시간') tag('24시간', bg: const Color(0xFFE3F2FD), fg: AppColors.infoBlue),
          ],
        ),
        const SizedBox(height: 6),

        // 평점/거리/시간
        Row(
          children: [
            const Icon(Icons.star, size: 16, color: Color(0xFFFFA000)),
            const SizedBox(width: 4),
            Text('${facility.rating}  ',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            Text('(${facility.reviews}리뷰) · ',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
            Text('${facility.distanceKm}km · ${facility.timeMin}분 거리',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
          ],
        ),
        const SizedBox(height: 8),

        // 예산/예약 가능
        Text('예상 비용 : ${facility.price}${facility.priceNote.isNotEmpty ? " ${facility.priceNote}" : ""}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(facility.canReserveToday,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 8),

        // 배지
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: facility.badges.map((b) => badge(b)).toList(),
        ),
        const SizedBox(height: 12),

        // 액션 버튼
        Row(
          children: [
            _ActionChip(
              icon: Icons.favorite,
              label: isFavorite ? '관심 해제' : '관심',
              onTap: onFavoriteToggle,
              color: isFavorite ? Colors.red : Colors.black87,
              outline: true,
            ),
            const SizedBox(width: 8),
            _ActionChip(
              icon: Icons.phone_in_talk,
              label: '상담',
              onTap: onConsult,
              outline: true,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onDetail,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
              child: const Text('상세확인',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ]),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool outline;
  final Color? color;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.outline = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: color ?? Colors.black87),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color ?? Colors.black87)),
      ],
    );

    if (outline) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: child,
        ),
      );
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.brown,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: child,
    );
  }
}
