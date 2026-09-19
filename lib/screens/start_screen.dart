import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, this.useLogo = true});
  // 기본 Icon과 로고를 비교하는 캡처용 설정입니다.
  final bool useLogo;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (constraints.maxHeight - 64).clamp(0, double.infinity),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'FLUTTER 1주차',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 64),
                    if (useLogo)
                      SvgPicture.asset(
                        'assets/logos/movielog_logo.svg',
                        width: 72,
                        height: 72,
                        semanticsLabel: 'MovieLog 로고',
                      )
                    else
                      const Icon(
                        Icons.movie_outlined,
                        size: 72,
                        color: AppColors.violet,
                      ),
                    const SizedBox(height: 32),
                    Text(
                      '영화의 순간을\n기록하세요',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '보고 싶은 영화부터 나만의 평점까지\n한곳에서 관리해요',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('시작하기'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
