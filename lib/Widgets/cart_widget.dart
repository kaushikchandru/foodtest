import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtest/Cubit/cart_cubit.dart';
import 'package:foodtest/Helpers/color_scheme.dart';
import 'package:foodtest/Helpers/text_scheme.dart';
import 'package:foodtest/Model/FoodWidgetModel.dart';

import 'food_widget.dart';

class CartWidget extends StatelessWidget {
  final FoodWidgetModel foodWidgetObj;
  final CartCubit cartCubit;
  CartWidget({required this.foodWidgetObj, required this.cartCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(color: (foodWidgetObj.dishType==1)?Colors.brown:Colors.green)
            ),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: (foodWidgetObj.dishType==1)?Colors.brown:Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(foodWidgetObj.title, style: contentText,)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: newDarkGreen,
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            cartCubit.removeItem(foodWidgetObj);
                          }, icon: Icon(Icons.remove, color: Colors.white,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('${foodWidgetObj.quantity}', style: contentText.copyWith(color: Colors.white),),
                          ),
                          IconButton(onPressed: (){
                            cartCubit.addItem(foodWidgetObj);
                          }, icon: Icon(Icons.add, color: Colors.white,)),
                        ],
                      ),
                    ),
                    Text('INR ${foodWidgetObj.price}', style: contentText,),

                  ],
                ),
                SizedBox(height: 5,),

                Text('INR ${foodWidgetObj.price}', style: contentText,),
                SizedBox(height: 5,),

                Text('${foodWidgetObj.calories} calories', style: contentText,)
              ],
            ),
          ),
          

        ],
      ),
    );
  }
}
