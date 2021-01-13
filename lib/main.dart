import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_sample/UI_Components/CamerFlow.dart';
import 'package:amplify_sample/authentication/login/login.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'amplifyconfiguration.dart';
import 'authentication/Verification_page.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // gives our app awareness about whether we are succesfully connected to the cloud
  bool _amplifyConfigured = false;

  // Instantiate Amplify
  Amplify _amplifyInstance = Amplify();

  // controllers for text input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSignUpComplete = false;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();

    // amplify is configured on startup
    _configureAmplify();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future<void> _configureAmplify() async {
    try {
      AmplifyAuthCognito auth = AmplifyAuthCognito();
      AmplifyStorageS3 storageS3=AmplifyStorageS3();
      _amplifyInstance.addPlugin(
        authPlugins: [auth],
        storagePlugins: [storageS3]
      );
      await _amplifyInstance.configure(amplifyconfig);
      setState(() => _amplifyConfigured = true);
    } catch (e) {
      print(e);
      setState(() => _amplifyConfigured = false);
    }
  }

  // Future<String> _registerUser(LoginData data) async
  // {
  //   try {
  //     Map<String, dynamic> userAttributes = {
  //       "email": emailController.text,
  //     };
  //     SignUpResult res = await Amplify.Auth.signUp(
  //         username: data.name,
  //         password: data.password,
  //         options: CognitoSignUpOptions(
  //             userAttributes: userAttributes
  //         )
  //     );
  //     setState(() {
  //       isSignUpComplete = res.isSignUpComplete;
  //       print("Sign up: " + (isSignUpComplete ? "Complete" : "Not Complete"));
  //     });
  //   } on AuthError catch (e) {
  //     print(e);
  //     return "Register Error: " + e.toString();
  //   }
  // }
  //
  // Future<String> _signIn(LoginData data) async {
  //   try {
  //     SignInResult res = await Amplify.Auth.signIn(
  //       username: data.name,
  //       password: data.password,
  //     );
  //     setState(() {
  //       isSignedIn = res.isSignedIn;
  //     });
  //   } on AuthError catch (e) {
  //     print(e);
  //     return 'Log In Error: ' + e.toString();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if(Amplify.Auth.getCurrentUser()==null)
    // {
      print("amplify"+Amplify.Auth.getCurrentUser().toString());
      return LoginScreen();
    // }
    // else
    //   return CameraFlow();
  }
}
