import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:foodtest/Model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  GoogleCubit() : super(GoogleInitial());

  signIntoGoogle() async
  {
    emit(GoogleLoading());
    GoogleSignInAccount _currentUser;
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ],
    );

    final gSignIn = await _googleSignIn.signIn();
    if(gSignIn == null)
      {
        emit(GoogleFailed());
      }
    else{
      print(gSignIn.displayName);
      print(gSignIn.id);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserModel newUser = UserModel(
          userName: gSignIn.displayName!,
          imgUrl: gSignIn.photoUrl!,
          mailId: gSignIn.email, phoneNumber: "", userId: gSignIn.id);
      prefs.setString("user", json.encode(newUser));
      emit(GoogleSuccess(userObj: newUser));
    }
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async{
    //   _currentUser = account!;
    //
    //   if (_currentUser != null) {
    //
    //
    //    // completeSocialLogin(_currentUser.displayName, _currentUser.email, _currentUser.id, "2");
    //   }
    // });

  }

}
