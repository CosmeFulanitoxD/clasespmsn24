import 'package:firebase_auth/firebase_auth.dart';

class Emailauth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> createuser(String user, String email, String pass) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      credentials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      print('error');
    }
    return false;
  }

  Future<bool> validateuser(String email, String pass) async {
    try {
      final credentials =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (credentials.user!.emailVerified) {
        return true;
      }
    } catch (e) {
      print('error usuario ${e}');
    }
    return false;
  }
}
