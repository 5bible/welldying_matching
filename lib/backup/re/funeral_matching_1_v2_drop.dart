import 'package:flutter/material.dart';
import 'main.dart';
import 'funeral_matching_3.dart';

class FmIntroPage extends StatefulWidget {
  const FmIntroPage({super.key});

  @override
  State<FmIntroPage> createState() => _FmIntroPageState();
}

class _FmIntroPageState extends State<FmIntroPage> {
  String _location = '서울시 강남구';
  String _budget = '50-100만원';
  String _schedule = '3일 이내';
  String _petSize = '소형';

  final budgets = const ['50만원 이하', '50-100만원', '100-200만원', '200만원 이상'];
  final schedules = const ['긴급', '3일 이내', '일주일 이내'];
  final sizes = const ['소형', '중형', '대형'];

  Future<void> _goLocationSettings() async {
    final selected = await Navigator.pushNamed(
      context,
      AppRoutes.fmOptions,
    ) as String?;
    if (selected != null && selected.isNotEmpty) {
      setState(() => _location = selected);
    }
  }

  void _goResults() {
    Navigator.pushNamed(
      context,
      AppRoutes.fmResults,
      arguments: FmSearchArgs(
        location: _location,
        budget: _budget,
        schedule: _schedule,
        petSize: _petSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 개발 지침에 따른 정확한 색상 상수
    const primaryBrown = Color(0xFF8C6239);     // 갈색 (선택된 칩, 버튼)
    const chipBorder = Color(0xFFE1D7C7);       // 칩 테두리
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('장례 준비'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _Banner(),
          const SizedBox(height: 12),
          _AiCard(
            location: _location,
            budget: _budget,
            schedule: _schedule,
            size: _petSize,
          ),
          const SizedBox(height: 12),
          _SectionTile(
            title: '현재 위치',
            subtitle: '근린병원에서 3km / 평균이동시간 15분',
            leading: const Icon(Icons.place_rounded, color: Colors.brown),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              _Dot(Colors.green),
              const SizedBox(width: 6),
              Text(_location, style: const TextStyle(fontWeight: FontWeight.w600)),
            ]),
          ),
          TextButton.icon(
            onPressed: _goLocationSettings,
            icon: const Icon(Icons.edit_location_alt_outlined),
            label: const Text('위치 변경'),
            style: TextButton.styleFrom(
              foregroundColor: primaryBrown,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          const SizedBox(height: 8),
          _GroupLabel('예산 범위'),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: budgets.map((b) {
              final selected = _budget == b;
              return ChoiceChip(
                label: Text(b),
                selected: selected,
                onSelected: (_) => setState(() => _budget = b),
                selectedColor: primaryBrown.withOpacity(.15),
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(color: selected ? primaryBrown : chipBorder),
                ),
                labelStyle: TextStyle(
                  color: selected ? primaryBrown : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          _GroupLabel('희망 일정'),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: schedules.map((s) {
              final selected = _schedule == s;
              return ChoiceChip(
                label: Text(s),
                selected: selected,
                onSelected: (_) => setState(() => _schedule = s),
                selectedColor: primaryBrown.withOpacity(.15),
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(color: selected ? primaryBrown : chipBorder),
                ),
                labelStyle: TextStyle(
                  color: selected ? primaryBrown : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          _GroupLabel('반려동물 크기'),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: sizes.map((s) {
              final selected = _petSize == s;
              return ChoiceChip(
                label: Text(s),
                selected: selected,
                onSelected: (_) => setState(() => _petSize = s),
                selectedColor: primaryBrown.withOpacity(.15),
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(color: selected ? primaryBrown : chipBorder),
                ),
                labelStyle: TextStyle(
                  color: selected ? primaryBrown : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _goResults,
              style: FilledButton.styleFrom(
                backgroundColor: primaryBrown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('맞춤 시설 찾기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 6, offset: const Offset(0,3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: const [
          Text('🕯️ 가까운 곳에서 편안하게\n믿을 수 있는 시설을 찾아드려요',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E6D6), borderRadius: BorderRadius.circular(999),
          ),
          child: const Text('매섬이를 위한 마지막 배웅 준비', style: TextStyle(color: Colors.brown)),
        )
      ]),
    );
  }
}

class _AiCard extends StatelessWidget {
  final String location, budget, schedule, size;
  const _AiCard({
    required this.location, required this.budget, required this.schedule, required this.size,
  });

  @override
  Widget build(BuildContext context) {
    Widget pill(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.lightBlue.shade200),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFF0B75C9), fontWeight: FontWeight.w600)),
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 6, offset: const Offset(0,3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('🤖 AI 맞춤 추천', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text('매섬이(미니어처푸들, 8살)의 프로필을 분석한 결과입니다.',
          style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 8, children: [
          pill('위치: $location'),
          pill('예산: $budget'),
          pill('일정: $schedule'),
          pill('크기: $size'),
        ]),
      ]),
    );
  }
}

class _SectionTile extends StatelessWidget {
  final String title, subtitle;
  final Widget? leading, trailing;
  const _SectionTile({required this.title, required this.subtitle, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        if (leading != null) leading!,
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
        ])),
        if (trailing != null) trailing!,
      ]),
    );
  }
}

class _GroupLabel extends StatelessWidget {
  final String text;
  const _GroupLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(width: 10, height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}