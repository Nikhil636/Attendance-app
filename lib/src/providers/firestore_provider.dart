import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/constants/user_role.dart';
import '../features/authentication/domain/models/user_model.dart';

///Provider that will be used to provide the firestore instance
final Provider<FirebaseFirestore> firestoreProvider =
    Provider<FirebaseFirestore>((ProviderRef<FirebaseFirestore> ref) {
  throw UnimplementedError();
});

///Provider that will be used to provide the firestore service
final Provider<FirestoreService> firestoreServiceProvider =
    Provider<FirestoreService>((ProviderRef<FirestoreService> ref) {
  return FirestoreService(ref.watch(firestoreProvider));
});

typedef AdminDataEither = Either<Unit, Map<String, dynamic>>;
typedef SaveDataEither = Either<Unit, Unit>;

class FirestoreService {
  late final FirebaseFirestore _firestore;
  FirestoreService(this._firestore);

  ///Get the collection reference
  ///[collectionPath] is the path of the collection
  CollectionReference<Map<String, dynamic>> getCollection(
      String collectionPath) {
    return _firestore.collection(collectionPath);
  }

  ///Get the document reference
  ///[collectionPath] is the path of the collection
  ///[documentPath] is the path of the document
  DocumentReference<Map<String, dynamic>> getDocument(
      String collectionPath, String documentPath) {
    return _firestore.collection(collectionPath).doc(documentPath);
  }

  ///Get the subcollection reference
  ///[collectionPath] is the path of the collection
  ///[documentPath] is the path of the document
  ///[subCollectionPath] is the path of the subcollection
  CollectionReference<Map<String, dynamic>> getSubCollection(
      String collectionPath, String documentPath, String subCollectionPath) {
    return _firestore
        .collection(collectionPath)
        .doc(documentPath)
        .collection(subCollectionPath);
  }

  ///Get the user details from the Admin collection with userid
  Future<AdminDataEither> getAdminDetails(String userId,
      {UserRole type = UserRole.Admin}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection(type.name).doc(userId).get();
      if (documentSnapshot.data() != null) {
        return right(documentSnapshot.data()!);
      }
      return left(unit);
    } catch (e) {
      return left(unit);
    }
  }

  ///Set the user details to the Employee collection associated with the userid
  ///[userId] is the id of the user
  Future<SaveDataEither> setUserDetails({
    required String userId,
    required UserDTO data,
    UserRole role = UserRole.Employee,
  }) async {
    try {
      await _firestore.collection(role.name).doc(userId).set(data.toJson());
      log('User details set', name: 'FirestoreService');
      return right(unit);
    } catch (e) {
      log(e.toString(), name: 'FirestoreService');
      return left(unit);
    }
  }

  ///Add a document to the collection type based on the [UserRole]
  ///[userId] is the id of the user
  Future<SaveDataEither> addDocument(
      Map<String, dynamic> doc, UserRole type) async {
    try {
      await _firestore.collection(type.name).add(doc);
      return right(unit);
    } catch (e) {
      log(e.toString());
      return left(unit);
    }
  }
}
