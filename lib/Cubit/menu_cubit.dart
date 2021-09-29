import 'package:bloc/bloc.dart';
import 'package:foodtest/API/get_food_items.dart';
import 'package:foodtest/Model/FoodListModel.dart';
import 'package:meta/meta.dart';

part 'menu_state.dart';


class MenuCubit extends Cubit<MenuState> {
  //final FoodListModel foodListObj;
  MenuCubit() : super(MenuInitial());

  Future getFoodList()async{
    try{
      emit(MenuLoading());
      final listOfFood = await getAllFoodItems();
      emit(MenuLoaded(listOfFood));
    }
    catch(e){
      emit(MenuError(e.toString()));
    }
  }
}
