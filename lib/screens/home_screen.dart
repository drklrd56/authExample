import 'package:auth_app/controller/login_controller.dart';
import 'package:auth_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homeScreen';
  final LoginController _loginController = Get.find<LoginController>();
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
        ),
        actions: [
          IconButton(
            onPressed: () {
              _loginController.signOut();
              Get.offNamed(LoginScreen.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
