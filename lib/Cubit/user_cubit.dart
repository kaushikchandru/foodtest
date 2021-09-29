import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:foodtest/Model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  getCurrentUser() async
  {
    late UserModel currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var convert = json.decode(prefs.getString("user")??"");

    UserModel returnVar = UserModel.fromJson(convert);

    currentUser = returnVar;
    emit(UserLoaded(currentUser: currentUser));
  }

}
