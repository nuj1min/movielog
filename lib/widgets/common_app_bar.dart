import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.centerTitle = false,
    this.titleStyle,
  });
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool centerTitle;
  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(
      title,
      style:
          titleStyle ??
          Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: AppColors.violet),
    ),
    centerTitle: centerTitle,
    leading: onBack == null
        ? null
        : IconButton(
            onPressed: onBack,
            tooltip: '뒤로가기',
            icon: const Icon(Icons.arrow_back),
          ),
    actions: actions,
  );
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
