import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  bool isConnected() {
    return _firebaseAuth.currentUser != null;
  }

  Future<bool> signOut() async {
    await _firebaseAuth.signOut();
    return true;
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
