import 'dart:convert';

import 'package:api_project/colors.dart';
import 'package:api_project/controllers/cat_controller.dart';
import 'package:api_project/models/cat_model.dart';
import 'package:api_project/utils/app_constants.dart';
import 'package:api_project/widgets/app_icon_class.dart';
import 'package:api_project/widgets/big_text.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../routes/route_helper.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CatController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index){{
      var outPutDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseData =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(
            getCartHistoryList[listCounter].time!);
        var inputDate =
        DateTime.parse(parseData.toString());
        var outPutFormat = DateFormat('MM/dd/yyyy hh:mm a');
        DateFormat("MM/DD/yyyy hh:mm a");
         outPutDate = outPutFormat.format(inputDate);

      }
      return BigText(text: outPutDate);


    }
    }
    return Scaffold(
        body: Column(children: [
      Container(
        color: AppColors.maincolor,
        width: double.maxFinite,
        padding: EdgeInsets.only(top: Dimensions.height45),
        height: Dimensions.height10 * 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: "CART HISTORY"),
            AppIcon(
              icon: Icons.shopping_cart_outlined,
              backgroundcolor: AppColors.yellowcolor,
              iconcolor: AppColors.maincolor,
            ),
          ],
        ),
      ),
      GetBuilder<CatController>(builder: (_cartController){
       return _cartController.getCartHistoryList().length>0?
        Expanded(
          child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: Dimensions.height30 * 4,
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),

                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                    direction: Axis.horizontal,
                                    children:
                                    List.generate(itemsPerOrder[i], (index) {
                                      if (listCounter <
                                          getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      return index >=2
                                          ? Container(
                                        height: Dimensions.height20 * 4,
                                        width: Dimensions.width20 * 4,
                                        margin: EdgeInsets.only(
                                            right: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                Dimensions.radius20 /
                                                    2),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants
                                                          .UPLOAD_URL +
                                                      getCartHistoryList[
                                                      listCounter]
                                                          .img!),
                                            )),
                                      )
                                          : Container();
                                    })),
                                Container(
                                  height: Dimensions.height20 * 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SmallText(
                                        text: "Total",
                                        color: AppColors.titlecolor,
                                      ),
                                      BigText(
                                        text: itemsPerOrder[i].toString() +
                                            " items",
                                        color: AppColors.titlecolor,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CatModel> moreOrder = {};
                                          for(int j=0; j<getCartHistoryList.length; j++){
                                            if(getCartHistoryList[j].time==orderTime[i]){
                                              print("my order is "+orderTime[i]);
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                  CatModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                              );

                                            }
                                          }
                                          Get.find<CatController>().setItems = moreOrder;
                                          Get.find<CatController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions.width10,
                                              vertical: Dimensions.height10 / 2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  Dimensions.radius20 / 3),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.maincolor)),
                                          child: SmallText(
                                            text: "one more",
                                            color: AppColors.maincolor,
                                          ),

                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              )),
        ):
       Container(
         height: MediaQuery.of(context).size.height/1.5,
           child: NoDataPage(text:"you did not buy anything",imgPath: "Images/food_logo.jpg",));
      })
    ]));
  }
}
