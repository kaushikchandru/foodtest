
class FoodWidgetModel{
  final int dishType;
  final String imageUrl;
  final String title;
  final double price;
  final double calories;
  final String description;
  late int quantity;
  final bool customisationAvailable;
  FoodWidgetModel(
      {
        required this.dishType,
        required this.imageUrl,
        required this.title,
        required this.price,
        required this.calories,
        required this.description,
        required this.quantity,
        required this.customisationAvailable});
}