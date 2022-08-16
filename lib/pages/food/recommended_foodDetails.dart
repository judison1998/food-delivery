import 'package:api_project/controllers/popular_product_controller.dart';
import 'package:api_project/pages/cart/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_project/colors.dart';
import 'package:api_project/controllers/recommended_product_controller.dart';
import 'package:api_project/pages/home/main_home_page.dart';
import 'package:api_project/routes/route_helper.dart';
import 'package:api_project/utils/app_constants.dart';
import 'package:api_project/widgets/app_icon_class.dart';
import 'package:api_project/widgets/big_text.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../controllers/cat_controller.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetails({Key? key, required this.pageId,required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
        Get.find<PopularProductController>().initProduct(product, Get.find<CatController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
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
                //AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child: BigText(
                          size: Dimensions.font26, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                )),
            backgroundColor: AppColors.yellowcolor,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpendableText(
                    text: product.description!,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:GetBuilder<PopularProductController>(builder: (controller){
        return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      backgroundcolor: AppColors.maincolor,
                      icon: Icons.remove,
                      iconsize: Dimensions.iconsize24,
                      iconcolor: Colors.white,
                    ),
                  ),
                  BigText(
                    text: "\$ ${product.price}  X  ${controller.inCatItems}+ ",
                    color: AppColors.maincolor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      backgroundcolor: AppColors.maincolor,
                      icon: Icons.add,
                      iconsize: Dimensions.iconsize24,
                      iconcolor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius30)),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.maincolor,
                      )),
                GestureDetector(
                  onTap: (){
                    controller.addItem(product);

                  },
                  child:   Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: BigText(
                      text: "\$ ${product.price!} add to cart",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.maincolor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20)),
                  ),
                )
                ],
              ),
            ),
          ],
        );

      }),
    );
  }
}
