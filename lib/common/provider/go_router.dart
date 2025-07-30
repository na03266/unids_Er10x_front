import 'dart:async';

import 'package:er10x/common/component/exit_dialog.dart';
import 'package:er10x/common/provider/go_router_refresh_stream.dart';
import 'package:er10x/common/util/page_transition_action.dart';
import 'package:er10x/common/view/root_tab.dart';
import 'package:er10x/common/view/splash_screen.dart';
import 'package:er10x/my_page/view/bluetooth_setting_screen.dart';
import 'package:er10x/my_page/view/er10x_setting_screen.dart';
import 'package:er10x/my_page/view/my_page_screen.dart';
import 'package:er10x/setting/sensor_offset/device_offset_screen.dart';
import 'package:er10x/setting/view/device_setting_screen.dart';
import 'package:er10x/statistics/view/statistic_screen.dart';
import 'package:er10x/status/view/status_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../setting/sensor_info/model/sensor_info_model.dart';
import '../../setting/sensor_info/view/info_edit_screen.dart';
import '../../setting/sensor_info/view/sensor_info_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final StreamController<void> streamController = StreamController<void>();

  ref.onDispose(() {
    streamController.close(); // StreamController 해제
  });

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(streamController.stream),
    routes: [
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        pageBuilder: (context, state) =>
            buildCupertinoPage(const SplashScreen()),
      ),
      ShellRoute(
        builder: (context, state, child) => RootTab(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) =>
                buildCupertinoPage(const StatusScreen()),
            onExit: onExit,
            routes: [
              GoRoute(
                path: '/${StatisticScreen.routeName}',
                name: StatisticScreen.routeName,
                onExit: (context, state) {
                  return true; // 경로를 나가는 것을 허용
                },
                pageBuilder: (context, state) {
                  final sensorInfo = state.extra as SensorInfoModel;

                  return buildCupertinoPage(
                    StatisticScreen(isShowingMainData: true, sensorInfo: sensorInfo,),
                  );
                },
              ),
              GoRoute(
                path: '/${SettingScreen.routeName}',
                name: SettingScreen.routeName,
                onExit: (context, state) {
                  return true; // 경로를 나가는 것을 허용
                },
                pageBuilder: (context, state) {
                  return buildCupertinoPage(
                    const SettingScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/${DeviceOffsetScreen.routeName}',
                    name: DeviceOffsetScreen.routeName,
                    onExit: (context, state) {
                      return true; // 경로를 나가는 것을 허용
                    },
                    pageBuilder: (context, state) {
                      return buildCupertinoPage(
                        const DeviceOffsetScreen(),
                      );
                    },
                  ),
                  GoRoute(
                    path: '/${SensorInfoScreen.routeName}',
                    name: SensorInfoScreen.routeName,
                    onExit: (context, state) {
                      return true; // 경로를 나가는 것을 허용
                    },
                    pageBuilder: (context, state) {
                      return buildCupertinoPage(
                        const SensorInfoScreen(),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: '/${InfoEditScreen.routeName}',
                        name: InfoEditScreen.routeName,
                        onExit: (context, state) {
                          return true; // 경로를 나가는 것을 허용
                        },
                        pageBuilder: (context, state) {
                          final info = state.extra as SensorInfoModel?;
                          return buildCupertinoPage(
                            InfoEditScreen(info: info),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: 'setting',
                onExit: (context, state) {
                  return true; // 경로를 나가는 것을 허용
                },
                pageBuilder: (context, state) {
                  return buildCupertinoPage(
                    const MyPageScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/er10x',
                    name: 'er10x',
                    onExit: (context, state) {
                      return true; // 경로를 나가는 것을 허용
                    },
                    pageBuilder: (context, state) {
                      return buildCupertinoPage(
                        const Er10XSettingScreen(),
                      );
                    },
                  ),
                  GoRoute(
                    path: '/bluetooth',
                    name: 'bluetooth',
                    onExit: (context, state) {
                      return true; // 경로를 나가는 것을 허용
                    },
                    pageBuilder: (context, state) {
                      return buildCupertinoPage(
                        const BluetoothSettingScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
