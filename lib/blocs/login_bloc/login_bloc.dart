import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/login_bloc/login_events.dart';
import 'package:youre/blocs/login_bloc/login_state.dart';
import 'package:youre/models/user_model.dart';
import 'package:youre/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => Uninitialized();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginApp) {
      yield* _loginToApp();
    }
  }

  Stream<LoginState> _loginToApp() async* {
    User user = await LoginRepository.loginRepository.loginToApp();
    if (user != null) {
      yield Authenticated(user);
    } else {
      yield Unauthenticated();
    }
  }
}
