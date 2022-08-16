import 'package:api_project/data/repository/cat_repo.dart';
import 'package:api_project/models/cat_model.dart';
import 'package:api_project/models/popular_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
class CatController extends GetxController {
  final CatRepo catRepo;
  CatController({required this.catRepo});
  Map<int, CatModel> _items = {  };
  Map<int, CatModel> get items => _items;
  // only for storage and shared preferences
  List<CatModel> storageItems=[];
  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CatModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          _items.forEach((key, value) {
            print('quantity is' + value.quantity.toString());
          });
          return CatModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product
          );
        });
      } else {
        Get.snackbar(
          "item count",
          "you should atleast add one item in the cart",
          backgroundColor: AppColors.maincolor,
          colorText: Colors.white,
        );
      }
    }
    catRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }
   int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity+=value.quantity!;

    });
    return totalQuantity;
  }
List<CatModel> get getItems{
   return _items.entries.map((e){
     return e.value;
    }).toList();
}
int get totalAmount{
    var total=0;
    _items.forEach((key, value) {
      total = value.quantity!*value.price!;

    });
  return total;
}
List<CatModel> getCartDtaa(){
setCart= catRepo.getCartList();
return storageItems;
}
set setCart(List<CatModel> items){
  storageItems= items;
    for(int i = 0; i<storageItems.length; i++){

_items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);

    }

}
void addToHistory(){
    catRepo.addToCartHistoryList();
    clear();

}

  void clear() {
    _items = {};
    update();
  }
  List<CatModel> getCartHistoryList(){
    return catRepo.getCartHistoryList();
  }
  set setItems(Map<int, CatModel> setItems){
    _items={};
    _items = setItems;

  }
  void addToCartList(){
    catRepo.addToCartList(getItems);
    update();
  }

}

