import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtest/Cubit/cart_cubit.dart';
import 'package:foodtest/Cubit/menu_cubit.dart';
import 'package:foodtest/Model/FoodWidgetModel.dart';
import 'package:foodtest/Pages/cart_page.dart';
import 'package:foodtest/Pages/drawer_page.dart';
import 'package:foodtest/Widgets/food_widget.dart';
import 'package:foodtest/helpers/color_scheme.dart';
import 'package:foodtest/helpers/text_scheme.dart';

class UserHome extends StatefulWidget {
  static const pageName = "/userHome";

  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var menuCubit = MenuCubit();
  var cartCubit = CartCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuCubit.getFoodList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      bloc: menuCubit,
      builder: (context, state) {
        if(state is MenuLoaded)
          {
            return DefaultTabController(
              length: state.foodListObj.tableMenuList.length,
              child: Scaffold(
                  key: scaffoldKey,
                  appBar: AppBar(
                      brightness: Brightness.light,
                      backgroundColor: Colors.white,
                      elevation: 5,
                      leading: IconButton(
                        icon: Icon(Icons.menu, color: newBlack,),
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      actions: [
                        BlocBuilder<CartCubit, List<FoodWidgetModel>>(
                          bloc: cartCubit,
                          builder: (context, state) {
                           return Stack(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>CartPage(cartCubit: cartCubit)));
                                    },
                                    icon: Icon(Icons.shopping_cart_rounded, color: newBlack)),
                                Positioned(
                                  right: 0,
                                    top: 0,

                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle
                                      ),
                                        child: Text(state.length.toString()))
                                ),
                              ],
                            );
                          },
                        )
                      ],
                      bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: newPink,
                        labelColor: newPink,
                        labelStyle: contentText,
                        unselectedLabelColor: newBlack,
                        unselectedLabelStyle: contentText,
                        tabs:
                          List.generate(state.foodListObj.tableMenuList.length, (index){
                           return Tab(text: state.foodListObj.tableMenuList[index].menuCategory,);
                          }),
                      )
                  ),
                  drawer: Drawer(
                    child: DrawerPage(),
                  ),
                  body: TabBarView(
                    children:  List.generate(state.foodListObj.tableMenuList.length, (index){
                      var tempObj = state.foodListObj.tableMenuList[index];
                      return ListView.builder(
                        itemCount: tempObj.categoryDishes.length,
                        itemBuilder: (context, index1){
                          bool customAvailable = false;
                          if(tempObj.categoryDishes[index1].addonCat!.length > 1)
                            {
                              customAvailable = true;
                            }
                          return FoodWidget(
                              foodWidgetObj: FoodWidgetModel(
                                  dishType: tempObj.categoryDishes[index1].dishType,
                                  imageUrl: tempObj.categoryDishes[index1].dishImage,
                                  title: tempObj.categoryDishes[index1].dishName,
                                  price: tempObj.categoryDishes[index1].dishPrice,
                                  calories: tempObj.categoryDishes[index1].dishCalories,
                                  description: tempObj.categoryDishes[index1].dishDescription,
                                  quantity: 0, customisationAvailable: customAvailable), cartCubit: cartCubit,);
                        },
                      );
                    })
                  )
              ),
            );
          }
        else{
          return Scaffold(body: Center(child: CircularProgressIndicator(),));
        }

      },
    );
  }
}
