import 'dart:async';
import 'package:flutter/foundation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  final Stream<dynamic> stream;
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(this.stream) {
    _subscription = stream.listen((_) {
      notifyListeners(); // 상태 변경을 알림
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
