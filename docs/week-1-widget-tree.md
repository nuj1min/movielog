# 1주차 Widget Tree

```text
main() → runApp() → MovieLogApp
└─ MaterialApp (AppTheme.light, home)
   ├─ StartScreen (기본 home)
   │  └─ Scaffold
   │     └─ SafeArea
   │        └─ LayoutBuilder → SingleChildScrollView → ConstrainedBox
   │           └─ Column (spaceBetween / stretch)
   │              ├─ Column
   │              │  ├─ Text: FLUTTER 1주차
   │              │  ├─ SvgPicture.asset: 로고 (비교용: Icon)
   │              │  ├─ Text: 영화의 순간을 기록하세요
   │              │  └─ Text: 설명
   │              └─ Padding → ElevatedButton: 시작하기
   └─ ProfileScreen (home을 바꿔 별도 확인)
      └─ Scaffold
         ├─ CommonAppBar → AppBar → Text: 내 프로필
         └─ SafeArea → ProfileBody
            └─ SingleChildScrollView → Column (stretch)
               ├─ ProfileHeader → Column
               │  ├─ ClipOval → Image.asset (없으면 CircleAvatar → Icon)
               │  ├─ Text: 무비러버
               │  ├─ Text: 소개
               │  └─ SvgPicture.asset: 영화 아이콘
               ├─ ProfileStats → Row (spaceBetween / start)
               │  └─ Expanded → StatItem × 3
               │     └─ Container → Column → Text: 값, Text: 항목
               ├─ FavoriteGenres → Column (start)
               │  ├─ Text: 선호 장르
               │  └─ Wrap → Chip × 3
               └─ EditProfileButton → ElevatedButton
```

두 화면이 동시에 home에 들어가는 것은 아닙니다. 시작 화면과 프로필 화면 중 하나를 선택해서 실행합니다.

- 선언형 UI: `build()`가 현재 값에 맞는 Widget 구성을 반환합니다.
- MaterialApp: 테마·앱 제목·첫 화면 설정. Scaffold: 화면의 appBar/body 영역. AppBar: 상단 제목·버튼.
- Row 주축은 가로, Column 주축은 세로입니다. 교차축은 각각 반대입니다.
- Padding은 안쪽 여백이고, StatItem의 margin은 카드 바깥 여백입니다.
- Expanded로 통계 카드 너비를 나누고 Wrap으로 장르 줄바꿈을 허용합니다.
- Theme.of(context)는 해당 위치에서 가장 가까운 상위 Theme를 찾습니다.
- ElevatedButton은 주요 동작을 강조합니다. TextButton은 보조 동작에 적합합니다.
- PNG는 비트맵 이미지, SVG는 크기를 바꾸어도 선명한 로고·아이콘에 사용합니다.
