part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {
  final List<FoodWidgetModel> foodWidgetObj;
  CartInitial(this.foodWidgetObj);
}

