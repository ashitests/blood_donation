import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hafsa/models/donor_model.dart';
import 'package:hafsa/models/seeker_model.dart';
import 'package:hafsa/services/firebase_user.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  /// Log In
  Future<String> signInWithEmailAndPass(
      {@required String email, @required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Email not Registered";
      } else if (e.code == 'wrong-password') {
        return "Wrong Password";
      } else {
        return "error";
      }
    }
  }

  /// SignUp as Donor
  Future<String> signUpDonor(
      {@required String email,
      @required String password,
      @required DonorModel donor}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        return await UserServices()
            .signUpDonor(donor: donor, uid: value.user.uid);
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// SignUp as Seeker
  Future<String> signUpSeeker(
      {@required String email,
      @required String password,
      @required SeekerModel seeker}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        return await UserServices()
            .signUpSeeker(seeker: seeker, uid: value.user.uid);
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future deleteAccount() async {
    /// first delete user data
    await UserServices().deleteUserData(_firebaseAuth.currentUser.uid);

    /// then delete user account
    await _firebaseAuth.currentUser.delete();
  }
}
