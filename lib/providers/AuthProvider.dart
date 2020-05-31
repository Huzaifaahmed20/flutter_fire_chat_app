import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Stream<FirebaseUser> get isAuth {
    final Stream<FirebaseUser> user = _auth.onAuthStateChanged;
    return user;
  }

  void startLoader() {
    isLoading = true;
    notifyListeners();
  }

  void stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  Future<FirebaseUser> login(
      String email, String password, String phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      return authResult;
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      print(verId);
      return verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {};

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  Future<FirebaseUser> register(
      String email, String password, String username) async {
    startLoader();
    final FirebaseUser _user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: username))
        .user;

    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = username;

    _user.updateProfile(updateInfo);

    notifyListeners();
    stopLoader();
    return _user;
  }
}
