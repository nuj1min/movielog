import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movielog/features/signup/signup_screen.dart';
import 'package:movielog/features/signup/signup_validators.dart';
import 'package:movielog/movie_log_app.dart';

void main() {
  test('Validator 경계값과 앞뒤 공백 처리', () {
    for (final nickname in ['', ' ', '가', '🎬']) {
      expect(SignUpValidators.nickname(nickname), isNotNull);
    }
    expect(SignUpValidators.nickname('  무비  '), isNull);
    for (final email in [
      '',
      'movie@',
      'movie@example',
      '@example.com',
      'movie @example.com',
      'movie@example..com',
      'a@@b.com',
    ]) {
      expect(SignUpValidators.email(email), isNotNull, reason: email);
    }
    expect(SignUpValidators.email(' movie+log@example.co.kr '), isNull);
    expect(SignUpValidators.password('1234567'), isNotNull);
    expect(SignUpValidators.password('        '), isNotNull);
    expect(SignUpValidators.password('12345678'), isNull);
  });

  Future<void> open(
    WidgetTester tester, {
    Size size = const Size(390, 844),
    double inset = 0,
    double scale = 1,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    tester.view.viewInsets = FakeViewPadding(bottom: inset);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(
            size: size,
            viewInsets: EdgeInsets.only(bottom: inset),
            textScaler: TextScaler.linear(scale),
          ),
          child: const SignUpScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> fill(WidgetTester tester, int index, String text) async {
    final field = find.byType(TextFormField).at(index);
    await tester.ensureVisible(field);
    await tester.enterText(field, text);
    await tester.pumpAndSettle();
  }

  ElevatedButton submit(WidgetTester tester) => tester.widget<ElevatedButton>(
    find.widgetWithText(ElevatedButton, '가입하기'),
  );

  testWidgets('입력 전 오류 없음 → 잘못된 입력 오류 → 유효한 입력과 약관 → 로컬 완료', (tester) async {
    await open(tester);
    expect(submit(tester).onPressed, isNull);
    expect(find.text('닉네임을 입력해주세요.'), findsNothing);
    await fill(tester, 0, '무');
    await fill(tester, 1, 'movie@');
    await fill(tester, 2, '123');
    expect(find.text('닉네임은 두 글자 이상 입력해주세요.'), findsOneWidget);
    expect(find.text('올바른 이메일 형식을 입력해주세요.'), findsOneWidget);
    expect(find.text('비밀번호는 8자 이상 입력해주세요.'), findsOneWidget);
    expect(submit(tester).onPressed, isNull);
    await fill(tester, 0, '무비러버');
    await fill(tester, 1, 'movie@example.com');
    await fill(tester, 2, 'movie1234');
    expect(submit(tester).onPressed, isNull);
    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(submit(tester).onPressed, isNotNull);
    await tester.ensureVisible(find.text('가입하기'));
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpConfirmation), findsOneWidget);
    await fill(tester, 1, 'invalid');
    expect(submit(tester).onPressed, isNull);
    expect(find.byType(SignUpConfirmation), findsNothing);
    await fill(tester, 1, 'movie@example.com');
    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(submit(tester).onPressed, isNull);
  });

  testWidgets('다음/완료 포커스, 표시 전환, clear와 리소스 정리', (tester) async {
    await open(tester);
    await fill(tester, 0, '무비러버');
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).at(1))
          .focusNode
          .hasFocus,
      isTrue,
    );
    await fill(tester, 1, 'movie@example.com');
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).at(2))
          .focusNode
          .hasFocus,
      isTrue,
    );
    await fill(tester, 2, 'movie1234');
    final password = find.byType(EditableText).at(2);
    expect(tester.widget<EditableText>(password).obscureText, isTrue);
    await tester.tap(find.byTooltip('비밀번호 표시'));
    await tester.pumpAndSettle();
    expect(tester.widget<EditableText>(password).obscureText, isFalse);
    expect(tester.widget<EditableText>(password).controller.text, 'movie1234');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('필수 약관에 동의해주세요.'), findsOneWidget);
    await tester.ensureVisible(find.byTooltip('닉네임 지우기'));
    await tester.tap(find.byTooltip('닉네임 지우기'));
    await tester.pumpAndSettle();
    expect(find.text('닉네임을 입력해주세요.'), findsOneWidget);
    expect(submit(tester).onPressed, isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(900, 700),
  ]) {
    testWidgets('키보드 300px, 큰 글자와 화면 $size에서 스크롤 가능', (tester) async {
      await open(tester, size: size, inset: 300, scale: 1.5);
      await fill(tester, 0, '무비러버');
      await fill(tester, 1, 'movie@example.com');
      await fill(tester, 2, 'movie1234');
      await tester.ensureVisible(find.byType(Checkbox));
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('가입하기'));
      await tester.tap(find.text('가입하기'));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpConfirmation), findsOneWidget);
      expect(tester.takeException(), isNull);
      final formWidth = tester.getSize(find.byType(Form)).width;
      expect(
        formWidth,
        lessThanOrEqualTo(size.width >= 700 ? 512 : size.width - 48),
      );
    });
  }

  testWidgets('공통 테마가 있는 실제 앱에서도 회원가입 표시', (tester) async {
    await tester.pumpWidget(const MovieLogApp(home: SignUpScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });
}
