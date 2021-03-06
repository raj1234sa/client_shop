import 'package:client_shop/models/user.dart';
import 'package:client_shop/utils/constants.dart';
import 'package:client_shop/utils/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  static Future<String> signUpWithEmailAndPassword(String email,
      String username, String password, String phoneNumber) async {
    String errorMessage = "";
    try {
      auth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      auth.User firebaseUser = userCredential.user;
      await firebaseUser.updateProfile(displayName: username);
      User user = User(
        emailId: firebaseUser.email,
        phoneNumber: phoneNumber,
        userId: firebaseUser.uid,
        username: username,
        isVerified: firebaseUser.emailVerified,
      );
      _usersRef.doc(firebaseUser.uid).set(user.toMap());
      await firebaseUser.sendEmailVerification();
      return kAccountSuccessMessage;
    } catch (e) {
      print(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "Your email address is already registered";
          break;
      }
      return errorMessage;
    }
  }

  static Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    String errorMessage = "";
    try {
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user.emailVerified) {
        _usersRef.doc(userCredential.user.uid).get().then((userdata) async {
          User user = User.fromMap(userdata.data());
          await SharedPref.saveUserToSharedRef('loggedInUser', user);
        });
        return true;
      } else {
        return "Email address is not verified.";
      }
    } catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }

  static Future<bool> signOut() async {
    _auth.signOut();
    return await SharedPref.remove('loggedInUser');
  }
}
