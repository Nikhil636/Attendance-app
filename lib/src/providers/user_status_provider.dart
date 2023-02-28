import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/authentication/domain/models/user_model.dart';

/// Provider for the user notifier
final StateNotifierProvider<UserNotifier, UserDTO?> userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserDTO?>(
  name: 'userNotifierProvider',
  (StateNotifierProviderRef<UserNotifier, UserDTO?> ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserDTO> {
  UserNotifier() : super(const UserDTO());

  UserDTO? get currentUser => state;

  void setUserProperties({
    String? employeeId,
    String? fullName,
    String? birthDate,
    String? userId,
    String? address,
    String? profilePicLink,
  }) {
    state = state.copyWith(
      employeeId: employeeId,
      fullName: fullName,
      birthDate: birthDate,
      uID: userId,
      address: address,
      profilePicLink: profilePicLink,
    );
  }

  void updateLocation(double lat, double long) {
    state = state.copyWith(lat: lat, long: long);
  }

  set user(UserDTO user) {
    state = user;
  }

  void clearUser() {
    state = const UserDTO();
  }

  @override
  bool updateShouldNotify(UserDTO old, UserDTO current) {
    if (!mounted) {
      return false;
    }
    return super.updateShouldNotify(old, current);
  }

  @override
  void dispose() {
    clearUser();
    super.dispose();
  }
}
