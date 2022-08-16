import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cat_model.dart';
import '../../utils/app_constants.dart';

class CatRepo{
final SharedPreferences  sharedPreferences;
CatRepo({required this.sharedPreferences});
List<String> cart=[];
List<String> cartHistory = [];
void addToCartList(List<CatModel> cartList){

//sharedPreferences.remove(AppConstants.CART_LIST);
//sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  cart=[];
var time = DateTime.now().toString();
//converting object to string because sharedprefferencces only storers  strings
cartList.forEach((element){
  element.time = time;
  return cart.add(jsonEncode(element));
});
sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
print(sharedPreferences.getStringList("AppConstants.CART_LIST"));
}
List<CatModel> getCartList(){
  List<String>? carts = [];
  if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
    carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
     print("inside getcartList "+carts.toString());
  }
  List<CatModel> cartList=[];
  carts!.forEach((element)=>cartList.add(CatModel.fromJson(jsonDecode(element))));
  return cartList;
}
List<CatModel> getCartHistoryList(){
  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
    cartHistory=[];
    cartHistory= sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
  }
  List<CatModel> cartListHistory = [];
  cartHistory.forEach((element)=>cartListHistory.add(CatModel.fromJson(jsonDecode(element))));
  return cartListHistory;
}
void addToCartHistoryList(){
  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
    cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;

  }
  for(int i = 0; i<cart.length; i++){
    print("history list "+cart[i]);
     cartHistory.add(cart[i]);
  }
    removeCart();
  sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  for(int i =0; i<getCartHistoryList().length;i++){

  }
}
void removeCart(){
  cart=[];
  sharedPreferences.remove(AppConstants.CART_LIST);

}
}
