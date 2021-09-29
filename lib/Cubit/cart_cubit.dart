import 'package:bloc/bloc.dart';
import 'package:foodtest/Model/FoodListModel.dart';
import 'package:foodtest/Model/FoodWidgetModel.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<List<FoodWidgetModel>> {
  CartCubit() : super([]);

  addItem(FoodWidgetModel foodObj)
  {

    if(state.contains(foodObj))
      {
        state[state.indexOf(foodObj)].quantity++;
      }
    else
      {
        state.add(foodObj);
        state[state.indexOf(foodObj)].quantity++;
      }
    emit(state.toList());
  }
  removeItem(FoodWidgetModel foodObj)
  {
    if(state.contains(foodObj))
      {
        state[state.indexOf(foodObj)].quantity--;
        if(state[state.indexOf(foodObj)].quantity <= 0)
          {
            state.removeAt(state.indexOf(foodObj));
          }
      }
    //state.remove(foodObj);
    emit(state.toList());
  }
}
