import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/auth_repository.dart';
import '../../domain/state/sign_up_state.dart';
import '../controllers/signup_controller.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authState;
});

final signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>((ref) {
  return SignUpController(ref);
});
