import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:minc_macae/service/contracts/authentication_service_interface.dart';
import 'package:minc_macae/store/user_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService implements IAuthenticationService {
  final _auth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance;
  final userStore = UserStore.getInstance();

  AuthenticationService();

  @override
  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(PhoneAuthCredential) verificationCompleted,
      Function(FirebaseAuthException) verificationFailed,
      Function(String, int?) codeSent,
      Function(String) codeAutoRetrievalTimeout) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+55$phoneNumber",
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> verifyPhoneNumberWithCode(
      String verificationId, String smsCode) async {
    final phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      _signInWithCredential(phoneAuthCredential);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      _signInWithCredential(phoneAuthCredential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signInWithCredential(
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    final UserCredential userCredential =
        await _auth.signInWithCredential(phoneAuthCredential);
    final User? user = userCredential.user;

    if (user != null) {
      final QuerySnapshot phoneQuery = await _fireStore
          .collection('users')
          .where('phoneNumber', isEqualTo: user.phoneNumber)
          .get();

      if (phoneQuery.docs.isNotEmpty) {
        final DocumentSnapshot userSnapshot = phoneQuery.docs.first;
        userSnapshot.reference.update({'uid': user.uid});
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        
        userStore.setStoredUser(userData);
      } else {
        throw FirebaseAuthException(
          code: 'unauthorized-phone-number',
          message: 'Phone number not authorized.',
        );
      }
    }
    else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'User not found.',
      );
    }
  }
}
