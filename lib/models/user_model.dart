import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String id;
  final String displayName;
  final String email;
  final String photoUrl;
  String accessToken;
  String idToken;
  final GoogleSignInAccount googleAccount;

  User(
      {this.id,
      this.displayName,
      this.email,
      this.photoUrl,
      this.accessToken,
      this.idToken,
      this.googleAccount});

  factory User.fromGooggleAccount(GoogleSignInAccount account) {
    return User(
        id: account.id,
        displayName: account.displayName,
        email: account.email,
        photoUrl: account.photoUrl,
        googleAccount: account);
  }

  @override
  String toString() {
    return "User $displayName, email: $email";
  }
}
