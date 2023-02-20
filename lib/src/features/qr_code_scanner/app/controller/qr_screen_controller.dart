import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../domain/qr_state.dart';

class QrScreenController extends StateNotifier<QrState> {
  QrScreenController() : super(const QrState.initial());

  QRViewController? controller;

  void onQRViewCreated(QRViewController qrViewController) {
    controller = qrViewController;
    resumeCamera();
    controller?.scannedDataStream.listen((Barcode scanData) {
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
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
