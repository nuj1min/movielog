import 'package:flutter/material.dart';

/// 버튼 활성화와 Form 최종 검증에서 같은 규칙을 사용합니다.
abstract final class SignUpValidators {
  static String? nickname(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '닉네임을 입력해주세요.';
    if (text.characters.length < 2) return '닉네임은 두 글자 이상 입력해주세요.';
    return null;
  }

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '이메일을 입력해주세요.';
    if (!RegExp(r'^[^\s@]+@[^\s@.]+(?:\.[^\s@.]+)+$').hasMatch(text)) {
      return '올바른 이메일 형식을 입력해주세요.';
    }
    return null;
  }

  static String? password(String? value) {
    final text = value ?? '';
    if (text.trim().isEmpty) return '비밀번호를 입력해주세요.';
    if (text.length < 8) return '비밀번호는 8자 이상 입력해주세요.';
    return null;
  }
}
