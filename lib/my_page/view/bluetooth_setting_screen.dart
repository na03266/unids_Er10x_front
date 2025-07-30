import 'package:er10x/common/bluetooth/bluetooth.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' hide BluetoothState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothSettingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'bluetooth';

  const BluetoothSettingScreen({super.key});

  @override
  ConsumerState<BluetoothSettingScreen> createState() =>
      _BluetoothSettingScreenState();
}

class _BluetoothSettingScreenState
    extends ConsumerState<BluetoothSettingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothState = ref.watch(bluetoothProvider);
    final bluetoothNotifier = ref.read(bluetoothProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: bluetoothState.isConnected == false
          ? _buildDeviceScanSection(bluetoothState, bluetoothNotifier)
          : _buildConnectedDeviceSection(bluetoothState, bluetoothNotifier),
    );
  }

  Widget _buildDeviceScanSection(
      BluetoothState bluetoothState, BluetoothNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          child: _buildScanButton(bluetoothState.isScanning, notifier),
        ),
        Expanded(
          child: bluetoothState.scanResults.isEmpty
              ? _buildNoDevicesFoundMessage()
              : _buildDeviceList(bluetoothState, notifier),
        ),
      ],
    );
  }

  Widget _buildScanButton(bool isScanning, BluetoothNotifier notifier) {
    return ElevatedButton.icon(
      onPressed: isScanning ? null : notifier.startScan,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.contentColorGreen,
        foregroundColor: AppColors.contentColorWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        textStyle: tStyle(size: 35.w).copyWith(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(
        Icons.bluetooth_searching,
        color: AppColors.contentColorWhite,
      ),
      label: Text(isScanning ? '스캔 중...' : '장치 스캔'),
    );
  }

  Widget _buildNoDevicesFoundMessage() {
    return Center(
      child: Text(
        '검색된 블루투스 장치가 없습니다',
        style: cStyle(size: 30.w),
      ),
    );
  }

  Widget _buildDeviceList(
      BluetoothState bluetoothState, BluetoothNotifier notifier) {
    return ListView.builder(
      itemCount: bluetoothState.scanResults.length,
      itemBuilder: (context, index) {
        final result = bluetoothState.scanResults[index];
        final device = result.device;

        return _buildDeviceTile(device, notifier);
      },
    );
  }

  Widget _buildDeviceTile(BluetoothDevice device, BluetoothNotifier notifier) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: ListTile(
        title: Text(
          device.platformName.isNotEmpty ? device.platformName : '알 수 없는 장치',
          style: cStyle(size: 30.sp),
        ),
        subtitle: Text(
          device.remoteId.toString(),
          style: cStyle(size: 25.sp),
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            try {
              await notifier.connectToDevice(device);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('장치에 연결되었습니다.')),
                );
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('장치목록을 갱신해주세요. \n오류: $e'),
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
          ),
          child: const Text(
            '연결',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectedDeviceSection(
      BluetoothState bluetoothState, BluetoothNotifier notifier) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildConnectedDeviceInfo(bluetoothState),
              SizedBox(height: 20.w),
              _buildReceivedData(bluetoothState),
              SizedBox(height: 30.w),
              _buildDisconnectButton(notifier),
            ],
          ),
          _buildCredentialsForm(notifier),
        ],
      ),
    );
  }

  Widget _buildConnectedDeviceInfo(BluetoothState bluetoothState) {
    return Text(
      '연결된 장치: ${bluetoothState.connectedDevice?.platformName ?? "알 수 없음"}',
      style: tStyle(size: 50.sp).copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildReceivedData(BluetoothState bluetoothState) {
    return Text(
      '수신 데이터: ${bluetoothState.data}',
      style: cStyle(size: 35.sp),
    );
  }

  Widget _buildDisconnectButton(BluetoothNotifier notifier) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await notifier.disconnectDevice();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('장치 연결이 해제되었습니다.')),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('연결 해제 실패: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.contentColorRed,
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 15.w,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      child: Text(
        '연결 해제',
        style: tStyle(size: 35.w).copyWith(color: AppColors.contentColorWhite),
      ),
    );
  }

  Widget _buildCredentialsForm(BluetoothNotifier notifier) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            controller: _ssidController,
            labelText: 'SSID',
            icon: Icons.wifi,
            validator: (value) =>
                value == null || value.isEmpty ? 'SSID를 입력해주세요' : null,
          ),
          SizedBox(height: 20.w),
          _buildTextField(
            controller: _passwordController,
            labelText: '비밀번호',
            icon: Icons.lock,
            obscureText: true,
            validator: (value) =>
                value == null || value.isEmpty ? '비밀번호를 입력해주세요' : null,
          ),
          SizedBox(height: 30.w),
          _buildSubmitButton(notifier),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildSubmitButton(BluetoothNotifier notifier) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          notifier.sendCredentials(
            _ssidController.text,
            _passwordController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SSID와 비밀번호를 전송했습니다.')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.contentColorGreen,
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 15.w,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      child: Text(
        '설정 전송',
        style: tStyle(size: 35.w).copyWith(color: AppColors.contentColorWhite),
      ),
    );
  }
}
