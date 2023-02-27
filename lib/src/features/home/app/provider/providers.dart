import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/location_repository.dart';
import '../../domain/check_in_state.dart';
import '../controller/check_in_controller.dart';

/// Provider for the checkIn Controller
final AutoDisposeNotifierProvider<CheckInNotifier, CheckInState>
    checkInNotifierProvider =
    NotifierProvider.autoDispose<CheckInNotifier, CheckInState>(
  CheckInNotifier.new,
);

///Location status provider
final AutoDisposeStreamProvider<ServiceStatus> locationStatusProvider =
    StreamProvider.autoDispose<ServiceStatus>(
  name: 'authStateProvider',
  (AutoDisposeStreamProviderRef<ServiceStatus> ref) {
    ref.listenSelf(
        (AsyncValue<ServiceStatus>? previous, AsyncValue<ServiceStatus> next) {
      return next.whenOrNull(
        data: (ServiceStatus data) => log('$data'),
      );
    });
    return ref.watch(locationRepositoryProvider).serviceStatusStream;
  },
);
