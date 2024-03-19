import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationService {
  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(PhoneAuthCredential) verificationCompleted,
      Function(FirebaseAuthException) verificationFailed,
      Function(String, int?) codeSent,
      Function(String) codeAutoRetrievalTimeout);  
  Future<void> signOut();
  Future<void> signInWithCredential(PhoneAuthCredential phoneAuthCredential);
  Future<void> verifyPhoneNumberWithCode(String verificationId, String smsCode);
}
