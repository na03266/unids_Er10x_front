import 'package:er10x/setting/sensor_info/component/sensor_info_card.dart';
import 'package:er10x/setting/sensor_info/view/info_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/const/app_colors.dart';
import '../provider/sensor_info_provider.dart';

class SensorInfoScreen extends ConsumerWidget {
  static const routeName = 'sensor_info';

  const SensorInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorInfo = ref.watch(sensorInfoProvider);
    return Scaffold(
      backgroundColor: AppColors.sub1,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            InfoEditScreen.routeName,
          );
        },
        backgroundColor: AppColors.contentColorGreen,
        foregroundColor: AppColors.white,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(sensorInfoProvider.notifier).updateSensorInfoList();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...sensorInfo.map(
                (e) => sensorInfoCard(
                  onPressed: () {
                    context.pushNamed(InfoEditScreen.routeName, extra: e);
                  },
                  sensorInfo: e,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
