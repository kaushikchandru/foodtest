import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtest/Cubit/google_cubit.dart';
import 'package:foodtest/Cubit/phone_cubit.dart';
import 'package:foodtest/Model/user_model.dart';
import 'package:foodtest/helpers/color_scheme.dart';
import 'package:foodtest/helpers/text_scheme.dart';
import 'package:foodtest/pages/user_home.dart';

class LoginPage extends StatefulWidget {
  static const pageName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleCubit googleCubit = GoogleCubit();
  PhoneCubit phoneCubit = PhoneCubit();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "asset/image/login_page/firebaselogo.png", width: 200,),
              ),
            ),
            BlocBuilder<GoogleCubit, GoogleState>(
              bloc: googleCubit,
              builder: (context, state) {
                print(state);
                if (state is GoogleInitial) {
                  return InkWell(
                    onTap: () {
                      googleCubit.signIntoGoogle();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: newBlue,
                      ),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Image.asset(
                                "asset/image/login_page/googleIcon.png",
                                width: 20,)
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                                    "Google", style: contentText.copyWith(
                                    color: Colors.white
                                ))
                            ),
                          ),
                          Container(width: 30,)
                        ],
                      ),
                    ),
                  );
                }
                if (state is GoogleLoading) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: newBlue,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,)
                          ),
                        ),

                      ],
                    ),
                  );
                }
                if (state is GoogleSuccess) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, UserHome.pageName, (route) => false);
                  });

                  return Container();
                }

                return Container();
              },
            ),
            InkWell(
              onTap: (){showPhonePop(context);},
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    gradient: greenGradient
                ),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),

                        child: Icon(Icons.phone, color: Colors.white,)
                    ),
                    Expanded(
                      child: Center(
                          child: Text("Phone", style: contentText.copyWith(
                              color: Colors.white
                          ))
                      ),
                    ),
                    Container(width: 30,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  showPhonePop(BuildContext context) {
    TextEditingController phoneNumberController = new TextEditingController();
    AlertDialog otp_alert = AlertDialog(
      title: Text("Enter Phone Number", style: TextStyle(
          fontWeight: FontWeight.w700
      ), textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter Phone Number',
              prefixIcon: Icon(Icons.phone, color: newBlack),
            ),
          ),
          SizedBox(height: 6),
          BlocBuilder<PhoneCubit, PhoneState>(
            bloc: phoneCubit,
            builder: (context, state) {
              if (state is PhoneInitial) {
                return MaterialButton(
                  color: newDarkGreen,
                  onPressed: () {
                    phoneCubit.verifyPhoneNumber(phoneNumberController.text);
                  },
                  child: Text("VERIFY", style: TextStyle(
                    color: Colors.white,
                  ),),
                );
              }
              else if (state is PhoneVerificationComplete) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, UserHome.pageName, (route) => false);
                });

                return Container();
              }

              else if (state is PhoneLoading) {
                return MaterialButton(
                    color: newDarkGreen,
                    onPressed: () {

                    },
                    child: CircularProgressIndicator(color: Colors.white,)
                );
              }
              else if (state is PhoneCodeSent) {
                Navigator.pop(context);
                showOtpPop(context);
              }

              return MaterialButton(
                color: newDarkGreen,
                onPressed: () {
                  phoneCubit.verifyPhoneNumber(phoneNumberController.text);
                },
                child: Text("VERIFY", style: TextStyle(
                  color: Colors.white,
                ),),
              );
            },
          ),
        ],
      )
    );
    // set up the AlertDialog


    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return otp_alert;
      },
    );
  }

  showOtpPop(BuildContext context) {
    TextEditingController otpController = new TextEditingController();
    AlertDialog otp_alert = AlertDialog(
      title: Text("Enter OTP", style: TextStyle(
          fontWeight: FontWeight.w700
      ), textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'OTP',
              hintText: 'Enter OTP',
              prefixIcon: Icon(Icons.sms_outlined, color: newDarkGreen),
            ),
          ),
          SizedBox(height: 6),
          BlocBuilder<PhoneCubit, PhoneState>(
            bloc: phoneCubit,
            builder: (context, state) {
              if(state is PhoneOtpVerified)
              {
               
                gotoHomePage(context);
                return Container(
                  height:10,
                  width: 10,
                );
              }

              return MaterialButton(
                color: newDarkGreen,
                onPressed: () {
                  phoneCubit.signInWithPhoneNumber(otpController.text);
                },
                child: Text("VERIFY", style: TextStyle(
                  color: Colors.white,
                ),),
              );
            },
          ),
        ],
      )
    );
    // set up the AlertDialog


    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  otp_alert;
      },
    );
  }
  gotoHomePage(BuildContext context){

    WidgetsBinding.instance!.addPostFrameCallback((_) {
     Future.delayed(Duration.zero, (){
       Navigator.pushNamed(context, UserHome.pageName);
     });
    });
  }
}
