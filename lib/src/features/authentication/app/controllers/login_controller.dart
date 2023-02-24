import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/auth_methods.dart';
import '../../domain/state/login_state.dart';
import '../providers/auth_providers.dart';

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;
  LoginController(this.ref) : super(const LoginState.initial());

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    state = const LoginState.loading();
    SignInEither result = await ref
        .read(authRepositoryProvider)
        .signInWithEmailAndPassword(email, password);
    result.fold(
      (String failure) => state = LoginState.failure(failure),
      (User success) => state = const LoginState.success(),
    );
  }

  Future<void> loginWithPhone({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationComplete,
    void Function(FirebaseAuthException)? onVerificationFailed,
    void Function(String, int?)? onCodeSent,
    Duration? timeoutDuration = const Duration(seconds: 30),
    void Function(String)? codeAutoRetrievalTimeout,
  }) async {
    state = const LoginState.loading();
    SignInEither result =
        await ref.read(authRepositoryProvider).signInWithPhone(
              phoneNumber: phoneNumber,
              onVerificationComplete: onVerificationComplete,
              onVerificationFailed: onVerificationFailed,
              onCodeSent: onCodeSent,
              timeoutDuration: timeoutDuration,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            );
    result.fold(
      (String failure) => state = LoginState.failure(failure),
      (User success) {
        //TODO: Set whaterver user data needs to be cached in provider as Ref is accessible
        state = const LoginState.success();
      },
    );
  }
}
