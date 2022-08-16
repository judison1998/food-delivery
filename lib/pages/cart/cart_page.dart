import 'package:api_project/base/no_data_page.dart';
import 'package:api_project/colors.dart';
import 'package:api_project/controllers/cat_controller.dart';
import 'package:api_project/pages/cart/cart_history_list.dart';
import 'package:api_project/pages/home/main_home_page.dart';
import 'package:api_project/utils/app_constants.dart';
import 'package:api_project/widgets/app_icon_class.dart';
import 'package:api_project/widgets/big_text.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconcolor: Colors.white,
                      backgroundcolor: AppColors.maincolor,
                      iconsize: Dimensions.iconsize24,
                    ),
                    SizedBox(
                      width: Dimensions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconcolor: Colors.white,
                        backgroundcolor: AppColors.maincolor,
                        iconsize: Dimensions.iconsize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconcolor: Colors.white,
                      backgroundcolor: AppColors.maincolor,
                      iconsize: Dimensions.iconsize24,
                    )
                  ],
                )),
           GetBuilder<CatController>(builder: (_cartController){
            return _cartController.getItems.length>0? Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CatController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin:
                                EdgeInsets.only(top: Dimensions.height15),
                                width: double.maxFinite,
                                height: Dimensions.height20 * 5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                        Get.find<PopularProductController>()
                                            .PopularProductList
                                            .indexOf(
                                            _cartList[index].product!);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex, 'cartpage'));
                                        } else {
                                          var recommendedIndex = Get.find<
                                              RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                              _cartList[index].product!);
                                          if(recommendedIndex<0){
                                            Get.snackbar(
                                              "history product",
                                              "product preview is not available for history products",
                                              backgroundColor: AppColors.maincolor,
                                              colorText: Colors.white,
                                            );
                                          }
                                          else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartPage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        width: Dimensions.width20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                    .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!)),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.height10,
                                    ),
                                    Expanded(
                                        child: Container(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: "spicy"),
                                              Row(
                                                children: [
                                                  BigText(
                                                      text: cartController
                                                          .getItems[index].price
                                                          .toString(),
                                                      color: Colors.redAccent),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions.height10,
                                                        bottom: Dimensions.height10,
                                                        left: Dimensions.width10,
                                                        right: Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius30)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartController
                                                                  .addItem(
                                                                  _cartList[
                                                                  index]
                                                                      .product!,
                                                                  -1);
                                                              // popularProduct.setQuantity(false);
                                                            },
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signcolor)),
                                                        SizedBox(
                                                          width:
                                                          Dimensions.width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[index]
                                                                .quantity
                                                                .toString()), //popularProduct.inCatItems.toString()),
                                                        SizedBox(
                                                          width:
                                                          Dimensions.width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartController
                                                                  .addItem(
                                                                  _cartList[
                                                                  index]
                                                                      .product!,
                                                                  1);

                                                              //popularProduct.setQuantity(true);
                                                            },
                                                            child: Icon(Icons.add,
                                                                color: AppColors
                                                                    .signcolor)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                )):NoDataPage(text: "your cart is empty");

           })
          ],
        ),
        bottomNavigationBar: GetBuilder<CatController>(
          builder: (cartController) {
            return Container(
                height: Dimensions.bottomheight,
                margin: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonbackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30),
                    )),
                child: cartController.getItems.length>0?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(
                              text: "\$ " +
                                  cartController.totalAmount.toString()),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          cartController.addToHistory();
                          Get.to(CartHistory());
                          // popularProduct.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          child: BigText(
                            text: "CHECK OUT",
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.maincolor,
                              borderRadius:
                              BorderRadius.circular(Dimensions.radius20)),
                        ))
                  ],
                ):Container());
          },
        ));
  }
}
