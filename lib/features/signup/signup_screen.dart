import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/movie_log_text_form_field.dart';
import 'signup_validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nickname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _nicknameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _agreed = false;
  bool _obscurePassword = true;
  bool _showTermsError = false;
  bool _submitted = false;

  bool get _canSubmit =>
      SignUpValidators.nickname(_nickname.text) == null &&
      SignUpValidators.email(_email.text) == null &&
      SignUpValidators.password(_password.text) == null &&
      _agreed;

  @override
  void initState() {
    super.initState();
    // clear() 등 코드로 입력을 바꿔도 버튼 상태를 다시 계산합니다.
    for (final controller in [_nickname, _email, _password]) {
      controller.addListener(_onInputChanged);
    }
  }

  void _onInputChanged() => setState(() => _submitted = false);

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _showTermsError = !_agreed);
    if (!valid || !_agreed) return;
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);
  }

  @override
  void dispose() {
    for (final controller in [_nickname, _email, _password]) {
      controller.removeListener(_onInputChanged);
      controller.dispose();
    }
    _nicknameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CommonAppBar(title: '회원가입'),
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth >= 700 ? 560 : double.infinity,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SignUpHeader(),
                    const SizedBox(height: 32),
                    MovieLogTextFormField(
                      label: '닉네임',
                      hint: '두 글자 이상 입력해주세요',
                      controller: _nickname,
                      focusNode: _nicknameFocus,
                      validator: SignUpValidators.nickname,
                      icon: Icons.person_outline,
                      onSubmitted: (_) => _emailFocus.requestFocus(),
                      suffixIcon: _nickname.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: '닉네임 지우기',
                              onPressed: () {
                                _nickname.clear();
                                _nicknameFocus.requestFocus();
                              },
                              icon: const Icon(Icons.close, size: 20),
                            ),
                    ),
                    const SizedBox(height: 20),
                    MovieLogTextFormField(
                      label: '이메일',
                      hint: 'movielover@example.com',
                      controller: _email,
                      focusNode: _emailFocus,
                      validator: SignUpValidators.email,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (_) => _passwordFocus.requestFocus(),
                    ),
                    const SizedBox(height: 20),
                    MovieLogTextFormField(
                      label: '비밀번호',
                      hint: '8자 이상 입력해주세요',
                      controller: _password,
                      focusNode: _passwordFocus,
                      validator: SignUpValidators.password,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: _obscurePassword,
                      onSubmitted: (_) => _submit(),
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword ? '비밀번호 표시' : '비밀번호 숨기기',
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TermsAgreement(
                      value: _agreed,
                      showError: _showTermsError,
                      onChanged: (value) => setState(() {
                        _agreed = value;
                        _submitted = false;
                        if (value) _showTermsError = false;
                      }),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _canSubmit ? _submit : null,
                      child: const Text('가입하기'),
                    ),
                    const SizedBox(height: 16),
                    if (_submitted)
                      const SignUpConfirmation()
                    else
                      Text(
                        '입력한 정보는 전송되지 않는 회원가입 실습입니다.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '나만의 영화 기록을\n시작해보세요',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 12),
      Text(
        'MovieLog와 함께 영화의 순간을 모아보세요.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ],
  );
}

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({
    super.key,
    required this.value,
    required this.showError,
    required this.onChanged,
  });
  final bool value;
  final bool showError;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: value,
        onChanged: (checked) => onChanged(checked ?? false),
        title: const Text('이용약관 및 개인정보 처리방침에 동의합니다. (필수)'),
      ),
      if (showError)
        Text(
          '필수 약관에 동의해주세요.',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
    ],
  );
}

class SignUpConfirmation extends StatelessWidget {
  const SignUpConfirmation({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.paleViolet,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle_outline, color: AppColors.violet),
          SizedBox(width: 12),
          Expanded(child: Text('입력값 검증 완료!\n실제 계정은 생성되지 않았습니다.')),
        ],
      ),
    ),
  );
}
