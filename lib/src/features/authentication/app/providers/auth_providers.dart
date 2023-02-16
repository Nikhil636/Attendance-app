import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/auth_repository.dart';
import '../../domain/state/sign_up_state.dart';
import '../controllers/password_notifier.dart';
import '../controllers/signup_controller.dart';

/// Provider for the authentication repository
final authRepositoryProvider = Provider(
    name: 'authRepositoryProvider',
    (ref) => AuthRepository(FirebaseAuth.instance));

/// Provider for the authentication state
final authStateProvider = StreamProvider<User?>(
    name: 'authStateProvider',
    (ref) => ref.watch(authRepositoryProvider).authState);

/// Provider for the sign up state
final signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        name: 'signUpControllerProvider', (ref) => SignUpController(ref));

/// Provider for the password visibility state
final passwordVisibiltyProvider =
    NotifierProvider.autoDispose<PasswordFieldNotifier, bool>(
  name: 'passwordVisibiltyProvider',
  PasswordFieldNotifier.new,
);
