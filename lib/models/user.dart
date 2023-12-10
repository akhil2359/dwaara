class User {
  final String? uid;
  final String? name;
  final String? email;
  final String? profilePicture;

  User({this.uid, this.name, this.email, this.profilePicture});

  toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}