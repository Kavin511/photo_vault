import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_sample/UI_Components/Galery/GalleryPage.dart';
import 'package:amplify_sample/authentication/signUp/SignUp.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
                controller: _emailController,
                validator: (value) =>
                    !validateEmail(value) ? "Email is Invalid" : null,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                controller: _passwordController,
                validator: (value) =>
                    value.isEmpty ? "Password is invalid" : null,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("LOG IN"),
                onPressed: () => _loginButtonOnPressed(context),
                color: Theme.of(context).primaryColor,
              ),
              OutlineButton(
                child: Text("Create New Account"),
                onPressed: () => _gotoSignUpScreen(context),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginButtonOnPressed(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        final response =
            await Amplify.Auth.signIn(username: email, password: password);
        if (response.isSignedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => GalleryPage()));
        }
      } on AuthError catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.cause),
        ));
      }
    }
  }

  void _gotoSignUpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignUp(),
      ),
    );
  }

  bool validateEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
