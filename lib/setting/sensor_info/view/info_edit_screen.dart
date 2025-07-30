import 'package:er10x/common/component/custom_text_field.dart';
import 'package:er10x/er10x/provider/er10x_provider.dart';
import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/setting/sensor_info/provider/sensor_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/const/app_colors.dart';

class InfoEditScreen extends ConsumerStatefulWidget {
  final SensorInfoModel? info;
  static const routeName = 'info-edit';

  const InfoEditScreen({super.key, required this.info});

  @override
  ConsumerState<InfoEditScreen> createState() => _InfoEditScreenState();
}

class _InfoEditScreenState extends ConsumerState<InfoEditScreen> {
  late SensorInfoModel updatedInfo;
  final _formKey = GlobalKey<FormState>();
  final fontStyle = TextStyle(
      fontSize: 35.sp, fontWeight: FontWeight.bold, color: AppColors.white);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatedInfo = widget.info ?? SensorInfoModel();
    updatedInfo.deviceId = ref.read(er10xProvider)?.deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: 250.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '센서 정보',
                  style: fontStyle.copyWith(fontSize: 50.sp),
                ),
                _buildRow(
                  '센서 ID',
                  updatedInfo.sensorId ?? '',
                  (val) => updatedInfo.sensorId = val!,
                ),
                _buildRow(
                  '국문 명칭',
                  updatedInfo.krName ?? '',
                  (val) => updatedInfo.krName = val!,
                ),
                _buildRow(
                  '영문 명칭',
                  updatedInfo.name ?? '',
                  (val) => updatedInfo.name = val!,
                ),
                _buildRow(
                  '최대값',
                  integerOnly: true,
                  updatedInfo.maximum != null? updatedInfo.maximum.toString() : '100',
                  (val) => updatedInfo.maximum = double.parse(val!),
                ),
                _buildRow(
                  '최소값',
                  integerOnly: true,
                  updatedInfo.minimum != null? updatedInfo.minimum.toString() : '0',
                  (val) => updatedInfo.minimum = double.parse(val!),
                ),
                _buildRow(
                  '단위',
                  updatedInfo.unit ?? '',
                  (val) => updatedInfo.unit = val!,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _deleteAndCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red.withAlpha(120),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          widget.info == null ? '취소' : '삭제',
                          style: const TextStyle(
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.itemsBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          widget.info == null ? '등록' : '수정',
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildRow(String title, String data, Function(String?)? onSaved,
      {bool integerOnly = false}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$title : ',
            style: fontStyle,
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            child: CustomTextField(
              initialData: data,
              hintText: title,
              onSaved: onSaved,
              validator: _requiredValidator,
              integerOnly: integerOnly,
            ),
          ),
        ),
      ],
    );
  }

  _saveForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();

    bool status = false;

    if (updatedInfo.id != null) {
      status = await ref
          .read(sensorInfoProvider.notifier)
          .patchSensorInfo(updatedInfo.id!, updatedInfo);
      if (mounted && status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${updatedInfo.sensorId} 센서가 수정 되었습니다.')),
        );
      }
    } else {
      status = await ref
          .read(sensorInfoProvider.notifier)
          .postSensorInfo(updatedInfo);

      if (mounted && status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${updatedInfo.sensorId} 센서가 등록 되었습니다.')),
        );
      }
    }

    if (mounted) {
      context.pop();
    }
  }

  _deleteAndCancel() async {
    bool status = false;
    if (updatedInfo.id != null) {
      status = await ref
          .read(sensorInfoProvider.notifier)
          .deleteSensorInfo(updatedInfo.id!);
      if (mounted && status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${updatedInfo.sensorId} 센서가 제거 되었습니다.')),
        );
      }
    }
    if (mounted) {
      context.pop();
    }
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '필수 입력 항목입니다.';
    }
    return null;
  }
}
