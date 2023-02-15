import 'package:attendance/src/features/authentication/domain/state/sign_up_state.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/auth_providers.dart';

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(this.ref) : super(const SignUpState.initial());

  final Ref ref;

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const SignUpState.loading();
    Either<String, Unit> result =
        await ref.read(authRepositoryProvider).signUp(email, password);
    result.fold(
      (failure) => state = SignUpState.failure(failure),
      (success) => state = const SignUpState.success(),
    );
  }
}
