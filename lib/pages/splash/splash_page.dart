import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  _loadResources()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await  Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState() {
   _loadResources();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2))
      ..forward();
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut);
    Timer(
    Duration(seconds: 3),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
                scale: animation,
                child: Center(child: Image.asset("Images/food_logo.jpg",
                  width: Dimensions.splashImg,))),
               Center(child: Text("ENJOY YOUR FAVOURITE MEAL")),



      ],
        ),
      );
    }
  }


