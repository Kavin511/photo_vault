import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_sample/authentication/AuthCredentials.dart';
import 'package:amplify_sample/authentication/Verification_page.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback shouldShowLogin;
  final ValueChanged<SignUpCredentials> didProvideCredentials;

  SignUp({Key key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget SignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _userNameController,
            decoration: InputDecoration(
              labelText: 'Enter Username',
              icon: Icon(Icons.person),
            ),
          ),
          TextField(
            controller: _mailController,
            decoration: InputDecoration(
              labelText: 'Enter Mail',
              icon: Icon(Icons.mail),
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_open), labelText: 'Password'),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          FlatButton(
            onPressed: ()=>_createAccount(context),
            child: Text('SignUp'),
            textColor: Colors.white,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            SignUpForm(),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: widget.shouldShowLogin,
                child: Text('Already have an account? Login .'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void>_createAccount(BuildContext context) async{
    if(_formKey.currentState.validate())
      {
        String username = _userNameController.text.trim();
        String password = _passwordController.text.trim();
        String email = _mailController.text.trim();
        Map<String,dynamic> userAttributes={
          'email':email,
        };
        try {
          final result = await Amplify.Auth.signUp(
            username: email,
            password: password,
            options: CognitoSignUpOptions(userAttributes: userAttributes),
          );
          if (result.isSignUpComplete) {
            _gotToEmailConfirmationScreen(context, email);
          }
        } on AuthError catch (e) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(e.cause),
            ),
          );
        }
      }

    // final credentials = SignUpCredentials(
    //     username: username, password: password, email: email);
    // widget.didProvideCredentials(credentials);
  }
  void _gotToEmailConfirmationScreen(BuildContext context, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EmailConfirmationScreen(email: email),
      ),
    );
  }
}


