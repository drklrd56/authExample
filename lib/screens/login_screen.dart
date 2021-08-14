import 'package:auth_app/controller/login_controller.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();
  bool _isloginScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isloginScreen ? Text('Login') : Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                validator: (String? value) {
                  if (value == null) {
                    return 'Enter a valid Email';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid Email';
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: true,
                validator: (String? value) {
                  if (value == null) {
                    return 'Enter a valid Password';
                  }
                  if (value.length < 6) {
                    return 'Enter a valid Password';
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_isloginScreen) {
                      await _loginController.signInWithEmail(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      if (_loginController.loginNotifier.value ==
                          AccountStatus.invalidUser) {
                        Get.snackbar('Login Error', 'Invalid User');
                      } else {
                        Get.offAllNamed(HomeScreen.routeName);
                      }
                    } else {
                      await _loginController.registerWithEmail(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      if (_loginController.loginNotifier.value ==
                          AccountStatus.notRegistered) {
                        Get.snackbar('Registration Error', 'Unknown Error');
                      } else if (_loginController.loginNotifier.value ==
                          AccountStatus.alreadyRegistered) {
                        Get.snackbar(
                            'Registration Error', 'Email already registered');
                      } else {
                        Get.offAllNamed(HomeScreen.routeName);
                      }
                    }
                  }
                },
                child: _isloginScreen ? Text('Login') : Text('Register'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isloginScreen = !_isloginScreen;
                  });
                },
                child: _isloginScreen ? Text('Register') : Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
