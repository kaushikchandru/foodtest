part of 'phone_cubit.dart';

@immutable
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}
class PhoneLoading extends PhoneState{}
class PhoneCodeSent extends PhoneState{
  final String message;
  PhoneCodeSent({required this.message});
}
class PhoneVerificationComplete extends PhoneState{
  final UserModel currentUser;
  PhoneVerificationComplete({required this.currentUser});
}
class PhoneVerificationFailed extends PhoneState{
  final String errorMsg;
  PhoneVerificationFailed({required this.errorMsg});
}
class PhoneOtpVerified extends PhoneState{}
