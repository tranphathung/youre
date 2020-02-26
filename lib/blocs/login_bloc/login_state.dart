import 'package:youre/models/user_model.dart';

abstract class LoginState {
  @override
  String toString() {
    return super.toString();
  }
}

class Uninitialized extends LoginState {
  @override
  String toString() {
    return "LoginState: Uninitializeds";
  }
}

class Authenticated extends LoginState {
  final User user;
  Authenticated(this.user);
  @override
  String toString() {
    return "LoginState: Authencicated";
  }
}

class Unauthenticated extends LoginState {
  @override
  String toString() {
    return "LoginState: Unauthenticated";
  }
}
