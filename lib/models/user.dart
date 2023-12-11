class User {
  final String? uid;
  final String? name;
  final String? email;
  final String? profilePicture;
  final List<String>? shirts;
  final List<String>? pants;
  final List<String>? shoes;
  final List<String>? accessories;

  User({this.uid, this.name, this.email, this.profilePicture, this.shirts, this.pants, this.shoes, this.accessories});

  toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}