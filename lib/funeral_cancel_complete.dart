import 'package:flutter/material.dart';

/// 8번 파일: 예약 취소 완료 화면
class AppColors {
  static const brown = Color(0xFF8C6239);
  static const lightBrown = Color(0xFFF0E6D6);
  static const background = Color(0xFFF5F5F5);
  static const border = Color(0xFFE1D7C7);
  static const accent = Color(0xFFD2691E);
  static const textGrey = Color(0xFF666666);
  static const cardBg = Color(0xFFEDE6DC);
  static const cancelRed = Color(0xFFE53E3E);
}

class FmCancelCompletePage extends StatefulWidget {
  const FmCancelCompletePage({super.key});

  @override
  State<FmCancelCompletePage> createState() => _FmCancelCompletePageState();
}

class _FmCancelCompletePageState extends State<FmCancelCompletePage>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late AnimationController _fadeController;
  late Animation<double> _checkAnimation;
  late Animation<double> _fadeAnimation;

  final String reservationNumber = 'WD2508190001';

  @override
  void initState() {
    super.initState();
    
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // 애니메이션 시작
    _checkController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, 
            '/funeral/intro', 
            (route) => false,
          ),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          '예약 완료',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // X 마크 애니메이션
            AnimatedBuilder(
              animation: _checkAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _checkAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.cancelRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // 취소 완료 메시지
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                '예약이 취소되었습니다',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                '고객님의 예약이 정상적으로\n취소 처리 되었습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textGrey,
                  height: 1.4,
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // 취소된 예약 정보 카드
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildCancelledReservationCard(),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildBottomButton(),
      ),
    );
  }

  Widget _buildCancelledReservationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 예약번호 섹션
          const Text(
            '예약번호',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reservationNumber,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // 예약 정보들
          _buildInfoRow('시설명', '평안 동물병원 장례식장'),
          _buildInfoRow('반려동물', '매생이 (미니어처 푸들, 3kg)'),
          _buildInfoRow('예약일시', '8월 22일 (금) 15:00'),
          _buildInfoRow('보호자', '김춘식 010-1111-2222'),
          
          const SizedBox(height: 12),
          const Divider(color: AppColors.border),
          const SizedBox(height: 12),
          
          // 예상 비용
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '예상비용',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Text(
                '90만원',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, 
              '/funeral/intro', 
              (route) => false,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '첫 화면으로 가기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}