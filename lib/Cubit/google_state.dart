part of 'google_cubit.dart';

@immutable
abstract class GoogleState {}

class GoogleInitial extends GoogleState {}
class GoogleLoading extends GoogleState{}
class GoogleSuccess extends GoogleState{
  final UserModel userObj;
  GoogleSuccess({required this.userObj});
}
class GoogleFailed extends GoogleState{

}
