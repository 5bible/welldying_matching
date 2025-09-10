import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 6번 파일: 예약 완료 화면
class AppColors {
  static const brown = Color(0xFF8C6239);
  static const lightBrown = Color(0xFFF0E6D6);
  static const background = Color(0xFFF5F5F5);
  static const border = Color(0xFFE1D7C7);
  static const accent = Color(0xFFD2691E);
  static const textGrey = Color(0xFF666666);
  static const cardBg = Color(0xFFEDE6DC);
  static const successGreen = Color(0xFF4CAF50);
}

class FmReservationCompletePage extends StatefulWidget {
  const FmReservationCompletePage({super.key});

  @override
  State<FmReservationCompletePage> createState() => _FmReservationCompletePageState();
}

class _FmReservationCompletePageState extends State<FmReservationCompletePage>
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
            
            // 체크 아이콘 애니메이션
            AnimatedBuilder(
              animation: _checkAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _checkAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // 완료 메시지
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                '예약이 완료되었습니다',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // 예약 정보 카드
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildReservationCard(),
            ),
            
            const SizedBox(height: 24),
            
            // 안내 정보
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildInfoCard(),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildBottomButtons(),
      ),
    );
  }

  Widget _buildReservationCard() {
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
          Row(
            children: [
              const Text(
                '예약번호',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => _copyToClipboard(reservationNumber),
                child: Row(
                  children: [
                    Text(
                      reservationNumber,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy, size: 18, color: AppColors.accent),
                  ],
                ),
              ),
            ],
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

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF90CAF9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '예약 완료 안내',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '• 예약 확정 : 선택하신 일정으로 확정되었습니다.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 4),
          const Text(
            '• 준비 사항 : 발견 등록증과 관련 서류를 준비해주세요.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 4),
          const Text(
            '• 변경 및 취소: 예약된 일정 48시간 전까지 일정 변경 및 취소가 가능합니다.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 4),
          const Text(
            '• 추가 옵션 : 장례식장에서 추가 옵션을 자유롭게 선택할 수 있습니다.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
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
              child: OutlinedButton(
                onPressed: () => _changeReservation(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '예약변경',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/funeral/cancel'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '예약취소',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showPaymentDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '계약/결제',
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('예약번호가 복사되었습니다.'),
        backgroundColor: AppColors.successGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _changeReservation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('예약 변경'),
        content: const Text('예약을 변경하시겠습니까?\n처음 시설 찾기 화면으로 이동합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context, 
                '/funeral/intro', 
                (route) => false,
              );
            },
            child: const Text('변경하기'),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('계약/결제'),
        content: const Text('계약서 작성 및 결제를 진행하시겠습니까?\n장례식장으로 연결됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showToast('장례식장으로 연결됩니다.');
            },
            child: const Text('진행하기'),
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
        duration: const Duration(seconds: 2),
      ),
    );
  }
}