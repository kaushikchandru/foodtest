import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtest/Cubit/cart_cubit.dart';
import 'package:foodtest/Helpers/color_scheme.dart';
import 'package:foodtest/Helpers/text_scheme.dart';
import 'package:foodtest/Model/FoodWidgetModel.dart';
import 'package:foodtest/Pages/user_home.dart';
import 'package:foodtest/Widgets/cart_widget.dart';

class CartPage extends StatelessWidget {
  static const pageName = "/cartPage";
  final CartCubit cartCubit;

  CartPage({required this.cartCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<FoodWidgetModel>>(
      bloc: cartCubit,
      builder: (context, state) {
        int totalItems = 0;
        double totalCost = 0;
        for(var i = 0; i < state.length; i++)
          {
            totalItems += state[i].quantity;
            totalCost += state[i].quantity*state[i].price;
            print(totalItems);
          }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: newBlack,),
            ),
            title: Text(
              "Order Summary", style: contentText.copyWith(color: newBlack),),
          ),
          body: Container(
            padding: EdgeInsets.all(15),

            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: newDarkGreen,
                              child: Center(
                                child: Text('${state.length} Dishes - $totalItems Items', style: contentText.copyWith(
                                  color: Colors.white
                                ),),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.length,
                              itemBuilder: (context, index){
                                return CartWidget(foodWidgetObj: state[index], cartCubit: cartCubit);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total", style: contentText.copyWith(
                                    fontSize: 20,
                                  ),),
                                  Text("INR $totalCost", style: contentText.copyWith(
                                    color: Colors.green
                                  ),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    showOrderPop(context);
                    Future.delayed(Duration(seconds:3),(){
                      cartCubit.close();
                      Navigator.pushNamedAndRemoveUntil(context, UserHome.pageName, (route) => false);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: newDarkGreen,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Place Order", style: contentText.copyWith(
                          color: Colors.white,
                          fontSize: 20
                        ),textAlign: TextAlign.center,),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  showOrderPop(BuildContext context) {
    TextEditingController otpController = new TextEditingController();
    AlertDialog otp_alert = AlertDialog(
        title: Text("Success", style: TextStyle(
            fontWeight: FontWeight.w700
        ), textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: newDarkGreen,size: 50,),
            Text("Order Placed Successfully", style:contentText),
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
}
