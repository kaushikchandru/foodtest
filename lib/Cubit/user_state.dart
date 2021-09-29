part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserLoaded extends UserState{
  final UserModel currentUser;
  UserLoaded({required this.currentUser});
}
