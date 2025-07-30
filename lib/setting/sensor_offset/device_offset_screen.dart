import 'package:er10x/common/bluetooth/bluetooth.dart';
import 'package:er10x/common/bluetooth/model/default_model.dart';
import 'package:er10x/common/component/custom_text_field.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/device_setting/component/custom_container.dart';
import 'package:er10x/device_setting/model/device_setting_model.dart';
import 'package:er10x/device_setting/provider/device_setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DeviceOffsetScreen extends ConsumerStatefulWidget {
  static String get routeName => 'device-offset';
  const DeviceOffsetScreen({super.key});

  @override
  ConsumerState<DeviceOffsetScreen> createState() =>
      _DeviceOffsetScreenState();
}

class _DeviceOffsetScreenState extends ConsumerState<DeviceOffsetScreen> {
  final ScrollController _scrollController = ScrollController();
  Map<String, TextEditingController> textControllers = {};
  int extended = 0;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final krName = SettingKeys.values.asMap().map(
          (key, value) => MapEntry(value.name, value.krName),
        );
    textControllers = krName.map(
      (key, _) => MapEntry(key, TextEditingController()),
    );
  }

  @override
  void dispose() {
    for (final controller in textControllers.values) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqttState = ref.watch(deviceSettingProvider);
    final bluetoothState = ref.watch(bluetoothProvider);
    final IDefaultModel? bluetoothData = bluetoothState.offsetData;

    // final connectedBluetoothDevice =
    //     bluetoothState.connectedDevice?.platformName;

    final connectedState = bluetoothState.isConnected == true;
    //&&        selectedEr10xDeviceId == connectedBluetoothDevice;

    final DeviceSettingModel? ds =
        connectedState ? bluetoothData as DeviceSettingModel : mqttState.data;

    if (extended == 0 && ds != null) {
      extended += ds.extend.length;
      _initializeExtendControllers(ds);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) context.go('/');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(deviceSettingProvider.notifier)
              .unsubscribeFromStatusUpdates();
        });
      },
      child: Stack(
        children: [
          _buildMainContent(ds),
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      color: AppColors.pageBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '작업중입니다.',
            style: tStyle(size: 40.w),
          ),
          SizedBox(
            height: 50.w,
          ),
          // const CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }

  void _initializeExtendControllers(DeviceSettingModel ds) {
    setState(() {
      for (int i = 0; i < extended; i++) {
        textControllers['extend_id_$i'] ??= TextEditingController(
          text: i < ds.extend.length
              ? ds.extend[i].extendId.toString()
              : '${i + 1}',
        );
        textControllers['extend_name_$i'] ??= TextEditingController(
          text: i < ds.extend.length ? ds.extend[i].extendName : '',
        );
        textControllers['extend_offset_$i'] ??= TextEditingController(
          text: i < ds.extend.length
              ? ds.extend[i].extendOffset.toString()
              : '0.0',
        );
      }
    });
  }

  Widget _buildMainContent(DeviceSettingModel? ds) {
    return Container(
      color: AppColors.itemsBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (ds == null)
            Expanded(child: _buildLoadingScreen())
          else
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildDefaultSettings(ds),
                    if (extended > 0) ..._buildExtendSettings(ds),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDefaultSettings(DeviceSettingModel ds) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
      child: CustomContainer(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            ...SettingKeys.values.map((key) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.w),
                child: _buildCustomTextField(
                  label: '${key.krName}\n(${key.name})',
                  initialData:
                      ds.defaultOffset.getOffset(key.name).toStringAsFixed(1),
                  controller: textControllers[key.name],
                ),
              );
            }),
            SizedBox(height: 20.w)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExtendSettings(DeviceSettingModel ds) {
    return List.generate(extended, (index) {
      return _buildExtendEntry(index, ds);
    });
  }

  Widget _buildExtendEntry(int index, DeviceSettingModel ds) {
    // 확장 ID, 이름, 오프셋에 기본값 제공
    final extendId = index < ds.extend.length
        ? ds.extend[index].extendId.toString()
        : '${index + 1}';
    final extendName =
        index < ds.extend.length ? ds.extend[index].extendName : '';
    final extendOffset = index < ds.extend.length
        ? ds.extend[index].extendOffset.toString()
        : '0.0';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        confirmDismiss: (_) async {
          // 삭제 전 사용자 확인
          final shouldDelete = await _confirmDismissDialog();
          return shouldDelete ?? false;
        },
        onDismissed: (_) {
          _removeExtendEntry(index);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        child: CustomContainer(
          child: Column(
            children: [
              _buildCustomTextField(
                label: '확장 ID',
                controller: textControllers['extend_id_$index'],
                initialData: extendId,
              ),
              SizedBox(height: 4.w),
              _buildCustomTextField(
                label: '확장 이름\n(extend_name)',
                controller: textControllers['extend_name_$index'],
                initialData: extendName,
              ),
              SizedBox(height: 4.w),
              _buildCustomTextField(
                label: '확장 오프셋\n(extend_offset)',
                controller: textControllers['extend_offset_$index'],
                initialData: extendOffset,
              ),
              SizedBox(height: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Positioned(
      right: 20.w,
      bottom: 20.w,
      child: Column(
        children: [
          _buildFloatingButton('확장', AppColors.primary, expendOnTap),
          SizedBox(height: 10.w),
          _buildFloatingButton(
              '적용', AppColors.contentColorGreen, _applySettings),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(String label, Color color, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 90.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: tStyle(size: 20.w),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required String label,
    TextEditingController? controller,
    String? initialData,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 130.w,
          child: Text(
            label,
            style: tStyle(size: 17.w),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 200.w,
          child: CustomTextField(
            initialData: initialData ?? '',
            hintStyle: cStyle(size: 20.w).copyWith(color: Colors.black),
            onSaved: (String? newValue) {},
          ),
        ),
      ],
    );
  }

  Future<bool?> _confirmDismissDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('확장 항목 삭제'),
          content: const Text('이 항목을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  void _removeExtendEntry(int index) {
    // note bluetooth 부분 적용 해야함.
    // 디폴트 세팅 생성
    final updatedDefaultOffset = _createDefaultOffset();
    // 데이터와 컨트롤러 제거
    textControllers.remove('extend_id_$index');
    textControllers.remove('extend_name_$index');
    textControllers.remove('extend_offset_$index');

    // 키 업데이트
    for (int i = index; i < extended - 1; i++) {
      textControllers['extend_id_$i'] =
          textControllers.remove('extend_id_${i + 1}')!;
      textControllers['extend_name_$i'] =
          textControllers.remove('extend_name_${i + 1}')!;
      textControllers['extend_offset_$i'] =
          textControllers.remove('extend_offset_${i + 1}')!;
    }

    // 마지막 항목 제거 및 확장 카운트 감소
    textControllers.remove('extend_id_${extended - 1}');
    textControllers.remove('extend_name_${extended - 1}');
    textControllers.remove('extend_offset_${extended - 1}');
    extended--; // 확장 수 감소

    // 업데이트된 확장 항목 리스트 생성
    final updatedExtendSettings = _createExtendSettings();
    // DeviceSettingModel 생성
    final updatedSettings = DeviceSettingModel(
      defaultOffset: updatedDefaultOffset,
      extend: updatedExtendSettings,
    );
    _publishSettings(updatedSettings);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('확장 항목이 삭제되었습니다.')),
    );
  }

  void _applySettings() async {
    try {
      // DefaultOffset 생성
      final defaultOffset = _createDefaultOffset();

      // ExtendOffset 리스트 생성
      final extendSettings = _createExtendSettings();

      // DeviceSettingModel 생성
      final settings = DeviceSettingModel(
        defaultOffset: defaultOffset,
        extend: extendSettings,
      );

      // 설정 데이터 전송
      _publishSettings(settings);
      final bluetoothNStateNotifier = ref.read(bluetoothProvider.notifier);
      bluetoothNStateNotifier.startRequestOffsetData();
      _showSnackBar('설정이 적용되었습니다.');
      setState(() {});
    } catch (e) {
      print('설정 적용 중 오류 발생: $e');
      _showSnackBar('설정 적용 중 오류가 발생했습니다.');
    }
  }

  DefaultOffset _createDefaultOffset() {
    return DefaultOffset(
      offset_1: _getDoubleValue(SettingKeys.offset_1.name),
      offset_2: _getDoubleValue(SettingKeys.offset_2.name),
      offset_3: _getDoubleValue(SettingKeys.offset_3.name),
      offset_4: _getDoubleValue(SettingKeys.offset_4.name),
      offset_5: _getDoubleValue(SettingKeys.offset_5.name),
      offset_6: _getDoubleValue(SettingKeys.offset_6.name),
      offset_7: _getDoubleValue(SettingKeys.offset_7.name),
      offset_8: _getDoubleValue(SettingKeys.offset_8.name),
      offset_9: _getDoubleValue(SettingKeys.offset_9.name),
      offset_10: _getDoubleValue(SettingKeys.offset_10.name),
    );
  }

  double _getDoubleValue(String key) {
    return double.tryParse(
            (double.tryParse(textControllers[key]?.text ?? '0.0') ?? 0.0)
                .toStringAsFixed(1)) ??
        0.0;
  }

  List<ExtendOffset> _createExtendSettings() {
    // 리스트 생성
    final extendSettings = List<ExtendOffset>.generate(
      extended,
      (index) => ExtendOffset(
        extendId: _getIntValue('extend_id_$index', index + 1),
        extendName: textControllers['extend_name_$index']?.text ?? '',
        extendOffset: _getDoubleValue('extend_offset_$index'),
      ),
    );

    // extendId 기준으로 정렬 후 반환
    extendSettings.sort((a, b) => a.extendId.compareTo(b.extendId));

    return extendSettings;
  }

  int _getIntValue(String key, int defaultValue) {
    return int.tryParse(textControllers[key]?.text ?? '$defaultValue') ??
        defaultValue;
  }

  void _publishSettings(DeviceSettingModel settings) {
    final mqttStatusNotifier = ref.read(deviceSettingProvider.notifier);
    final bluetoothStatusNotifier = ref.read(bluetoothProvider.notifier);
    final bluetoothStatus = ref.read(bluetoothProvider);
    if (bluetoothStatus.isConnected == true) {
      final tempData = settings.toBinary();
      bluetoothStatusNotifier.sendUint8List(tempData);
      print(tempData);
    } else {
      mqttStatusNotifier.publishStatus(settings);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void expendOnTap() {
    try {
      setState(() {
        // 새로운 컨트롤러 추가
        textControllers['extend_id_$extended'] = TextEditingController(
          text: '${extended + 1}', // 기본 확장 ID
        );
        textControllers['extend_name_$extended'] = TextEditingController(
          text: '', // 기본 확장 이름
        );
        textControllers['extend_offset_$extended'] = TextEditingController(
          text: '0.0', // 기본 확장 오프셋
        );

        extended++; // 확장 항목 수 증가
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      });
    } catch (e, stackTrace) {
      print('Error in expendOnTap: $e');
      print(stackTrace);
    }
  }
}
