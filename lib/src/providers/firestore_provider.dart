import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/constants/user_type.dart';

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
      {UserType type = UserType.admin}) async {
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
}
