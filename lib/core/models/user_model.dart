class UserModel {
  final String? uid;
  final String? email;
  final String? username;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
  });

  /// ------------ Firestore → Model ------------
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  /// ------------ Model → Firestore / JSON ------------
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'username': username};
  }
}
