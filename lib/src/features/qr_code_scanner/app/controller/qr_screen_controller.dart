import 'dart:async';
import 'dart:developer';

import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../providers/user_status_provider.dart';
import '../../domain/qr_state.dart';
import '../../repository/location_repository.dart';

class QrScreenController extends StateNotifier<QrState> {
  final Ref ref;
  QrScreenController(this.ref) : super(const QrState.initial()) {
    initLocationService();
  }

  QRViewController? controller;

  Future<void> initLocationService({bool isRetry = false}) async {
    if (isRetry) {
      state = const QrState.scanning();
    }
    LocationEither result =
        await ref.read(locationRepositoryProvider).getCurrentLocation();
    result.fold(
      (String left) => state = QrState.error(left),
      (Position location) => ref
          .watch(userNotifierProvider.notifier)
          .updateLocation(location.latitude, location.longitude),
    );
  }

  void onQRViewCreated(QRViewController qrViewController) {
    controller = qrViewController;
    resumeCamera();
    controller?.scannedDataStream.listen((Barcode scanData) async {
      state = QrState.loaded(scanData);
      pauseCamera();
    }, onError: (dynamic error) {
      log(error.toString());
      state = const QrState.error('Unable to scan QR code');
    });
  }

  void pauseCamera() => controller?.pauseCamera();

  void resumeCamera() {
    controller?.resumeCamera();
    state = const QrState.scanning();
  }

  @override
  bool updateShouldNotify(QrState old, QrState current) {
    if (!mounted) {
      return false;
    }
    return super.updateShouldNotify(old, current);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
