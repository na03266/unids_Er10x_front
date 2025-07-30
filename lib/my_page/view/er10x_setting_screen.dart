import 'package:er10x/common/component/custom_text_field.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/er10x/provider/er10x_list_provider.dart';
import 'package:er10x/my_page/component/saved_device_card.dart';
import 'package:er10x/my_page/util/er10x_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/text_style.dart';
import '../../er10x/model/er10x_model.dart';

class Er10XSettingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'er10x';

  const Er10XSettingScreen({super.key});

  @override
  ConsumerState<Er10XSettingScreen> createState() => _Er10XSettingScreenState();
}

class _Er10XSettingScreenState extends ConsumerState<Er10XSettingScreen> {
  final FocusNode idFocus = FocusNode();
  final FocusNode serialFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Er10xModel newEr10x = const Er10xModel(
    deviceId: 'deviceId',
    deviceSerial: 'deviceSerial',
    name: 'name',
  );

  @override
  Widget build(BuildContext context) {
    final er10xList = ref.watch(er10xListProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        context.go('/');
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.itemsBackground,
          border: Border.symmetric(
            vertical: BorderSide(
              color: AppColors.itemsBackground,
              width: 4.w,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildForm(),
              SizedBox(height: 8.h),
              _buildDeviceList(er10xList),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        border: Border.all(
          color: AppColors.itemsBackground,
          width: 4.w,
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _buildTextField(
              title: '장치 ID',
              focusNode: idFocus,
              nextFocusNode: serialFocus,
              onSaved: onSavedDeviceId,
            ),
            SizedBox(height: 4.h),
            _buildTextField(
              title: '장치 시리얼',
              focusNode: serialFocus,
              nextFocusNode: nameFocus,
              onSaved: onSavedDeviceSerial,
            ),
            SizedBox(height: 4.h),
            _buildTextField(
              title: '장치 별칭',
              focusNode: nameFocus,
              onSaved: onSavedDeviceName,
            ),
            SizedBox(height: 6.h),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    required Function(String?) onSaved,
  }) {
    return CustomTextField(
      onSaved: onSaved,
      validator: validateNotEmpty,
      initialData: title,
      integerOnly: false,
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
      hintStyle: cStyle(size: 35.sp).copyWith(color: Colors.grey),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _addDevice,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.contentColorGreen,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Center(
          child: Text(
            '추가하기',
            style: tStyle(size: 35.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceList(List<Er10xModel> er10xList) {
    return Column(
      children: [
        Text(
          '등록된 장치 목록',
          style: tStyle(size: 35.w),
        ),
        SizedBox(height: 4.h),
        ...er10xList.map((device) {
          print('tlqkf');
          return SavedDeviceCard(
            onTapRemove: removeFromDeviceId,
            onTapEdit: editFromDeviceId,
            model: device,
          );
        }),
      ],
    );
  }

  String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '값을 입력해주세요.';
    }
    return null;
  }

  void onSavedDeviceId(String? value) {
    if (value != null && value.isNotEmpty) {
      newEr10x = newEr10x.copyWith(deviceId: value);
    }
  }

  void onSavedDeviceSerial(String? value) {
    if (value != null && value.isNotEmpty) {
      newEr10x = newEr10x.copyWith(deviceSerial: value);
    }
  }

  void onSavedDeviceName(String? value) {
    if (value != null && value.isNotEmpty) {
      newEr10x = newEr10x.copyWith(name: value);
    }
  }

  void _addDevice() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save(); // 폼 데이터 저장

      final isSaved =
          await ref.read(er10xListProvider.notifier).addAndSaveEr10x(newEr10x);

      if (!isSaved) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('이미 존재하는 장치입니다.')),
          );
        }
        return; // 중복이 발견되면 종료
      }

      setState(() {
        newEr10x = const Er10xModel(
          deviceId: '장치 ID',
          deviceSerial: '장치 시리얼',
          name: '장치 별칭',
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('장치가 추가되었습니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('입력 값을 확인해주세요.')),
      );
    }
  }

  void removeFromDeviceId(Er10xModel item) async {
    final isRemoved =
        await ref.read(er10xListProvider.notifier).removeAndSaveEr10x(item);
    if (!isRemoved) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미 삭제 된 장비입니다.')),
        );
      }
      return;
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('장치가 제거되었습니다.')),
      );
    }
  }

  void editFromDeviceId(Er10xModel item) async {
    await ref.read(er10xListProvider.notifier).editAndSaveEr10x(item);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('장치가 업데이트 되었습니다.')),
      );
    }
  }
}
