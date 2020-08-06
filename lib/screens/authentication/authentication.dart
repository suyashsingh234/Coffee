import 'package:flutter/material.dart';
import 'forms/signInForm.dart';
import 'forms/signUpForm.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  //SignInForm, SignUpForm
  bool _showSignInForm=false;
  void toggleForm(){
    setState(() {
      _showSignInForm=!_showSignInForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSignInForm ? SignInForm(toggleForm: toggleForm) : SignUpForm(toggleForm: toggleForm);
  }
}
