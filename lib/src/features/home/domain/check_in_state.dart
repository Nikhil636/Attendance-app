import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'check_in_state.freezed.dart';

@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState.initial() = _Initial;
  const factory CheckInState.loading() = _Loading;
  const factory CheckInState.success(Position position) = _Success;
  const factory CheckInState.failure(String message) = _Failure;
}