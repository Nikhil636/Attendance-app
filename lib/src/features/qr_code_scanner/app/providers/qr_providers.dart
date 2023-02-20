import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/riverpod_extensions.dart';
import '../../domain/qr_state.dart';
import '../controller/qr_screen_controller.dart';

final AutoDisposeStateNotifierProvider<QrScreenController, QrState>
    qrScreenControllerProvider =
    StateNotifierProvider.autoDispose<QrScreenController, QrState>(
  name: 'qrScreenControllerProvider',
  (AutoDisposeStateNotifierProviderRef<QrScreenController, QrState> ref) {
    ref.cacheProvider(const Duration(seconds: 10));
    return QrScreenController();
  },
);
