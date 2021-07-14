import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum AccountStatus {
  loggedIn,
  notLoggedIn,
  notRegistered,
  invalidUser,
  notVerified,
  unknownError,
}

class LoginController extends GetxController {
  static final FirebaseAuth _instance = FirebaseAuth.instance;

  Future<bool> registerWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found.');
      } else if (e.code == 'wrong-password') {
        print('Kindly check your password.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  void signOut() async {
    await _instance.signOut();
  }
}
