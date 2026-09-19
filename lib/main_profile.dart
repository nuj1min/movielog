import 'package:flutter/material.dart';

import 'movie_log_app.dart';
import 'screens/profile_screen.dart';

// home만 바꾸어 확인합니다. 라우팅은 연결하지 않습니다.
void main() => runApp(const MovieLogApp(home: ProfileScreen()));
