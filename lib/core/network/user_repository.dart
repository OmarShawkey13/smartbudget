import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartbudget/core/models/user_model.dart';

class UserRepository {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  /// -----------------------------
  /// CREATE USER DOCUMENT
  /// -----------------------------
  Future<void> createUser(UserModel user) async {
    await users.doc(user.uid).set(user.toMap());
  }

  /// -----------------------------
  /// UPDATE USER DATA
  /// (name, bio, photo, username, token…)
  /// -----------------------------
  Future<void> updateUser(UserModel user) async {
    await users.doc(user.uid).update(user.toMap());
  }

  /// -----------------------------
  /// GET USER DATA
  /// -----------------------------
  Future<UserModel?> getUser(String uid) async {
    final doc = await users.doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
  }

  Future<bool> userExists(String uid) async {
    final doc = await users.doc(uid).get();
    return doc.exists;
  }

  /// -----------------------------
  /// CHECK IF USERNAME EXISTS
  /// -----------------------------
  Future<bool> usernameExists(String username) async {
    final result = await users
        .where('username', isEqualTo: username.toLowerCase())
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  /// -----------------------------
  /// DELETE USER DATA
  /// (لو حبيت تعمل حذف كامل)
  /// -----------------------------
  Future<void> deleteUser(String uid) async {
    await users.doc(uid).delete();
  }
}
