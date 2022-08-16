
import 'package:flutter/material.dart';
import 'package:api_project/colors.dart';
import 'package:api_project/controllers/cat_controller.dart';
import 'package:api_project/data/repository/popular_product_repo.dart';
import 'package:api_project/models/popular_product_model.dart';
import 'package:get/get.dart';

import '../models/cat_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get PopularProductList => _popularProductList;
  late CatController _cart;
  bool _isloaded = false;
  bool get isloaded => _isloaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCatItems = 0;
  int get inCatItems => _inCatItems + _quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isloaded = true;
      update();
    } else {
      print("got no products");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity-1);
      print("decrement" + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCatItems+quantity) < 0) {
      Get.snackbar(
        "item count",
        "you can't reduce any more!",
        backgroundColor: AppColors.maincolor,
        colorText: Colors.white,
      );
      if(_inCatItems>0){
        _quantity = -_inCatItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCatItems + quantity) > 20) {
      Get.snackbar(
        "item count",
        "you can't add any more!",
        backgroundColor: AppColors.maincolor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }
  void initProduct(ProductModel product, CatController cat) {
    _quantity = 0;
    _inCatItems = 0;
    _cart = cat;
    var exist = false;
    exist = _cart.existInCart(product);
  //  print("exist or not " + exist.toString());
    if (exist) {
      _inCatItems = _cart.getQuantity(product);
    }
   // print("the quantity in cart = " + _inCatItems.toString());

    //if exist
    //get from storage _inCatItems
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCatItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("the id is " +
          value.id.toString() +
          "quantity is " +
          value.quantity.toString());
    });
    update();
  }
  int get totalItems{
    return _cart.totalItems;
  }
  List<CatModel> get getItems{
    return _cart.getItems;
  }
}
