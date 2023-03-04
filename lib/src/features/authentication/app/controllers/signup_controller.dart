import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/constants/user_role.dart';
import '../../../../providers/firestore_provider.dart';
import '../../../../providers/user_status_provider.dart';
import '../../domain/models/user_model.dart';
import '../../domain/state/sign_up_state.dart';
import '../providers/auth_providers.dart';

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(this.ref) : super(const SignUpState.initial());

  final Ref ref;

  Future<void> signUp({
    required String email,
    required String password,
    UserRole role = UserRole.Employee,
  }) async {
    state = const SignUpState.loading();
    Either<String, UserCredential> result =
        await ref.read(authRepositoryProvider).signUpUser(email, password);
    result.fold(
      (String failure) => state = SignUpState.failure(failure),
      (UserCredential user) async {
        ref.read(userNotifierProvider.notifier).setUserProperties(
            userId: user.user!.uid,
            userRole: role,
            fullName: user.user!.displayName,
            email: user.user?.email,
            profilePicLink: user.user?.photoURL);
        bool setRes = await setUserToFirestore(
          userId: user.user!.uid,
          role: role,
          user: ref.read(userNotifierProvider.notifier).currentUser,
        );
        if (!setRes) {
          state = const SignUpState.failure('Couldn\'t set user details');
          return;
        }
        state = const SignUpState.success();
      },
    );
  }

  ///Sets the user to firestore
  Future<bool> setUserToFirestore({
    required String userId,
    required UserDTO user,
    UserRole role = UserRole.Employee,
  }) async {
    Either<Unit, Unit> result = await ref
        .read(firestoreServiceProvider)
        .setUserDetails(userId: userId, data: user, role: role);
    return result.isRight();
  }
}
