import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/user_status_provider.dart';
import '../../data/location_methods.dart';
import '../../data/location_repository.dart';
import '../../domain/check_in_state.dart';

class CheckInNotifier extends AutoDisposeNotifier<CheckInState> {
  @override
  CheckInState build() {
    ref.listenSelf((CheckInState? previous, CheckInState next) {
      if (next == const CheckInState.initial()) {
        initLocationService();
      }
    });
    return const CheckInState.initial();
  }

  Future<void> initLocationService({bool isRetry = false}) async {
    if (isRetry) {
      state = const CheckInState.loading();
    }
    LocationEither result =
        await ref.read(locationRepositoryProvider).getCurrentLocation();
    result.fold(
      (String left) => state = CheckInState.failure(left),
      (Position location) {
        ref
            .read(userNotifierProvider.notifier)
            .updateLocation(location.latitude, location.longitude);
        state = CheckInState.success(location);
      },
    );
  }

  Future<void> askLocationService() async {
    state = const CheckInState.loading();
    LocationPermission permission =
        await ref.read(locationRepositoryProvider).requestPermission();
    log(permission.toString());
    if (permission == LocationPermission.denied) {
      state = const CheckInState.failure('Location permission denied.');
    } else if (permission == LocationPermission.deniedForever) {
      state = const CheckInState.failure(
          'Location permission denied forever. Please enable it in settings.');
    } else {
      await initLocationService(isRetry: true);
    }
  }
}
