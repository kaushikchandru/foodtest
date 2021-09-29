part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState{
  MenuLoading();
}

class MenuLoaded extends MenuState{
  final FoodListModel foodListObj;
  MenuLoaded(this.foodListObj);
}

class MenuError extends MenuState{
  final String message;
  MenuError(this.message);
}