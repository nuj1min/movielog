# 2주차 제출 안내

## Notion에 넣을 위치

1. **📮 제출 양식**에 아래 첫 번째 코드 블록을 복사합니다.
2. **📸 스터디 인증**에 아래 PNG 파일을 업로드합니다. 입력 완료와 제출 완료는 서로 다른 상태입니다.
   - 입력 전: `screenshots/week-2-empty.png`
   - Validation 오류: `screenshots/week-2-validation.png`
   - 모든 조건이 유효한 상태: `screenshots/week-2-valid.png`
   - 실제 Android 키보드 열림: `screenshots/week-2-keyboard.png`
   - 평점 4.5점 선택: `screenshots/week-2-rating.png`
   - 넓은 화면 Challenge: `screenshots/week-2-wide.png`
   - 추가 제출 완료: `screenshots/week-2-submitted.png`
3. **🛠 트러블슈팅 기록**에는 두 번째 코드 블록을 복사합니다.
4. 이름과 회고를 본인 경험에 맞게 확인한 뒤 Notion 페이지 공유 링크를 UMC 제출란에 붙여넣습니다.

## 📮 제출 양식에 복사

```text
이름 / 닉네임: 김민준 / 야르
GitHub 저장소: https://github.com/nuj1min/movielog
Pull Request: https://github.com/nuj1min/movielog/pull/3
입력 전 화면: week-2-empty.png 첨부
Validation 오류 화면: week-2-validation.png 첨부
입력 완료 화면: week-2-valid.png 첨부
키보드가 열린 화면: week-2-keyboard.png 첨부
평점 선택 화면: week-2-rating.png 첨부
넓은 화면 Challenge: week-2-wide.png 첨부
Validator 규칙: 닉네임은 앞뒤 공백을 제외하고 두 글자 이상, 이메일은 공백 없이 사용자명@도메인.확장자 형태, 비밀번호는 8자 이상이며 공백만 입력한 값은 허용하지 않는다. 필수 약관 동의까지 충족해야 가입 버튼이 활성화된다. 버튼을 눌렀을 때 Form.validate()로 다시 검증한다.
선택한 평점: 4.5점. flutter_rating_bar로 0.5점 단위 선택을 구현했다. 별점을 선택하기 전에는 평점 저장 버튼이 비활성화되고, 선택 후 활성화된다. 저장은 화면 내부 상태에만 반영되며 API는 사용하지 않는다.
dispose한 객체: 닉네임·이메일·비밀번호 TextEditingController 3개와 FocusNode 3개. Controller listener도 정리했다.
사용한 반응형 기준: LayoutBuilder에서 부모가 제공한 너비가 700 이상이면 가운데 정렬하고 전체 Form 영역을 최대 560으로 제한했다. 내부 좌우 Padding 24를 제외한 입력 영역은 최대 512이다. 키보드가 열리면 Scaffold가 body 높이를 줄이고 SingleChildScrollView로 입력창과 버튼에 접근한다.
트러블슈팅: Controller.clear()로 입력을 지워도 가입 버튼 상태가 즉시 바뀌도록 Controller listener에서 setState를 호출했다. 버튼과 Validator가 서로 다른 조건을 사용하지 않도록 같은 검증 함수를 재사용했다.
2주차 회고: 아래 회고 초안을 읽고 본인 경험에 맞게 수정한다.
```

## 🛠 트러블슈팅 기록에 복사

```text
문제가 발생한 입력 상태: 닉네임과 이메일 입력 후 키보드의 다음 동작으로 포커스를 이동하는 상태.
예상한 화면: 닉네임 → 이메일 → 비밀번호 순서로 포커스가 이동하고 기존 입력은 유지된다.
실제 화면: 처음 작성한 테스트에서 TextFormField.focusNode를 읽으려 해 분석 오류가 발생했다.
원인: TextFormField는 생성자로 FocusNode를 받지만 같은 이름의 공개 getter를 제공하지 않는다.
수정: 테스트에서는 실제 입력을 담당하는 EditableText의 FocusNode를 읽어 이동 여부를 확인했다. 앱의 Controller와 FocusNode는 State에서 생성하고 dispose했다.
휴대폰 확인 결과: 320×568과 390×844에서 오류 표시·포커스·버튼 상태를 확인했다. 키보드 영역 300과 글자 배율 1.5를 적용한 테스트에서도 Overflow 없이 버튼에 접근했다. Android 에뮬레이터에서도 실제 키보드 높이 300 및 370을 확인하고 가입 버튼까지 스크롤하는 통합 테스트가 통과했다.
넓은 화면 확인 결과: 900 너비 자동 테스트와 1024 너비 브라우저에서 동일한 상태와 Validator를 유지하며 중앙 정렬되는 것을 확인했다.
```

## 2주차 회고 초안

```text
1주차에는 화면 모양을 만드는 데 집중했다면, 이번에는 입력값에 따라 화면이 달라지는 부분을 배웠다. 입력창에 글자를 넣는 것과 버튼 상태를 갱신하는 것이 별개라는 점이 처음에는 헷갈렸는데, Controller와 setState의 역할을 나누어 보니 조금 이해됐다.

특히 약관을 체크했더라도 이메일이 잘못되면 가입 버튼이 비활성화되어야 해서 검증 조건을 한곳에서 관리하는 게 중요하다고 느꼈다. 작은 화면에서 키보드가 올라왔을 때도 입력창과 버튼을 볼 수 있도록 스크롤을 적용했고, 별점을 고르면서 setState가 화면에 반영되는 흐름도 확인했다. 다음에는 입력·오류·완료 상태를 먼저 정리한 뒤 코드를 작성해보고 싶다.
```

## 실행

프로젝트 루트에서 한 번에 하나씩 실행합니다.

```sh
flutter run -d chrome -t lib/main_signup.dart
flutter run -d chrome -t lib/main_rating.dart
```

Android 기기에서는 `-d chrome`을 기기 ID로 바꿉니다. 기본 `lib/main.dart`는 기존 1주차 시작 화면을 유지합니다.

## 검증 명령

```sh
flutter analyze
flutter test
flutter test integration_test/signup_keyboard_test.dart -d emulator-5554
flutter build web -t lib/main_signup.dart --output build/week2-signup
flutter build web -t lib/main_rating.dart --output build/week2-rating
```

통합 테스트는 소프트 키보드를 실제로 열 수 있는 Android 기기에서 실행합니다. 기기 전체 캡처가 필요하면 `--dart-define=CAPTURE_PAUSE_SECONDS=45`를 추가할 수 있습니다.

## 범위 및 참고

- Required Mission과 비밀번호 표시/숨김·공통 입력창·넓은 화면 Challenge를 구현했습니다.
- 별점은 서버나 디스크에 저장하지 않습니다. 앱을 다시 실행하면 초기화됩니다.
- Figma 연결 도구는 편집 권한 오류를 반환했습니다. 이번 구현은 첨부 워크북의 기능 요구사항과 기존 MovieLog 테마를 기준으로 만들었으며, W2 Figma 원본과 픽셀 일치 검증을 완료했다고 주장하지 않습니다.
- 1주차 PR이 아직 열려 있어 2주차 PR은 `feature/week-1`을 기준으로 작성합니다. 1주차를 먼저 병합한 뒤 2주차의 기준 브랜치를 main으로 변경하면 됩니다.
- [Flutter Form 검증](https://docs.flutter.dev/cookbook/forms/validation), [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)
