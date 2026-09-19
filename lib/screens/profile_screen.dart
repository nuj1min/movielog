import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../widgets/common_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    appBar: CommonAppBar(title: '내 프로필'),
    body: SafeArea(child: ProfileBody()),
  );
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});
  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 32, 16, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileHeader(),
        SizedBox(height: 24),
        Center(child: EditProfileButton()),
        SizedBox(height: 32),
        ProfileStats(),
        SizedBox(height: 32),
        FavoriteGenres(),
      ],
    ),
  );
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.imagePath = 'assets/images/profile/profile_movielog.jpg',
  });
  final String? imagePath;
  @override
  Widget build(BuildContext context) {
    const fallback = CircleAvatar(
      radius: 62,
      backgroundColor: AppColors.white,
      child: Icon(Icons.person, size: 48, color: AppColors.violet),
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: AppColors.paleViolet,
            shape: BoxShape.circle,
          ),
          child: imagePath == null
              ? fallback
              : ClipOval(
                  child: Image.asset(
                    imagePath!,
                    width: 124,
                    height: 124,
                    fit: BoxFit.cover,
                    semanticLabel: '프로필 이미지',
                    errorBuilder: (context, error, stackTrace) => fallback,
                  ),
                ),
        ),
        const SizedBox(height: 16),
        Text(
          '무비러버',
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          '매주 주말엔 영화관으로 출근하는 프로 관람객. 좋은 영화를 보고 기록하는 것을 좋아합니다.',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.secondaryText),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ProfileStat {
  const ProfileStat(this.label, this.value);
  final String label;
  final String value;
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});
  static const stats = [
    ProfileStat('본 영화', '342'),
    ProfileStat('평점', '4.2'),
    ProfileStat('즐겨찾기', '58'),
  ];
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: stats
        .asMap()
        .entries
        .map(
          (entry) => Expanded(
            child: StatItem(
              label: entry.value.label,
              value: entry.value.value,
              rightMargin: entry.key == stats.length - 1 ? 0 : 8,
            ),
          ),
        )
        .toList(),
  );
}

class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.label,
    required this.value,
    this.rightMargin = 0,
  });
  final String label;
  final String value;
  final double rightMargin;
  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(right: rightMargin),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
    decoration: BoxDecoration(
      color: AppColors.cardSurface,
      border: Border.all(color: AppColors.paleViolet),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label == '본 영화') ...[
              SvgPicture.asset(
                'assets/icons/movie.svg',
                width: 12,
                height: 12,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
                semanticsLabel: '영화 아이콘',
              ),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: AppColors.deepViolet, fontSize: 22),
        ),
      ],
    ),
  );
}

class FavoriteGenres extends StatelessWidget {
  const FavoriteGenres({super.key});
  static const genres = ['드라마', 'SF', '애니메이션'];
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('선호하는 장르', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: genres
            .map(
              (genre) => Chip(
                label: Text(
                  genre,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.deepViolet,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                backgroundColor: AppColors.paleViolet,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () {},
    style: TextButton.styleFrom(
      minimumSize: const Size(128, 42),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      side: const BorderSide(color: AppColors.violet),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: const Text('프로필 수정'),
  );
}
