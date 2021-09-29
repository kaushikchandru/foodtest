import 'package:meta/meta.dart';
import 'dart:convert';

List<FoodListModel> foodListModelFromJson(String str) => List<FoodListModel>.from(json.decode(str).map((x) => FoodListModel.fromJson(x)));

String foodListModelToJson(List<FoodListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodListModel {
  FoodListModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.tableId,
    required this.tableName,
    required this.branchName,
    required this.nexturl,
    required this.tableMenuList,
  });

  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;
  final String tableId;
  final String tableName;
  final String branchName;
  final String nexturl;
  final List<TableMenuList> tableMenuList;

  factory FoodListModel.fromJson(Map<String, dynamic> json) => FoodListModel(
    restaurantId: json["restaurant_id"],

    restaurantName: json["restaurant_name"],
    restaurantImage: json["restaurant_image"],
    tableId: json["table_id"],
    tableName: json["table_name"],
    branchName: json["branch_name"],
    nexturl: json["nexturl"],
    tableMenuList: List<TableMenuList>.from(json["table_menu_list"].map((x) => TableMenuList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurant_id": restaurantId,
    "restaurant_name": restaurantName,
    "restaurant_image": restaurantImage,
    "table_id": tableId,
    "table_name": tableName,
    "branch_name": branchName,
    "nexturl": nexturl,
    "table_menu_list": List<dynamic>.from(tableMenuList.map((x) => x.toJson())),
  };
}

class TableMenuList {
  TableMenuList({
    required this.menuCategory,
    required this.menuCategoryId,
    required this.menuCategoryImage,
    required this.nexturl,
    required this.categoryDishes,
  });

  final String menuCategory;
  final String menuCategoryId;
  final String menuCategoryImage;
  final String nexturl;
  final List<CategoryDish> categoryDishes;

  factory TableMenuList.fromJson(Map<String, dynamic> json) => TableMenuList(
    menuCategory: json["menu_category"],
    menuCategoryId: json["menu_category_id"],
    menuCategoryImage: json["menu_category_image"],
    nexturl: json["nexturl"],
    categoryDishes: List<CategoryDish>.from(json["category_dishes"].map((x) => CategoryDish.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "menu_category": menuCategory,
    "menu_category_id": menuCategoryId,
    "menu_category_image": menuCategoryImage,
    "nexturl": nexturl,
    "category_dishes": List<dynamic>.from(categoryDishes.map((x) => x.toJson())),
  };
}

class AddonCat {
  AddonCat({
    required this.addonCategory,
    required this.addonCategoryId,
    required this.addonSelection,
    required this.nexturl,
    required this.addons,
  });

  final String addonCategory;
  final String addonCategoryId;
  final int addonSelection;
  final String nexturl;
  final List<CategoryDish> addons;

  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
    addonCategory: json["addon_category"],
    addonCategoryId: json["addon_category_id"],
    addonSelection: json["addon_selection"],
    nexturl: json["nexturl"],
    addons: List<CategoryDish>.from(json["addons"].map((x) => CategoryDish.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "addon_category": addonCategory,
    "addon_category_id": addonCategoryId,
    "addon_selection": addonSelection,
    "nexturl": nexturl,
    "addons": List<dynamic>.from(addons.map((x) => x.toJson())),
  };
}

class CategoryDish {
  CategoryDish({
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.dishImage,
    required this.dishCurrency,
    required this.dishCalories,
    required this.dishDescription,
    required this.dishAvailability,
    required this.dishType,
    required this.nexturl,
    required this.addonCat,
  });

  final String dishId;
  final String dishName;
  final double dishPrice;
  final String dishImage;
  final String dishCurrency;
  final double dishCalories;
  final String dishDescription;
  final bool dishAvailability;
  final int dishType;
  final String nexturl;
  final List<AddonCat>? addonCat;

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
    dishId: json["dish_id"],
    dishName: json["dish_name"],
    dishPrice: json["dish_price"].toDouble(),
    dishImage: json["dish_image"],
    dishCurrency: json["dish_currency"],
    dishCalories: json["dish_calories"],
    dishDescription: json["dish_description"],
    dishAvailability: json["dish_Availability"],
    dishType: json["dish_Type"],
    nexturl: json["nexturl"] == null ? "" : json["nexturl"],
    addonCat: json["addonCat"] == null ? null : List<AddonCat>.from(json["addonCat"].map((x) => AddonCat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dish_id": dishId,
    "dish_name": dishName,
    "dish_price": dishPrice,
    "dish_image": dishImage,
    "dish_currency": dishCurrency,
    "dish_calories": dishCalories,
    "dish_description": dishDescription,
    "dish_Availability": dishAvailability,
    "dish_Type": dishType,
    "nexturl": nexturl == null ? null : nexturl,
    "addonCat": addonCat == null ? null : List<dynamic>.from(addonCat!.map((x) => x.toJson())),
  };
}