import 'package:flutter/material.dart';

// 앱이 시작되는 곳
void main() {
  runApp(const MyApp());
}

// 앱의 기본 설정
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //디버그 모드에서 우측 상단에 표시되는 배너 표시 여부
      debugShowCheckedModeBanner: false,
      //앱을 나타내는 제목
      title: 'MovieLog',
      //앱 전체의 색상, 폰트, 버튼 스타일의 Theme 설정
      theme: ThemeData(useMaterial3: true),
      // 앱이 시작될 때 표시되는 화면
      home: const StartScreen(),
    );
  }
}

// 우리가 만들 시작 화면
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold는 화면의 기본 틀
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),

      // 상태 표시줄이나 하단 홈 바에 내용이 겹치지 않게 해줌
      body: SafeArea(
        // 화면 가장자리에 여백을 주는 위젯
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),

          // children 안의 요소를 위에서 아래로 배치해.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'FLUTTER 0주차',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  color: Color(0xFF504B5A),
                ),
              ),

              const SizedBox(height: 56),

              const Icon(
                Icons.movie_outlined,
                size: 72,
                color: Color(0xFF6950A1),
              ),

              const SizedBox(height: 56),

              const Text(
                '영화의 순간을\n기록하세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  height: 1.2,
                  color: Color(0xFF1D1D1B),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                '보고 싶은 영화부터 나만의 평점까지\n한곳에서 관리해요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Color(0xFF504B5A),
                ),
              ),

              // 남는 공간을 차지해서 버튼을 아래로 밀어줘.
              const Spacer(),

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // 아직 다음 화면이 없으니 메시지만 표시해.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('시작하기 버튼을 눌렀어요!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF50368B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text('시작하기', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
