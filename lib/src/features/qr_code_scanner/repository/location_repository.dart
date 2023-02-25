import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/riverpod_extensions.dart';

final AutoDisposeProvider<LocationRepository> locationRepositoryProvider =
    Provider.autoDispose<LocationRepository>(
  name: 'locationRepositoryProvider',
  (AutoDisposeProviderRef<LocationRepository> ref) {
    ref.cacheProvider(const Duration(minutes: 1),
        onDisposedCallback: () => log('LocationRepository disposed'));
    return LocationRepository();
  },
);

typedef LocationEither = Either<String, Position>;

class LocationRepository {
  ///Listen to the changes in the location data
  ///Returns a stream of [Position] objects
  Stream<Position> get positionStream => Geolocator.getPositionStream();

  ///Listen to the changes in the service status
  ///Returns a stream of [ServiceStatus] objects
  Stream<ServiceStatus> get serviceStatusStream =>
      Geolocator.getServiceStatusStream();

  ///Get the current location data
  Future<LocationEither> getCurrentLocation({
    LocationAccuracy? accuracy = LocationAccuracy.best,
    Duration? timelimit,
    bool forceAndroidLocationManager = false,
  }) async {
    try {
      if (await isLocationServiceEnabled()) {
        Position position =
            await Geolocator.getCurrentPosition(desiredAccuracy: accuracy!);
        return right(position);
      }
      bool permissionRes = await requestPermission();
      if (permissionRes) {
        return (await getCurrentLocation());
      }
      return left('Location services are disabled.');
    } on LocationServiceDisabledException {
      return left('Location services are disabled.');
    } on TimeoutException {
      return left('Location request timed out.');
    } catch (e) {
      log(e.toString());
      return left('Location request failed.');
    }
  }

  ///Get the last known position
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

  ///check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  ///Open the app settings
  Future<bool> openAppSettings() async {
    try {
      return await Geolocator.openAppSettings();
    } catch (e) {
      return false;
    }
  }

  ///Open the location settings
  Future<bool> openLocationSettings() async {
    try {
      return await Geolocator.openLocationSettings();
    } catch (e) {
      return false;
    }
  }

  ///get the permission status from geolocator
  Future<LocationPermission> getPermissionStatus() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      return permission;
    } on PermissionDefinitionsNotFoundException {
      return LocationPermission.denied;
    } on PermissionRequestInProgressException {
      return LocationPermission.denied;
    } catch (e) {
      log(e.toString());
      return LocationPermission.denied;
    }
  }

  ///Ask for permission to access location
  ///Returns a [LocationPermission] object
  Future<bool> requestPermission() async {
    try {
      LocationPermission permission = await getPermissionStatus();
      switch (permission) {
        case LocationPermission.denied:
          permission = await Geolocator.requestPermission();
          break;
        case LocationPermission.deniedForever:
          return (await Geolocator.openLocationSettings());
        case LocationPermission.unableToDetermine:
          return false;
        case LocationPermission.always:
          return true;
        default:
          return false;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
