import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodtest/Model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(PhoneInitial());
  late String phNo;
  late String verificationID;
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    phNo = phoneNumber;
    emit(PhoneLoading());
    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 30),
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async{
        print(credential);
        await _auth.signInWithCredential(credential);
        print(credential.token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        UserModel newUser = UserModel(
            userName: phoneNumber,
            imgUrl: '',
            mailId: "",
            phoneNumber: phoneNumber,
            userId: credential.token.toString());
        prefs.setString("user", json.encode(newUser));

        emit(PhoneVerificationComplete(currentUser: newUser));
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(PhoneVerificationFailed(errorMsg: e.message.toString()));
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        emit(PhoneCodeSent(message: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithPhoneNumber(otp) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );
      final user = (await _auth.signInWithCredential(credential)).user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserModel newUser = UserModel(
          userName: phNo,
          imgUrl: '',
          mailId: "",
          phoneNumber: phNo,
          userId: user!.uid.toString());
      prefs.setString("user", json.encode(newUser));

      emit(PhoneOtpVerified());


    } catch (e) {
      print(e);

    }
  }

}
