import 'package:flutter/material.dart';

class FmOptionsPage extends StatefulWidget {
  const FmOptionsPage({super.key});

  @override
  State<FmOptionsPage> createState() => _FmOptionsPageState();
}

class _FmOptionsPageState extends State<FmOptionsPage> {
  String? _selectedArea;

  void _finish() {
    Navigator.pop(context, _selectedArea ?? '');
  }

  @override
  Widget build(BuildContext context) {
    // 개발 지침에 따른 정확한 색상 상수
    const primaryBrown = Color(0xFF8C6239);     // 갈색 (버튼)
    const chipBorder = Color(0xFFE1D7C7);       // 테두리
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('위치 설정'),
        actions: [
          TextButton(
            onPressed: _finish,
            style: TextButton.styleFrom(foregroundColor: primaryBrown),
            child: const Text('완료', style: TextStyle(fontWeight: FontWeight.w700)),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // 검색창
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12),
              border: Border.all(color: chipBorder),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: '지역명, 도로명 또는 건물명 검색',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          _CardSection(
            title: '현재 위치',
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: const Icon(Icons.my_location, color: Colors.brown),
              title: const Text('현재 위치 사용'),
              subtitle: const Text('GPS를 통해 자동으로 감지'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E6D6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text('정확', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              onTap: () => setState(() => _selectedArea = '현재 위치'),
            ),
          ),

          const SizedBox(height: 12),
          _CardSection(
            title: '최근 검색한 위치',
            child: Column(children: [
              _areaTile('서울시 강남구', '서울시 강남구 테헤란로'),
              _areaTile('서울시 송파구', '서울시 송파구 잠실로'),
            ]),
          ),

          const SizedBox(height: 12),
          _CardSection(
            title: '인기 지역',
            child: Row(children: [
              Expanded(child: _popularArea('서울시')),
              const SizedBox(width: 12),
              Expanded(child: _popularArea('부산시')),
            ]),
          ),

          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () => Navigator.pop(context, '현재 위치'),
              style: FilledButton.styleFrom(
                backgroundColor: primaryBrown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('현재 위치로 설정하기', 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _areaTile(String title, String sub) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: const Icon(Icons.location_city, color: Colors.brown),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(sub),
      onTap: () => setState(() => _selectedArea = title),
    );
  }

  Widget _popularArea(String label) {
    const chipBorder = Color(0xFFE1D7C7);
    
    return InkWell(
      onTap: () => setState(() => _selectedArea = label),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: chipBorder),
        ),
        child: Center(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
      ),
    );
  }
}

class _CardSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _CardSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        const Divider(height: 1),
        Padding(padding: const EdgeInsets.all(6), child: child),
      ]),
    );
  }
}