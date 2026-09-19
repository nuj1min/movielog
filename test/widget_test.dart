import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movielog/movie_log_app.dart';
import 'package:movielog/screens/profile_screen.dart';
import 'package:movielog/screens/start_screen.dart';

void main() {
  for (final size in [const Size(390, 884), const Size(320, 568)]) {
    testWidgets('시작/프로필 화면의 에셋과 배치 확인: $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MovieLogApp());
      await tester.pumpAndSettle();
      expect(find.text('FLUTTER 1주차'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('시작하기'));
      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(StartScreen), findsOneWidget);
      await tester.pumpWidget(const MovieLogApp(home: ProfileScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(StatItem), findsNWidgets(3));
      expect(find.byType(Chip), findsNWidgets(3));
      expect(find.text('무비러버'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('프로필 수정'));
      await tester.tap(find.text('프로필 수정'));
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('프로필 이미지가 없으면 기본 아이콘 표시', (tester) async {
    await tester.pumpWidget(
      const MovieLogApp(home: Scaffold(body: ProfileHeader(imagePath: null))),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
