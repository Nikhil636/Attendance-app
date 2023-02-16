import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/auth_repository.dart';
import '../../domain/state/sign_up_state.dart';
import '../controllers/password_notifier.dart';
import '../controllers/signup_controller.dart';

final authRepositoryProvider = Provider(
    name: 'authRepositoryProvider',
    (ref) => AuthRepository(FirebaseAuth.instance));

final authStateProvider =
    StreamProvider<User?>(name: 'authStateProvider', (ref) {
  return ref.watch(authRepositoryProvider).authState;
});

final signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        name: 'signUpControllerProvider', (ref) => SignUpController(ref));

final passwordVisibiltyProvider =
    NotifierProvider.autoDispose<PasswordFieldNotifier, bool>(
  name: 'passwordVisibiltyProvider',
  PasswordFieldNotifier.new,
);
