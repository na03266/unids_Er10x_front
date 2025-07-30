import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/common/layout/default_layout.dart';
import 'package:er10x/common/mqtt/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // deleteToken();
    _initialize();
  }

  void _initialize() async {
    final mqttRepository = ref.read(mqttRepositoryProvider);

    try {
      await mqttRepository.connect(
        username: 'admin',
        password: '12345678',
        clientId: 'flutter_client',
      );
      Future.microtask(() => context.go('/'));
    } catch (e) {
      Future.microtask(() => context.go('/'));
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      showLogo: false,
      topCircleEnable: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ER10X',
            style: tStyle(size:  60.w),
          ),
          SizedBox(height:  40.w),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
