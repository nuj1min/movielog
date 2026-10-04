import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movielog/features/rating/rating_screen.dart';
import 'package:movielog/movie_log_app.dart';

void main() {
  testWidgets('별 선택으로 저장 활성화, 저장 후 재선택과 초기화', (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MovieLogApp(home: RatingScreen()));
    await tester.pumpAndSettle();
    final save = find.widgetWithText(ElevatedButton, '평점 저장');
    expect(tester.widget<ElevatedButton>(save).onPressed, isNull);
    final bar = tester.getRect(find.byType(RatingBar));
    // 5번째 별의 왼쪽 절반을 실제로 탭하여 4.5점을 선택합니다.
    await tester.tapAt(Offset(bar.left + 4 * 48 + 14, bar.center.dy));
    await tester.pumpAndSettle();
    expect(find.text('4.5 / 5.0'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(save).onPressed, isNotNull);
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(find.text('저장한 평점: 4.5점'), findsOneWidget);
    await tester.ensureVisible(find.text('다시 선택하기'));
    await tester.tap(find.text('다시 선택하기'));
    await tester.pumpAndSettle();
    expect(tester.widget<ElevatedButton>(save).onPressed, isNull);
    expect(find.text('저장한 평점: 4.5점'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
