import 'package:flutter/material.dart';

/// 2번 파일: 위치 설정 화면 (피그마 funeral_matching_2 반영)
/// - 라우트 명은 그대로 사용(/fm/options), 클래스명도 FmOptionsPage 그대로 둠.
/// - 완료/하단 버튼 시 현재 선택된 위치를 Navigator.pop(context, value) 로 반환.

class AppColors {
  static const brown = Color(0xFF8C6239);
  static const lightBrown = Color(0xFFF0E6D6);
  static const background = Color(0xFFF5F5F5);
  static const border = Color(0xFFE1D7C7);
  static const accent = Color(0xFFD2691E);
  static const textGrey = Color(0xFF666666);
}

class FmOptionsPage extends StatefulWidget {
  const FmOptionsPage({super.key});

  @override
  State<FmOptionsPage> createState() => _FmOptionsPageState();
}

class _FmOptionsPageState extends State<FmOptionsPage> {
  final _searchCtrl = TextEditingController();
  String _selected = '현재 위치 사용';
  final List<String> _recent = ['서울시 강남구', '서울시 송파구'];
  final List<String> _popular = ['서울시', '부산시'];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MediaQuery(
      data: mq.copyWith(textScaleFactor: mq.textScaleFactor.clamp(1.0, 1.1)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _TopBar(onBack: () => Navigator.pop(context), onDone: _finish)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SearchField(controller: _searchCtrl, onSubmit: _onSubmitSearch),
                      const SizedBox(height: 16),
                      _SectionHeader('현재 위치'),
                      const SizedBox(height: 8),
                      _CurrentLocationCard(
                        selected: _selected == '현재 위치 사용',
                        onTap: () {
                          setState(() => _selected = '현재 위치 사용');
                          _toast('현재 위치로 설정했습니다.');
                        },
                      ),
                      const SizedBox(height: 16),
                      _SectionHeader('최근 검색한 위치'),
                      const SizedBox(height: 8),
                      ..._recent.map((e) => _RecentTile(
                            title: e,
                            subtitle: e == '서울시 강남구' ? '서울시 강남구 테헤란로' : '서울시 송파구 잠실로',
                            selected: _selected == e,
                            onTap: () {
                              setState(() => _selected = e);
                              _toast('$e로 설정했습니다.');
                            },
                          )),
                      const SizedBox(height: 16),
                      _SectionHeader('인기 지역'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _PopularCard(
                              label: _popular[0],
                              icon: Icons.location_city,
                              selected: _selected == _popular[0],
                              onTap: () {
                                setState(() => _selected = _popular[0]);
                                _toast('${_popular[0]}로 설정했습니다.');
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _PopularCard(
                              label: _popular[1],
                              icon: Icons.apartment,
                              selected: _selected == _popular[1],
                              onTap: () {
                                setState(() => _selected = _popular[1]);
                                _toast('${_popular[1]}로 설정했습니다.');
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _finish,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  '현재 위치로 설정하기',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitSearch(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _selected = text.trim();
      if (!_recent.contains(_selected)) {
        _recent.insert(0, _selected);
        if (_recent.length > 5) _recent.removeLast();
      }
    });
    _toast('$_selected 로 설정했습니다.');
  }

  void _finish() {
    Navigator.pop(context, _selected); // 선택한 위치 반환
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.brown),
    );
  }
}

// ===== 위젯들 =====

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onDone;
  const _TopBar({required this.onBack, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      color: AppColors.background,
      child: Row(
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back, color: Colors.black)),
          const SizedBox(width: 4),
          const Text('위치 설정', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const Spacer(),
          TextButton(
            onPressed: onDone,
            child: const Text('완료', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmit;
  const _SearchField({required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmit,
              decoration: const InputDecoration(
                hintText: '지역명, 도로명 또는 건물명 검색',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
    );
  }
}

class _CurrentLocationCard extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  const _CurrentLocationCard({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.brown : AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.lightBrown,
              child: Icon(Icons.place, color: AppColors.accent),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('현재 위치 사용', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: 2),
                  Text('GPS를 통해 자동으로 감지', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF2D2C2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('정확', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  const _RecentTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.brown : AppColors.border),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.lightBrown,
              child: Icon(Icons.home_work, color: AppColors.accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopularCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PopularCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? AppColors.brown : AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.accent),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}
