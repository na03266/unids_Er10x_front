import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/common/layout/default_layout.dart';
import 'package:er10x/gen/assets.gen.dart';
import 'package:er10x/setting/view/device_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RootTab extends StatefulWidget {
  final Widget child;

  const RootTab({
    super.key,
    required this.child,
  });

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int unreadCount = 2;

  int getIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    debugPrint(location);

    if (location == '/statistics') {
      return 1;
    } else if (location == '/device-setting') {
      return 2;
    } else if (location == '/setting') {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = getIndex(context);

    return DefaultLayout(
      appbarColor: AppColors.sub1,
      showDevice: currentIndex != 3,
      bottomNavigationBar: Container(
        height: 40.h, // 높이 조절
        color: AppColors.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              itemIndex: 0,
              currentIndex: currentIndex,
              label: '상태',
              route: '/',
              icon: Assets.tabIcon.status,
              iconSize: 45.sp,
            ),
            _buildNavItem(
              context: context,
              itemIndex: 2,
              currentIndex: currentIndex,
              label: '장치 상세 관리',
              route: '/${SettingScreen.routeName}',
              icon: Assets.tabIcon.device,
              iconSize: 50.sp,
            ),
            _buildNavItem(
              context: context,
              itemIndex: 3,
              currentIndex: currentIndex,
              label: '개인 설정',
              route: '/setting',
              icon: Assets.tabIcon.myPage,
              iconSize: 45.sp,
            ),
          ],
        ),
      ),
      child: widget.child,
    );
  }

  Widget _buildNavItem({
    required String icon,
    required BuildContext context,
    required int itemIndex,
    required int currentIndex,
    required String label,
    required double iconSize,
    required String route,
  }) {
    final isSelected = currentIndex == itemIndex;

    return Expanded(
      child: InkWell(
        onTap: () {
          context.go(route);
        },
        splashColor: Colors.transparent, // 스플래시 색상 제거
        highlightColor: Colors.transparent, // 하이라이트 색상 제거
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: iconSize,
              width: iconSize,
              color: isSelected ? LIGHT_GREEN : Colors.white,
            ),
            SizedBox(height: 1.h), // 아이콘과 텍스트 사이 간격
            Text(
              label,
              style: cStyle(
                size: 25.sp,
                color: isSelected ? LIGHT_GREEN : Colors.white,
                isBold: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
