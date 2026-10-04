import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common_app_bar.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0;
  double? _savedRating;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CommonAppBar(title: '나의 영화 평점'),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const RatingHeader(),
                const SizedBox(height: 32),
                Center(
                  child: Semantics(
                    label: '영화 평점',
                    value: '${_rating.toStringAsFixed(1)}점, 최대 5점',
                    increasedValue:
                        '${(_rating + 0.5).clamp(0, 5).toStringAsFixed(1)}점',
                    decreasedValue:
                        '${(_rating - 0.5).clamp(0, 5).toStringAsFixed(1)}점',
                    onIncrease: () =>
                        setState(() => _rating = (_rating + 0.5).clamp(0, 5)),
                    onDecrease: () =>
                        setState(() => _rating = (_rating - 0.5).clamp(0, 5)),
                    child: RatingBar.builder(
                      initialRating: _rating,
                      minRating: 0,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      glow: false,
                      unratedColor: AppColors.paleViolet,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: AppColors.violet,
                      ),
                      onRatingUpdate: (value) =>
                          setState(() => _rating = value),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _rating == 0
                      ? '별을 눌러 평점을 선택해주세요'
                      : '${_rating.toStringAsFixed(1)} / 5.0',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _rating > 0
                      ? () => setState(() => _savedRating = _rating)
                      : null,
                  child: const Text('평점 저장'),
                ),
                TextButton(
                  onPressed: _rating > 0
                      ? () => setState(() {
                          _rating = 0;
                          _savedRating = null;
                        })
                      : null,
                  child: const Text('다시 선택하기'),
                ),
                if (_savedRating != null)
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      '저장한 평점: ${_savedRating!.toStringAsFixed(1)}점',
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  '평점은 이 화면에만 저장됩니다.\n화면을 다시 실행하면 초기화됩니다.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class RatingHeader extends StatelessWidget {
  const RatingHeader({super.key});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Icon(Icons.movie_outlined, size: 64, color: AppColors.violet),
      const SizedBox(height: 24),
      Text('이 영화, 어떠셨나요?', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 12),
      Text(
        '0.5점 단위로 나만의 평점을 남겨보세요.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ],
  );
}
