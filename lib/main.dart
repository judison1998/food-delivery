import 'package:api_project/controllers/cat_controller.dart';
import 'package:api_project/pages/cart/cart_page.dart';
import 'package:api_project/pages/home/food_page_body.dart';
import 'package:api_project/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:api_project/pages/food/popular_food_details.dart';
import 'package:api_project/pages/food/recommended_foodDetails.dart';
import 'package:api_project/pages/home/main_home_page.dart';
import 'package:api_project/routes/route_helper.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<CatController>().getCartDtaa();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'food now',
          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashScreen(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
