import 'package:er10x/common/component/custom_dropdown.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/er10x/model/er10x_model.dart';
import 'package:er10x/er10x/provider/er10x_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../er10x/provider/er10x_list_provider.dart';

class DefaultLayout extends ConsumerStatefulWidget {
  final Color? backgroundColor;
  final Widget child;
  final bool showLogo;
  final bool showDevice;
  final Widget? bottomNavigationBar;
  final bool topCircleEnable;
  final Color appbarColor;

  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor,
    this.showLogo = true,
    this.showDevice = true,
    this.bottomNavigationBar,
    this.topCircleEnable = true,
    this.appbarColor = AppColors.sub1,
  });

  @override
  ConsumerState<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends ConsumerState<DefaultLayout> {
  @override
  void initState() {
    super.initState();
    ref.read(er10xListProvider.notifier).loadEr10xList();
  }

  @override
  Widget build(BuildContext context) {
    final er10xList = ref.watch(er10xListProvider);
    final er10x = ref.watch(er10xProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.backgroundColor ?? AppColors.sub1,
        appBar: widget.showLogo
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: renderAppBar(
                  context: context,
                  appbarColor: widget.appbarColor,
                  onTapNotification: () {
                    context.pushNamed('notification');
                  },
                ),
              )
            : null,
        body: Column(

          children: [
            if (er10xList.isNotEmpty && widget.showDevice)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w,
                    vertical: 2.h),
                child: Container(
                  height: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomDropDown<Er10xModel>(
                      items: er10xList,
                      itemAsString: (item) => item.name ?? item.deviceId,
                      onChanged: (item) {
                        ref.read(er10xProvider.notifier).set(item!);
                      },
                      selectedItem: er10x,
                    ),
                  ),
                ),
              ),
            Expanded(child: widget.child),
          ],
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }

  AppBar renderAppBar({
    required BuildContext context,
    required Color appbarColor,
    required Function() onTapNotification,
  }) {
    bool currentPath = GoRouter.of(context).state.fullPath == '/';

    return AppBar(
      toolbarHeight: 200.h,
      backgroundColor: appbarColor,
      surfaceTintColor: appbarColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 상태바 배경색
        statusBarIconBrightness: Brightness.dark, // 상태바 아이콘 색상 (어두운색)
        statusBarBrightness: Brightness.light, // iOS 상태바 스타일
      ),
      elevation: 0,
      flexibleSpace: null,
      title: Padding(
        padding: EdgeInsets.all(10.dm),
        child: Text(
          'ER10X',
          style: tStyle(size: 40.sp),
        ),
      ),
      centerTitle: false,
      actions: [
        if (!currentPath)
          IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                height: 60.h,
                width: 60.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
