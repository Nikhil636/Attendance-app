import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' show Barcode;

part 'qr_state.freezed.dart';


@freezed
class QrState with _$QrState {
  const factory QrState.initial() = _Initial;
  const factory QrState.scanning() = _Scanning;
  const factory QrState.loaded(Barcode data) = _Loaded;
  const factory QrState.error([String? error]) = _Error;
}
