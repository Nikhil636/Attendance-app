import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

typedef LocationEither = Either<String, Position>;

abstract class LocationRepositoryImpl {
  ///Stream of location changes
  ///Returns a stream of [Position] objects
  ///[distanceFilter] is the minimum distance (measured in meters) a device must move horizontally before an update event is generated.
  Stream<Position> get positionStream;

  ///Stream of service status changes
  ///Returns a stream of [ServiceStatus] objects
  Stream<ServiceStatus> get serviceStatusStream;

  /// Get the current location of the user
  Future<LocationEither> getCurrentLocation({
    LocationAccuracy? accuracy = LocationAccuracy.best,
    Duration? timelimit,
    bool forceAndroidLocationManager = false,
  });

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();


  ///Open the app settings
  /// [openAppSettings] is a boolean value that indicates whether the app settings should be opened
  Future<bool> openAppSettings({bool openAppSettings = true});

  ///Open the location settings
  /// [openLocationSettings] is a boolean value that indicates whether the location settings should be opened
  Future<bool> openLocationSettings({bool openLocationSettings = true});

  ///Ask for permission to access location
  ///Returns a [LocationPermission] object
  Future<LocationPermission> requestPermission({
    LocationPermission permissionLevel = LocationPermission.whileInUse,
  });

  ///Get the permission status
  ///Returns a [LocationPermission] object
  Future<LocationPermission> getPermissionStatus();

  /// Get the last known position of the user
  /// [forceAndroidLocationManager] is a boolean value that indicates whether the
  /// Android LocationManager should be used instead of the Google Location Services API.
  Future<LocationEither> getLastKnownPosition({
    bool forceAndroidLocationManager = false,
  });
}
