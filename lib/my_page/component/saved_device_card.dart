import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../er10x/model/er10x_model.dart';

class SavedDeviceCard extends StatefulWidget {
  final Function(Er10xModel) onTapRemove;
  final Function(Er10xModel) onTapEdit;
  final Er10xModel model;

  const SavedDeviceCard({
    super.key,
    required this.onTapRemove,
    required this.onTapEdit,
    required this.model,
  });

  @override
  State<SavedDeviceCard> createState() => _SavedDeviceCardState();
}

class _SavedDeviceCardState extends State<SavedDeviceCard> {
  bool isEditing = false;
  late String originalName;
  late String originalSerial;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController serialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.model.name!;
    serialController.text = widget.model.deviceSerial!;
    originalName = widget.model.name!;
    originalSerial = widget.model.deviceSerial!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(
        decoration: _buildBoxDecoration(),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 5.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildDeviceInfo()),
            SizedBox(
              width: 20.w,
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildInfoRow('장치 ID:', widget.model.deviceId),
        SizedBox(
          width: 300.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('장치 시리얼:', style: cStyle(size: 30.w)),
              SizedBox(width: 21.w),
              if (isEditing)
                Expanded(
                  child: TextField(
                    controller: serialController,
                    style: cStyle(size: 25.w),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: '시리얼 번호',
                    ),
                  ),
                )
              else
                Text(widget.model.deviceSerial!, style: cStyle(size: 30.w)),
            ],
          ),
        ),
        SizedBox(
          width: 300.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('장치 별칭:', style: cStyle(size: 30.sp)),
              SizedBox(width: 40.w),
              if (isEditing)
                Expanded(
                  child: TextField(
                    controller: nameController,
                    style: cStyle(size: 25.sp),
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: '별칭',
                    ),
                  ),
                )
              else
                Text(widget.model.name!, style: cStyle(size: 30.w)),
            ],
          ),
        ),
        // 추가된 시리얼 수정 부분
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        buildButton(
          text: isEditing ? '저장' : '설정 수정',
          color: AppColors.contentColorGreen,
          onTap: () => isEditing ? _saveEdit() : _startEditing(),
        ),
        SizedBox(height: 10.w),
        buildButton(
          text: isEditing ? '취소' : '장치 제거',
          color: isEditing
              ? AppColors.contentColorPink
              : AppColors.contentColorPurple,
          onTap: () =>
              isEditing ? _cancelEdit() : widget.onTapRemove(widget.model),
        ),
      ],
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.pageBackground,
      border: Border.all(
        color: AppColors.itemsBackground,
        width: 4.w,
      ),
      borderRadius: BorderRadius.circular(8.w),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return SizedBox(
      width: 300.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: cStyle(size: 30.sp)),
          const SizedBox(width: 10),
          Text(value, style: cStyle(size: 30.sp)),
        ],
      ),
    );
  }

  Widget buildButton({
    required,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 15.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(text, style: tStyle(size: 25.w)),
        ),
      ),
    );
  }

  void _startEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void _cancelEdit() {
    setState(() {
      nameController.text = originalName;
      isEditing = false;
    });
  }

  void _saveEdit() {
    widget.onTapEdit(Er10xModel(
      deviceId: widget.model.deviceId,
      deviceSerial: serialController.text.trim(),
      name: nameController.text.trim(),
    ));
    setState(() {
      isEditing = false;
    });
  }
}
