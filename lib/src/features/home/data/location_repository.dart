import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/riverpod_extensions.dart';
import 'location_methods.dart';

final AutoDisposeProvider<LocationRepository> locationRepositoryProvider =
    Provider.autoDispose<LocationRepository>(
  name: 'locationRepositoryProvider',
  (AutoDisposeProviderRef<LocationRepository> ref) {
    ref.cacheProvider(
      const Duration(minutes: 1),
      onDisposedCallback: () => log('LocationRepository disposed'),
    );
    return LocationRepository();
  },
);

class LocationRepository implements LocationRepositoryImpl {
  @override
  Stream<Position> get positionStream => Geolocator.getPositionStream();

  @override
  Stream<ServiceStatus> get serviceStatusStream =>
      Geolocator.getServiceStatusStream();

  @override
  Future<LocationEither> getCurrentLocation({
    LocationAccuracy? accuracy = LocationAccuracy.high,
    Duration? timelimit,
    bool forceAndroidLocationManager = false,
  }) async {
    try {
      bool isEnabled = await isLocationServiceEnabled();
      if (!isEnabled) {
        return left('Location services are disabled.');
      }
      LocationPermission permission = await getPermissionStatus();
      if (permission == LocationPermission.denied) {
        return left('Location permission denied.');
      } else if (permission == LocationPermission.deniedForever) {
        return left(
            'Location permission denied forever. Please enable it in settings.');
      }
      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: accuracy!);
      return right(position);
    } on LocationServiceDisabledException {
      return left('Location services are disabled.');
    } on TimeoutException {
      return left('Location request timed out.');
    } catch (e) {
      log(e.toString());
      return left('Location request failed.');
    }
  }

  @override
  Future<LocationEither> getLastKnownPosition(
      {bool forceAndroidLocationManager = false}) async {
    try {
      Position? position = await Geolocator.getLastKnownPosition(
          forceAndroidLocationManager: forceAndroidLocationManager);
      if (position != null) {
        return right(position);
      }
      return left('No last known position found.');
    } catch (e) {
      return left('Location request failed.');
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<LocationPermission> getPermissionStatus() async {
    try {
      return await Geolocator.checkPermission();
    } on PermissionDefinitionsNotFoundException {
      return LocationPermission.denied;
    } on PermissionRequestInProgressException {
      return LocationPermission.denied;
    } catch (e) {
      log(e.toString());
      return LocationPermission.denied;
    }
  }

  @override
  Future<bool> openAppSettings({bool openAppSettings = true}) async {
    try {
      return await Geolocator.openAppSettings();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> openLocationSettings({bool openLocationSettings = true}) async {
    try {
      return await Geolocator.openLocationSettings();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<LocationPermission> requestPermission(
      {LocationPermission permissionLevel =
          LocationPermission.whileInUse}) async {
    try {
      return (await Geolocator.requestPermission());
    } on PermissionDefinitionsNotFoundException {
      log('Please define location permissions in your AndroidManifest.xml');
      return LocationPermission.unableToDetermine;
    } on PermissionRequestInProgressException {
      log('Permission request is already in progress');
      return LocationPermission.denied;
    }
  }
}
