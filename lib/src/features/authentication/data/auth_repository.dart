import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef SignOutEither = Either<Unit, Unit>;
typedef SignInEither = Either<Unit, User?>;
typedef SignUpEither = Either<String, Unit>;

class AuthRepository {
  late final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  Future<SignInEither> signInWithCredentials(
      String email, String password) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(authResult.user);
    } on FirebaseAuthException {
      return left(unit);
    }
  }

  Future<SignOutEither> signOut() async {
    try {
      Future.wait([
        _firebaseAuth.signOut(),
      ]);
      return right(unit);
    } catch (e) {
      return left(unit);
    }
  }

  Future<SignUpEither> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return left('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        return left('The email is invalid.');
      } else if (e.code == 'operation-not-allowed') {
        return left('Unable to create user.');
      }
      return left('Something went wrong.');
    }
  }
}
