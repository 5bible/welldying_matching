import 'new_family_matcher.dart';

/// ---------- 사용자 프로필 (테스트용) ----------
final mockUserProfile = UserProfile(
  housing: HousingType.apartment,   // 아파트 거주
  space: SpaceSize.small,           // 작은 공간
  hasKids: true,                    // 아이 있음
  workType: WorkType.office,        // 출근형 근무
  experience: ExperienceLevel.beginner, // 초보자
  activity: ActivityLevel.low,      // 활동량 낮음
  budget: BudgetLevel.medium,       // 중간 예산
  readiness: Readiness.medium,      // 보통 준비도
  location: const LatLng(37.4979, 127.0276), // 강남역 근처 (예시)
);

/// ---------- 펫 후보 1 (테스트용) ----------
final mockPetCandidate = PetCandidate(
  id: '1',
  name: '바둑이',
  breed: '믹스견',
  size: 'medium',
  energy: ActivityLevel.low,    // 활동량 낮음
  sociability: 0.9,             // 사람 좋아함
  trainEase: 0.85,              // 훈련 쉬움
  medicalNeeds: 0.2,            // 의료비 부담 적음
  noise: 0.3,                   // 조용함
  kidFriendly: true,            // 아이 친화적
  separationAnxietyLow: false,  // 분리불안 약간 있음
  allowedHousings: {HousingType.apartment, HousingType.officetel},
  specialCare: false,
  availableToday: true,
  shelterLocation: const LatLng(37.5030, 127.0460), // 강남구 보호소 (예시)
  shelterName: '서울 강남구 동물보호소',
);
