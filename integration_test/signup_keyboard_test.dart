import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movielog/features/signup/signup_screen.dart';
import 'package:movielog/movie_log_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Android 실제 키보드가 열린 상태에서 가입 버튼까지 스크롤', (tester) async {
    await tester.pumpWidget(const MovieLogApp(home: SignUpScreen()));
    await tester.pumpAndSettle();
    final password = find.byType(TextFormField).at(2);
    await tester.ensureVisible(password);
    await tester.tap(password);
    final context = tester.element(find.byType(SignUpScreen));
    for (var attempt = 0; attempt < 20; attempt++) {
      await tester.pump(const Duration(milliseconds: 500));
      if (MediaQuery.viewInsetsOf(context).bottom > 0) break;
    }
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    expect(
      keyboardHeight,
      greaterThan(0),
      reason: '소프트 키보드를 실제로 열 수 있는 기기에서 실행하세요.',
    );
    final submit = find.widgetWithText(ElevatedButton, '가입하기');
    await tester.ensureVisible(submit);
    await tester.pumpAndSettle();
    final viewport = MediaQuery.sizeOf(context).height - keyboardHeight;
    expect(tester.getBottomRight(submit).dy, lessThanOrEqualTo(viewport));
    expect(tester.takeException(), isNull);
    // 기기 전체 PNG를 저장할 때만 캡처 대기 시간을 지정합니다.
    const pause = int.fromEnvironment('CAPTURE_PAUSE_SECONDS');
    debugPrint('WEEK2_KEYBOARD_READY: inset=$keyboardHeight');
    if (pause > 0) await Future<void>.delayed(const Duration(seconds: pause));
    FocusScope.of(context).unfocus();
    await tester.pumpAndSettle();
  });
}
