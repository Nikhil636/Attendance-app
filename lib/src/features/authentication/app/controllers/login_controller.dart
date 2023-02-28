import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/constants/user_type.dart';
import '../../../../providers/firestore_provider.dart';
import '../../../../providers/user_status_provider.dart';
import '../../data/auth_methods.dart';
import '../../domain/state/login_state.dart';
import '../providers/auth_providers.dart';

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;
  LoginController(this.ref) : super(const LoginState.initial());

  Future<AdminDataEither> getAdminDetails(String userId) async {
    return ref.read(firestoreServiceProvider).getAdminDetails(userId);
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    UserType userType = UserType.employee,
  }) async {
    state = const LoginState.loading();
    SignInEither result = await ref
        .read(authRepositoryProvider)
        .signInWithEmailAndPassword(email, password);
    await result.fold(
      (String failure) {
        state = LoginState.failure(failure);
        return;
      },
      (User user) async {
        AdminDataEither res = await getAdminDetails(user.uid);
        if (res.isLeft()) {
          state = const LoginState.failure('User with Admin data not found');
          return;
        }
        ref.read(userNotifierProvider.notifier).setUserProperties(
              userId: user.uid,
              fullName: user.displayName,
              profilePicLink: user.photoURL,
            );
        state = const LoginState.success();
        return;
      },
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
      (String failure) {
        state = LoginState.failure(failure);
        return;
      },
      (User user) {
        ref.read(userNotifierProvider.notifier).setUserProperties(
              userId: user.uid,
              fullName: user.displayName,
              profilePicLink: user.photoURL,
            );
        state = const LoginState.success();
        return;
      },
    );
  }
}
