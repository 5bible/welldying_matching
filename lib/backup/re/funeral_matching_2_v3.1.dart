import 'package:flutter/material.dart';
import 'funeral_matching_3.dart';

// 디자인 토큰 (funeral_matching_1과 동일)
const Color primaryColor = Color(0xFF8B5A3C);
const Color backgroundColor = Color(0xFFF5F5F5);
const Color cardColor = Color(0xFFEDE6DC);
const Color accentOrange = Color(0xFFD2691E);

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String selectedLocation = '';

  // 최근 검색 위치 리스트
  final List<Map<String, dynamic>> recentLocations = [
    {
      'name': '서울시 강남구',
      'description': '서울시 강남구 대치동로',
      'icon': Icons.location_city,
      'color': Colors.brown,
    },
    {
      'name': '서울시 송파구',
      'description': '서울시 송파구 잠실로',
      'icon': Icons.apartment,
      'color': Colors.red,
    },
  ];

  // 인기 지역 목록
  final List<Map<String, dynamic>> popularRegions = [
    {
      'name': '서울시',
      'icon': Icons.location_city,
    },
    {
      'name': '부산시',
      'icon': Icons.nights_stay,
    },
  ];

  // 지역별 하위 구 리스트 맵
  final Map<String, List<String>> subRegionsMap = {
    '서울시': ['강남구', '서초구', '송파구', '강동구', '마포구', '용산구', '종로구', '중구'],
    '부산시': ['해운대구', '수영구', '남구', '동구', '서구', '부산진구', '연제구', '금정구'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          '위치 설정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _onConfirmLocation,
            child: const Text(
              '완료',
              style: TextStyle(
                color: accentOrange,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            const SizedBox(height: 30),
            _buildCurrentLocationCard(),
            const SizedBox(height: 30),
            _buildRecentLocationsList(),
            const SizedBox(height: 30),
            _buildPopularRegionsRow(),
            const SizedBox(height: 40),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: '지역명, 도로명 또는 건물명 검색',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 24),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCurrentLocationCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '현재 위치',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.brown.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.my_location, color: Colors.brown, size: 24),
            ),
            title: const Text(
              '현재 위치 사용',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: const Text(
              'GPS를 통해 자동으로 감지',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: accentOrange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                '정확',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: _onCurrentLocationTap,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentLocationsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '최근 검색한 위치',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...recentLocations.map((location) {
          return _LocationTile(
            name: location['name'],
            description: location['description'],
            icon: location['icon'],
            iconColor: location['color'],
            onTap: () => _onLocationSelected(location['name']),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPopularRegionsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '인기 지역',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: popularRegions.map((region) {
            return Expanded(
              child: _RegionCard(
                name: region['name'],
                icon: region['icon'],
                onTap: () => _onRegionSelected(region['name']),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _onConfirmLocation,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          '현재 위치로 설정하기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _onCurrentLocationTap() {
    setState(() {
      selectedLocation = '현재 위치';
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('현재 위치를 확인하고 있습니다...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('현재 위치가 설정되었습니다: 서울시 강남구'),
          backgroundColor: accentOrange,
        ),
      );
      setState(() {
        selectedLocation = '서울시 강남구 (현재 위치)';
      });
    });
  }

  void _onLocationSelected(String locationName) {
    setState(() {
      selectedLocation = locationName;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$locationName이 선택되었습니다'),
        backgroundColor: accentOrange,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onRegionSelected(String regionName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final subList = subRegionsMap[regionName] ?? <String>[];
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.8,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$regionName 상세 지역',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: subList.length,
                      itemBuilder: (_, index) {
                        final subRegion = subList[index];
                        final fullLocation = '$regionName $subRegion';
                        return ListTile(
                          title: Text(subRegion),
                          trailing: (selectedLocation == fullLocation)
                              ? const Icon(Icons.check, color: accentOrange)
                              : null,
                          onTap: () {
                            setState(() {
                              selectedLocation = fullLocation;
                            });
                            Navigator.pop(context);
                            _onLocationSelected(fullLocation);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onConfirmLocation() {
    if (selectedLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치를 선택해주세요'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('위치를 설정하고 있습니다...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: accentOrange),
              SizedBox(width: 8),
              Text('위치 설정 완료'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('설정된 위치: $selectedLocation'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '이 위치를 기준으로 주변 시설을 찾아드리겠습니다.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('수정'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToNextScreen();
              },
              style: ElevatedButton.styleFrom(backgroundColor: accentOrange),
              child: const Text(
                '확인',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _navigateToNextScreen() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$selectedLocation로 설정 완료! 이전 화면으로 돌아갑니다.'),
        backgroundColor: accentOrange,
        action: SnackBarAction(
          label: '확인',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    Navigator.pop(context, selectedLocation);
  }
}
}

// 재사용 가능한 위젯들
class _LocationTile extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _LocationTile({
    required this.name,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}

class _RegionCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const _RegionCard({
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSeoul = name == '서울시';
    final List<Color> gradientColors = isSeoul
        ? [Colors.blue.shade300, Colors.blue.shade600]
        : [Colors.purple.shade300, Colors.purple.shade600];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 120,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }