import 'package:flutter/material.dart';

/// 7번 파일: 예약 취소 화면
class AppColors {
  static const brown = Color(0xFF8C6239);
  static const lightBrown = Color(0xFFF0E6D6);
  static const background = Color(0xFFF5F5F5);
  static const border = Color(0xFFE1D7C7);
  static const accent = Color(0xFFD2691E);
  static const textGrey = Color(0xFF666666);
  static const cardBg = Color(0xFFEDE6DC);
  static const warningYellow = Color(0xFFFFC107);
}

class FmCancelPage extends StatefulWidget {
  const FmCancelPage({super.key});

  @override
  State<FmCancelPage> createState() => _FmCancelPageState();
}

class _FmCancelPageState extends State<FmCancelPage> {
  bool _agreeToCancel = false;
  final String reservationNumber = 'WD2508190001';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          '예약 취소',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // 경고 아이콘
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.warningYellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning,
                color: Colors.white,
                size: 40,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 취소 확인 메시지
            const Text(
              '예약을 취소하시겠습니까?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              '취소 후에는 되돌릴 수 없습니다.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textGrey,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 취소할 예약 정보
            _buildReservationInfo(),
            
            const SizedBox(height: 24),
            
            // 취소 정책 및 주의사항
            _buildCancelPolicy(),
            
            const SizedBox(height: 24),
            
            // 동의 체크박스
            _buildAgreementCheckbox(),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildReservationInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '취소할 예약 정보',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // 예약번호
          Row(
            children: [
              const Text(
                '예약번호',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                ),
              ),
              const Spacer(),
              Text(
                reservationNumber,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
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
                  fontSize: 18,
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
      padding: const EdgeInsets.only(bottom: 8),
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

  Widget _buildCancelPolicy() {
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
                '취소 정책 및 주의사항',
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
            '• 예약일 48시간 전까지는 무료 취소가 가능합니다.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 4),
          const Text(
            '• 취소 후, 같은 날짜/시간에 대한 재예약은 어려울 수 있습니다.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToCancel,
          onChanged: (value) {
            setState(() {
              _agreeToCancel = value ?? false;
            });
          },
          activeColor: AppColors.brown,
        ),
        const Expanded(
          child: Text(
            '예약 취소에 동의하며, 되돌릴 수 없음을 이해합니다.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
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
                onPressed: () => Navigator.maybePop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '돌아가기',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _agreeToCancel ? _confirmCancel : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _agreeToCancel ? Colors.red : Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '예약취소하기',
                  style: TextStyle(
                    color: _agreeToCancel ? Colors.white : Colors.grey[600],
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

    void _confirmCancel() {
    // 취소 완료 전용 화면으로 이동
    Navigator.pushReplacementNamed(context, '/funeral/cancel_complete');
    }
}