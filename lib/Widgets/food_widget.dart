import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtest/Cubit/cart_cubit.dart';
import 'package:foodtest/Helpers/color_scheme.dart';
import 'package:foodtest/Helpers/text_scheme.dart';
import 'package:foodtest/Model/FoodWidgetModel.dart';
import 'dart:math';
class FoodWidget extends StatefulWidget {

final FoodWidgetModel foodWidgetObj;
final CartCubit cartCubit;
FoodWidget({required this.foodWidgetObj, required this.cartCubit});
  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  late QuantityCubit quantityCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityCubit  = QuantityCubit();

  }
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
              border: Border.all(color: (widget.foodWidgetObj.dishType==1)?Colors.brown:Colors.green)
            ),
            child: Container(
              height: 10,
        width: 10,
              decoration: BoxDecoration(
                color: (widget.foodWidgetObj.dishType==1)?Colors.brown:Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.foodWidgetObj.title, style: contentText,),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('INR ${widget.foodWidgetObj.price}', style: contentText,),
                    Text('${widget.foodWidgetObj.calories} calories', style: contentText,)
                  ],
                ),
                SizedBox(height: 5,),
                Text(widget.foodWidgetObj.description, style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),),
                SizedBox(height: 5,),
                BlocBuilder<QuantityCubit, int>(
                  bloc: quantityCubit,
                  builder: (context, state) {
                    return Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){
                        quantityCubit.removeQuantity(widget.foodWidgetObj, widget.cartCubit);
                      }, icon: Icon(Icons.remove, color: Colors.white,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('${quantityCubit.state}', style: contentText.copyWith(color: Colors.white),),
                      ),
                      IconButton(onPressed: (){
                        quantityCubit.addQuantity(widget.foodWidgetObj, widget.cartCubit);
                      }, icon: Icon(Icons.add, color: Colors.white,)),
                    ],
                  ),
                );
  },
),
                SizedBox(height: 5,),
                if(widget.foodWidgetObj.customisationAvailable)Text("Customization Available", style: TextStyle(
                  color: Colors.red
                ),),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 100,
              child: Image.network(widget.foodWidgetObj.imageUrl, width: 100,height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text("No Preview"));

                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}

class QuantityCubit extends Cubit<int>{
  QuantityCubit():super(0);

  void addQuantity(FoodWidgetModel foodObj, CartCubit cartCubit){
    cartCubit.addItem(foodObj);
    emit(state+1);
  }
  void removeQuantity(FoodWidgetModel foodObj, CartCubit cartCubit)
  {
    cartCubit.removeItem(foodObj);
    emit(max(0, state-1));
  }
}
