import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_methods.dart';

class AuthRepository implements AuthRepositoryImpl {
  late final FirebaseAuth _firebaseAuth;
  AuthRepository(this._firebaseAuth);

  @override
  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  @override
  Future<CredentialEither> signInWithCredential(
      {required AuthCredential credential}) async {
    try {
      return right(await _firebaseAuth.signInWithCredential(credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //TODO: Call linkWithCredential later on if required with the orginal credential
        return left('The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        return left('Error occurred while accessing credentials. Try again.');
      } else if (e.code == 'operation-not-allowed') {
        return left('Unable to sign in with this credential.');
      } else if (e.code == 'user-disabled') {
        return left('The user account has been disabled by an administrator.');
      } else if (e.code == 'user-not-found') {
        return left('No user found corresponding to the given credential.');
      } else if (e.code == 'wrong-password') {
        return left(
            'The password is invalid or the user does not have a password.');
      } else if (e.code == 'invalid-verification-code') {
        return left('The verification code is invalid.');
      } else if (e.code == 'invalid-verification-id') {
        return left('The verification ID is invalid.');
      }
      return left('Something went wrong.');
    }
  }

  @override
  Future<SignInEither> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return right(authResult.user!);
      }
      return left('Something went wrong.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return left('Please try entering correct password.');
      } else if (e.code == 'invalid-email') {
        return left('Please try entering valid credentails');
      } else if (e.code == 'user-disabled') {
        return left('Your account has been disabled by the administrator');
      }
      return left('Something went wrong.');
    }
  }

  @override
  Future<SignInEither> signInWithPhone(
      {required String phoneNumber,
      required void Function(PhoneAuthCredential p1) onVerificationComplete,
      void Function(FirebaseAuthException p1)? onVerificationFailed,
      void Function(String p1, int? p2)? onCodeSent,
      Duration? timeoutDuration = const Duration(seconds: 30),
      void Function(String p1)? codeAutoRetrievalTimeout}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          CredentialEither res =
              await signInWithCredential(credential: credential);
          //TODO: Handle the error case like showing a snackbar etc from the controller class not in repository
          res.fold((String e) => log('Error $e'), right);
          onVerificationComplete(credential);
        },
        timeout: timeoutDuration ?? const Duration(seconds: 30),
        verificationFailed: (FirebaseAuthException error) =>
            onVerificationFailed?.call(error),
        codeSent: (String verificationId, int? resendToken) =>
            onCodeSent?.call(verificationId, resendToken),
        codeAutoRetrievalTimeout: (String verificationId) =>
            codeAutoRetrievalTimeout?.call(verificationId),
      );
      return left('Something went wrong.');
    } catch (e) {
      return left('Unable to login with phone number');
    }
  }

  @override
  Future<SignOutEither> signOut() async {
    try {
      //Provision to run multiple futures later
      await Future.wait(<Future<void>>[
        _firebaseAuth.signOut(),
      ]);
      return right(unit);
    } catch (e) {
      return left(unit);
    }
  }

  @override
  Future<SignUpEither> signUpUser(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      log(user.user?.uid ?? 'No user id found');
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

  @override
  Future<List<String>> fetchSignInMethodsForEmail(String email) async {
    try {
      return (await _firebaseAuth.fetchSignInMethodsForEmail(email));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return <String>[];
      }
      return <String>[];
    }
  }
  
  
}
