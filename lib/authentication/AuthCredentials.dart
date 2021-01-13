 abstract class AuthCredentials {
  final String userName;
  final String password;
  AuthCredentials({this.userName, this.password});
}
class LoginCredentials extends AuthCredentials {
  LoginCredentials({String username, String password})
      : super(userName: username, password: password);
}
class SignUpCredentials extends AuthCredentials {
  final String email;
  SignUpCredentials({String username, String password,this.email})
      : super(userName: username, password: password);
}
