import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/auth_repository.dart';
import '../../domain/state/login_state.dart';
import '../../domain/state/sign_up_state.dart';
import '../controllers/login_controller.dart';
import '../controllers/password_notifier.dart';
import '../controllers/signup_controller.dart';

/// Provider for the authentication repository
final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>(name: 'authRepositoryProvider',
        (ProviderRef<AuthRepository> ref) {
  return AuthRepository(FirebaseAuth.instance);
});

/// Provider for the authentication state
final StreamProvider<User?> authStateProvider = StreamProvider<User?>(
    name: 'authStateProvider',
    (StreamProviderRef<User?> ref) =>
        ref.watch(authRepositoryProvider).authState);

/// Provider for the sign up state
final AutoDisposeStateNotifierProvider<SignUpController, SignUpState>
    signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        name: 'signUpControllerProvider', SignUpController.new);

/// Provider for the password visibility state
final AutoDisposeNotifierProvider<PasswordFieldNotifier, bool>
    passwordVisibiltyProvider =
    NotifierProvider.autoDispose<PasswordFieldNotifier, bool>(
  name: 'passwordVisibiltyProvider',
  PasswordFieldNotifier.new,
);

///Provider for login screen
final AutoDisposeStateNotifierProvider<LoginController, LoginState>
    loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>(
  name: 'loginControllerProvider',
  LoginController.new,
);
