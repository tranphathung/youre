import 'package:google_sign_in/google_sign_in.dart';
import 'package:youre/models/user_model.dart';

class LoginRepository {
  LoginRepository._();
  static LoginRepository loginRepository = LoginRepository._();

  loginToApp() async {
    try {
      GoogleSignIn _googleSigin = GoogleSignIn();
      GoogleSignInAccount _account = await _googleSigin.signIn();
      if (_account != null) {
        GoogleSignInAuthentication _auth = await _account.authentication;
        User user = User.fromGooggleAccount(_account);
        user.accessToken = _auth.accessToken;
        user.idToken = _auth.idToken;
        return user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
