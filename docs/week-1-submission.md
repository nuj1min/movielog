# 1주차 제출 안내

## 아직 필요한 자료

공통 Asset ZIP 및 Figma 링크를 받지 못했습니다. 현재 로고는 직접 만든 임시 SVG이고 프로필 비트맵은 기존 Flutter 아이콘입니다. 공식 에셋으로 교체하고 Figma와 비교하기 전에는 해당 미션을 완료로 체크하지 마세요.

## 어디에 넣나요?

1. Notion 개인 1주차 미션 페이지의 **📮 미션 내용 정리** 아래 코드 블록에 다음 내용을 복사합니다. 대괄호 부분은 직접 확인하고 채웁니다.
2. **📸 스터디 인증**에 `docs/screenshots/`의 1주차 PNG 3개를 업로드합니다. 현재 캡처는 임시 에셋 상태이므로 공식 에셋 교체 후 다시 찍어야 합니다.
3. 같은 인증 영역에 `docs/week-1-widget-tree.md`의 트리와 설명을 복사합니다. 문서 제출이 허용되어 있으므로 손그림 대신 사용할 수 있습니다.
4. Figma W1-00/W1-01 캡처를 각각 Flutter 캡처 옆에 놓습니다. Figma 캡처는 아직 없습니다.
5. 마지막으로 Notion 페이지를 공유하고 링크를 복사해 UMC 미션 제출란에 붙여넣습니다.

## 📮 미션 내용 정리에 복사할 내용

```text
이름 / 닉네임: [본인 이름 / 닉네임]
GitHub 저장소: https://github.com/nuj1min/movielog
Pull Request: https://github.com/nuj1min/movielog/pull/2 (공식 에셋 및 Figma 비교 대기 중인 초안)
시작 화면 기본 Icon 적용 캡처: week-1-start-icon.png 첨부
시작 화면 로고 교체 캡처: week-1-start-logo.png 첨부 (현재 임시 로고)
프로필 완성 화면 캡처: week-1-profile.png 첨부 (현재 임시 이미지, Figma 비교 전)
재사용한 Widget: CommonAppBar, StatItem. ProfileHeader, ProfileStats, FavoriteGenres, EditProfileButton으로 의미 단위를 분리했다.
사용한 비트맵 이미지: assets/images/profile.png (공통 자료 이미지로 교체 필요)
사용한 SVG 아이콘: assets/icons/movie.svg
교체한 MovieLog 로고 경로: assets/logos/movielog_logo.svg (공통 자료의 공식 로고로 교체 필요)
선택한 버튼과 선택 이유: ElevatedButton. 시작하기와 프로필 수정이 화면의 주요 동작이라 배경색으로 강조했다. 1주차 범위에 맞게 빈 콜백을 사용했다.
사용한 주축/교차축 정렬: 시작 화면 Column은 spaceBetween/stretch, 통계 Row는 spaceBetween/start, 장르 Column은 교차축 start를 적용했다. 통계는 Expanded로 너비를 균등하게 나눴다.
Padding을 적용한 위치: 시작 화면 가장자리 32, 프로필 본문 24, 통계 카드 내부 가로 4/세로 16.
Margin을 적용한 위치: StatItem의 좌우 바깥 여백 각 4.
AppColors에서 관리한 값: 보라 #6750A4, 배경 #FAF9F5, 흰색 #FFFFFF, 본문 #1C1B1F, 보조 글자 #79747E.
ThemeData에서 관리한 값: Material 3, ColorScheme, TextTheme, AppBarTheme, Scaffold 배경, 공통 버튼 스타일.
적용한 Font: 로컬 Manrope 가변 폰트. pubspec.yaml에 등록하고 ThemeData.fontFamily에 연결했다. 한글은 플랫폼 대체 폰트를 사용한다.
트러블슈팅: 0주차 테스트가 SnackBar와 기본 아이콘을 기대하고 있어, 1주차의 SVG 로고와 빈 버튼 동작에 맞춰 검증 내용을 변경했다. 390×884와 320×568 크기에서 화면 표시와 에셋 로딩을 확인했다.
1주차 회고: [직접 실행하며 이해한 내용과 어려웠던 점을 본인 말로 2~3문장 작성]
```

## 🛠 트러블슈팅 기록에 복사할 내용

```text
이슈: 0주차 테스트의 검증 내용이 1주차 요구사항과 맞지 않았다.
원인: 기존 테스트는 시작하기 클릭 시 SnackBar가 표시되고 기본 영화 Icon을 사용하는 동작을 기대했다.
해결: SVG를 포함한 화면의 에셋 로딩, 정적인 버튼 동작, 프로필 통계 3개와 장르 3개를 검증하도록 테스트를 수정했다.
다른 해결 방법: 화면 확인용 테스트와 클릭 동작 테스트를 별도 테스트로 분리할 수 있다.
다시 발생하지 않게 확인한 내용: 요구사항 변경 시 기존 테스트의 기대값도 확인하고 flutter analyze와 flutter test를 실행한다.
```

## 실행 방법

터미널에서 프로젝트 폴더를 연 뒤 한 번에 하나씩 실행합니다.

```sh
flutter run -d chrome
flutter run -d chrome -t lib/main_profile.dart
flutter run -d chrome -t lib/main_start_icon.dart
```

순서대로 로고 시작 화면, 프로필, 기본 Icon 화면입니다. 실행 파일마다 MaterialApp.home만 바꿉니다. 화면 이동은 연결하지 않았습니다.

## 확인 결과

- `flutter analyze`: 오류 없음
- `flutter test`: 3개 통과
- 시작 화면·프로필·기본 Icon 화면 `flutter build web`: 통과
- 공식 에셋 교체 및 Figma 비교: 미완료
- Notion/UMC 제출: 본인 정보·회고·원본 비교 자료를 채운 뒤 진행
