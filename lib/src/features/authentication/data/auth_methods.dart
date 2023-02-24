import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef SignOutEither = Either<Unit, Unit>;
typedef CredentialEither = Either<String, UserCredential>;
typedef SignInEither = Either<String, User>;
typedef SignUpEither = Either<String, Unit>;

abstract class AuthRepositoryImpl {
  /// Stream of auth state changes
  Stream<User?> get authState;

  /// Sign in with email and password
  Future<SignInEither> signInWithEmailAndPassword(
      String email, String password);

  /// Sign in with phone number
  Future<SignInEither> signInWithPhone({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationComplete,
    void Function(FirebaseAuthException)? onVerificationFailed,
    void Function(String, int?)? onCodeSent,
    Duration? timeoutDuration = const Duration(seconds: 30),
    void Function(String)? codeAutoRetrievalTimeout,
  });

  /// Sign in with credential
  /// [credential] is the credential returned from any auth event
  Future<CredentialEither> signInWithCredential(
      {required AuthCredential credential});

  ///Fetch the signin methods for the user
  Future<List<String>> fetchSignInMethodsForEmail(String email);

  /// Sign up user
  Future<SignUpEither> signUpUser(String email, String password);

  /// Sign out from the session
  Future<SignOutEither> signOut();
}
