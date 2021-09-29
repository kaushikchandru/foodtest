import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtest/Cubit/user_cubit.dart';
import 'package:foodtest/Helpers/color_scheme.dart';
import 'package:foodtest/Helpers/text_scheme.dart';
import 'package:foodtest/Pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({Key? key}) : super(key: key);

  UserCubit userCubit = UserCubit();

  @override
  Widget build(BuildContext context) {
    userCubit.getCurrentUser();
     return BlocBuilder<UserCubit, UserState>(
      bloc: userCubit,
      builder: (context, state) {
        if(state is UserLoaded)
          {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(0, 0),
                child: AppBar(
                  backgroundColor: newDarkGreen,
                ),
              ),
              body: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: greenGradient,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height:30),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(state.currentUser.imgUrl),

                            ),
                            SizedBox(height: 10),
                            Text(state.currentUser.userName, style: contentText,),
                            SizedBox(height: 10),
                            Text(
                              'ID ${state.currentUser.userId}', style: contentText,),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove("user");
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.pageName, (route) => false);
                    },
                    child: Row(
                      children: [
                        SizedBox(width:10),
                        Icon(
                          Icons.logout, color: Colors.grey,
                        ),
                        SizedBox(width:30),
                        Text("Log Out", style: contentText.copyWith(
                          color: Colors.grey
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        else{
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );
  }

}
