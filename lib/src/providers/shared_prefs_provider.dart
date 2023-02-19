import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<SharedPreferences> prefsProvider =
    Provider<SharedPreferences>((ProviderRef<SharedPreferences> ref) {
  throw UnimplementedError();
});

final Provider<SharedPrefsService> sharedPrefsServiceProvider =
    Provider<SharedPrefsService>((ProviderRef<SharedPrefsService> ref) {
  SharedPreferences sharedPrefs = ref.watch(prefsProvider);
  return SharedPrefsService(sharedPrefs);
});

class SharedPrefsService {
  late final SharedPreferences _preferences;
  SharedPrefsService(this._preferences);

  ///Save the current theme to the disk
  Future<bool> setTheme(bool isDarkMode) =>
      setValue<bool>('isDark', isDarkMode);

  ///Get the current theme from the disk
  bool getTheme() => getValue<bool>('isDark') ?? false;

  ///Save a value to the disk by passing the [key]
  ///and [value] in the method. Returns [true] if the value is set successfully
  Future<bool> setValue<T>(String key, T value) async {
    if (value is String) {
      return _preferences.setString(key, value);
    } else if (value is int) {
      return _preferences.setInt(key, value);
    } else if (value is bool) {
      return _preferences.setBool(key, value);
    } else if (value is double) {
      return _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      return _preferences.setStringList(key, value);
    } else {
      return false;
    }
  }

  ///Get a value from the disk by passing the key in the method
  ///```dart
  /// String? name = getValue<String>('name');
  ///```
  ///Returns null if the value is not found
  T? getValue<T>(String key) {
    try {
      if (T == String) {
        return _preferences.getString(key) as T?;
      } else if (T == int) {
        return _preferences.getInt(key) as T?;
      } else if (T == bool) {
        return _preferences.getBool(key) as T?;
      } else if (T == double) {
        return _preferences.getDouble(key) as T?;
      } else if (T == List<String>) {
        return _preferences.getStringList(key) as T?;
      } else {
        return null;
      }
    } catch (e) {
      log('Error thrown while getting the value from the disk',
          name: 'SharedPreferences', error: e);
      return null;
    }
  }

  ///Remove a particular entry from the disk
  ///Returns [true] if the data is removed successfully
  Future<bool> removeKey(String key) async {
    return _preferences.remove(key);
  }

  ///Clear all the data from the disk
  ///Returns [true] if the data is cleared successfully
  Future<bool> clearAll() async {
    return _preferences.clear();
  }
}
