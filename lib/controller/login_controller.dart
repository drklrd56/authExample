import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum AccountStatus {
  loggedIn,
  notLoggedIn,
  registered,
  notRegistered,
  alreadyRegistered,
  invalidUser,
}

class LoginController extends GetxController {
  static final FirebaseAuth _instance = FirebaseAuth.instance;
  final Rx<AccountStatus> loginNotifier = AccountStatus.notLoggedIn.obs;

  Future<void> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      loginNotifier.value = AccountStatus.registered;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        loginNotifier.value = AccountStatus.alreadyRegistered;
      }
    } catch (e) {
      loginNotifier.value = AccountStatus.notRegistered;
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      loginNotifier.value = AccountStatus.loggedIn;
    } catch (e) {
      loginNotifier.value = AccountStatus.invalidUser;
    }
  }

  void signOut() async {
    await _instance.signOut();
    loginNotifier.value = AccountStatus.notLoggedIn;
  }
}
