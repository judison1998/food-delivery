import 'package:flutter/material.dart';
import 'package:api_project/colors.dart';
import 'package:api_project/controllers/popular_product_controller.dart';
import 'package:api_project/controllers/recommended_product_controller.dart';
import 'package:api_project/routes/route_helper.dart';
import 'package:api_project/utils/app_constants.dart';
import 'package:api_project/widgets/app_column.dart';
import 'package:api_project/widgets/big_text.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/icon_and_text_widget.dart';
import 'package:api_project/widgets/small_text.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:api_project/models/popular_product_model.dart';

class FoodPageBordy extends StatefulWidget {
  const FoodPageBordy({Key? key}) : super(key: key);
  @override
  State<FoodPageBordy> createState() => _FoodPageBordyState();
}

class _FoodPageBordyState extends State<FoodPageBordy> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currtPageValue = 0.0;
  double _currScaleFactor = 0.8;
  double _height = 220;
  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currtPageValue = pageController.page!;
        // print("current value is "+ _currtPageValue.toString());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isloaded
              ? Container(
                  height: Dimensions.pageViiew,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.PopularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.PopularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.maincolor,
                );
        }),
        SizedBox(
          height: Dimensions.height20,
        ),
        //popular text
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Recommended",
                size: Dimensions.font20,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                child: SmallText(
                  text: "food pairing",
                ),
              ),
            ],
          ),
        ),
        //list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isloaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        //Get.to(RecommendedFoodDetails);
                        Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                        // Get.to(() => PopularFoodDetails(pageId: 3,));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height15),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width: 100,
                              height: Dimensions.listviewimgSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white30,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              recommendedProduct
                                                  .recommendedProductList[index]
                                                  .img!))),
                            ),
                            //text section
                            Expanded(
                              child: Container(
                                height: Dimensions.listviewtxtcontainerSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                )),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      SmallText(text: "mbale characteristics"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        children: [
                                          IconAndText(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconcolor: AppColors.iconcolor1),
                                          IconAndText(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconcolor: AppColors.maincolor),
                                          IconAndText(
                                              icon: Icons.access_time_rounded,
                                              text: "1.7km",
                                              iconcolor: AppColors.iconcolor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.maincolor,
                );
        }),
      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currtPageValue.floor()) {
      var currScale = 1 - (_currtPageValue - index) + (1 - _currScaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currtPageValue.floor() + 1) {
      var currScale = _currScaleFactor +
          (_currtPageValue - index + 1) +
          (1 - _currScaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currtPageValue.floor() - 1) {
      var currScale = 1 - (_currtPageValue - index) + (1 - _currScaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.0;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _currScaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index,"home"));
          },
          child: Container(
            height: Dimensions.pageViiewContainer,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProduct.img!)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViiewTextContainer,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 1.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                ]),
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 8, right: 5),
              child: AppColumn(text: popularProduct.name!),
            ),
          ),
        ),
      ]),
    );
  }
}
