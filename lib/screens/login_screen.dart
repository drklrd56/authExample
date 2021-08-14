import 'package:auth_app/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = '/loginScreen';
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();
  final bool _isloginScreen = true;
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
                validator: (String? value) {
                  if (value != null && value.contains('@')) {
                    return 'Enter a valid Email';
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                validator: (String? value) {
                  if (value != null && value.length > 6) {
                    return 'Enter a valid Password';
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_isloginScreen) {
                      await _loginController.signInWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if(_loginController.loginNotifier.value == AccountStatus.invalidUser) {

                      } else {

                      }
                    } else {
                      _loginController.registerWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if(_loginController.loginNotifier.value == AccountStatus.notRegistered) {

                      } else if(_loginController.loginNotifier.value == AccountStatus.alreadyRegistered) {
                        
                      } else {
                        
                      }
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
