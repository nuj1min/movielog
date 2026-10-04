# 2주차 학습 정리

## Widget Tree

```text
MovieLogApp → MaterialApp → SignUpScreen (StatefulWidget)
└─ Scaffold (키보드가 열리면 body 높이를 줄임)
   ├─ CommonAppBar
   └─ SafeArea → LayoutBuilder → Align → ConstrainedBox (최대 560)
      └─ SingleChildScrollView → Form → Column
         ├─ SignUpHeader
         ├─ MovieLogTextFormField: 닉네임
         ├─ MovieLogTextFormField: 이메일
         ├─ MovieLogTextFormField: 비밀번호 + 표시/숨김
         ├─ TermsAgreement → CheckboxListTile
         ├─ ElevatedButton: 가입하기
         └─ SignUpConfirmation (제출 성공 시)

MovieLogApp → MaterialApp → RatingScreen (StatefulWidget)
└─ Scaffold → SafeArea → SingleChildScrollView → Column
   ├─ RatingHeader
   ├─ RatingBar.builder
   ├─ 선택한 평점 Text
   ├─ ElevatedButton: 평점 저장
   ├─ TextButton: 다시 선택하기
   └─ 화면 내부에 저장한 평점 Text
```

## 상태 흐름

- Controller listener → setState → 최신 Validator 결과와 약관 상태로 버튼 활성화 여부 계산.
- 최초 입력 전에는 오류 없음. 입력한 필드는 onUserInteraction으로 오류 표시.
- 닉네임의 다음 → 이메일 FocusNode, 이메일의 다음 → 비밀번호 FocusNode.
- 비밀번호의 완료 또는 가입 버튼 → Form.validate() → 필수 약관 검사 → 키보드 닫기 → 로컬 완료 안내.
- 모든 조건이 유효해도 약관을 해제하거나 입력을 잘못 바꾸면 버튼은 다시 비활성화.
- RatingBar.onRatingUpdate → 선택 평점 변경 → 저장 버튼 활성화 → 저장 시 화면 내부 savedRating 변경.

## 개념 정리

- Expanded는 Row/Column에서 배정받은 남은 공간을 채웁니다. Flexible은 배정된 공간보다 작게 표시될 수 있습니다.
- 스크롤 방향이 무한한 SingleChildScrollView 안의 Column에는 세로 Expanded를 넣지 않습니다. 가입 완료 안내의 가로 Row에서는 긴 안내 문구를 Expanded로 감쌌습니다.
- Stack은 위젯을 겹치고 Positioned는 Stack의 기준점에서 위치·크기를 지정합니다. 회원가입 Form은 겹침이 필요하지 않아 Column으로 구성했습니다.
- MediaQuery는 앱 창 크기와 키보드 viewInsets를 알려줍니다. LayoutBuilder는 부모가 현재 위젯에 허용한 공간을 알려줍니다.
- Form은 입력 필드의 검증을 묶습니다. validator는 정상일 때 null, 잘못된 값일 때 오류 메시지를 반환합니다.
- initState에서 listener를 등록하고 dispose에서 listener·Controller·FocusNode를 정리합니다. build에서는 새 Controller를 만들지 않습니다.
- 비밀번호 표시/숨김은 obscureText만 바꾸므로 입력값과 Controller가 유지됩니다.
- Logical Pixel은 UI 배치 단위이며 Physical Pixel은 Logical Pixel × devicePixelRatio입니다.
