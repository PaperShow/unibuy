import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserDetails({
    required User user,
    String? name,
    String? phoneNumber,
    Map<String, dynamic>? additionalData,
  }) async {
    final userRef = _firestore.collection('users').doc(user.uid);

    final data = {
      'uid': user.uid,
      'email': user.email,
      'phoneNumber': phoneNumber ?? user.phoneNumber,
      'displayName': name ?? user.displayName,
      'photoURL': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
      ...?additionalData,
    };

    // Use set with merge true to update existing fields or create new doc
    await userRef.set(data, SetOptions(merge: true));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
      String uid) async {
    return _firestore.collection('users').doc(uid).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }
}
