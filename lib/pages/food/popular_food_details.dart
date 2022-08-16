import 'package:api_project/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:api_project/controllers/cat_controller.dart';
import 'package:api_project/controllers/popular_product_controller.dart';
import 'package:api_project/pages/home/main_home_page.dart';
import 'package:api_project/utils/app_constants.dart';
import 'package:api_project/widgets/app_column.dart';
import 'package:api_project/widgets/app_icon_class.dart';
import 'package:api_project/widgets/big_text.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../colors.dart';
import '../../routes/route_helper.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
    Get.find<PopularProductController>().PopularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CatController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(top: 23),
                  width: double.maxFinite,
                  height: Dimensions.popularFoodimgSize,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!),
                          fit: BoxFit.cover)),
                )),
            //icon widgets
            Positioned(
                left: Dimensions.width10,
                right: Dimensions.width10,
                child: Container(
                  margin: EdgeInsets.only(top: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(page =="cartpage"){
                             Get.toNamed(RouteHelper.getCartPage());
                          }
                          else{
                            Get.toNamed(RouteHelper.getInitial());
                          }
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios),
                      ),
                      GetBuilder<PopularProductController>(builder: (controller){
                        return GestureDetector(
                          onTap: (){
                            if(controller.totalItems>=1)
                             Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: Stack(
                            children: [
                              AppIcon(icon: Icons.shopping_cart_outlined),
                              controller.totalItems>=1?
                              Positioned(
                                right:0, top:0,
                              
                                  child: AppIcon(icon: Icons.circle,size: 20,
                                    iconcolor: Colors.transparent, backgroundcolor: AppColors.maincolor,),

                              ):
                              Container(),
                              Get.find<PopularProductController>().totalItems>=1?
                              Positioned(
                                right:3, top:3,
                                child:BigText(text: Get.find<PopularProductController>().totalItems.toString()
                                 ,size: 12, color: Colors.white,
                                  )
                              ):
                              Container()

                            ],
                          ),
                        );
                      })


                    ],
                  ),
                )),
            //introduction of food
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.popularFoodimgSize,
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius30),
                        topLeft: Radius.circular(Dimensions.radius30)),
                    color: Colors.white30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //expandable text
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpendableText(
                                text: product.description!,
                              ))),
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(builder:(popularProduct){
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
              child: Row(
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
                        borderRadius: BorderRadius.circular(Dimensions.radius30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              popularProduct.setQuantity(false);
                            },
                            child: Icon(Icons.remove, color: AppColors.signcolor)
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(text: popularProduct.inCatItems.toString()),
                        SizedBox(width: Dimensions.width10/2,),
                        GestureDetector(
                            onTap: (){
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(Icons.add, color: AppColors.signcolor)
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        popularProduct.addItem(product);
                      },
                      child:  Container(

                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                        text: "\$ ${product.price} add to cart",
                        color: Colors.white,
                      ),
                    decoration: BoxDecoration(
                        color: AppColors.maincolor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20)),
                  )
                  )
                ],
              ));

        },
        )
    );
  }
}
