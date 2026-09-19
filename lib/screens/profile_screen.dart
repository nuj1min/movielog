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
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileHeader(),
        SizedBox(height: 32),
        ProfileStats(),
        SizedBox(height: 32),
        FavoriteGenres(),
        SizedBox(height: 40),
        EditProfileButton(),
      ],
    ),
  );
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.imagePath = 'assets/images/profile.png',
  });
  final String? imagePath;
  @override
  Widget build(BuildContext context) {
    const fallback = CircleAvatar(
      radius: 44,
      backgroundColor: AppColors.white,
      child: Icon(Icons.person, size: 48, color: AppColors.violet),
    );
    return Column(
      children: [
        if (imagePath == null)
          fallback
        else
          ClipOval(
            child: Image.asset(
              imagePath!,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              semanticLabel: '프로필 이미지',
              errorBuilder: (context, error, stackTrace) => fallback,
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
          '좋아하는 영화를 기록하고 있어요',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        SvgPicture.asset(
          'assets/icons/movie.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
          semanticsLabel: '영화 아이콘',
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
    ProfileStat('본 영화', '24'),
    ProfileStat('평점', '18'),
    ProfileStat('즐겨찾기', '7'),
  ];
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: stats
        .map(
          (stat) => Expanded(
            child: StatItem(label: stat.label, value: stat.value),
          ),
        )
        .toList(),
  );
}

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
    decoration: BoxDecoration(
      color: AppColors.warmWhite,
      border: Border.all(color: AppColors.violet),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: AppColors.violet),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
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
      Text('선호 장르', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: genres
            .map(
              (genre) => Chip(
                label: Text(genre),
                backgroundColor: AppColors.warmWhite,
                side: const BorderSide(color: AppColors.violet),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
  Widget build(BuildContext context) =>
      ElevatedButton(onPressed: () {}, child: const Text('프로필 수정'));
}
