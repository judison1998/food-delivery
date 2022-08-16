
import 'package:api_project/controllers/cat_controller.dart';
import 'package:api_project/controllers/popular_product_controller.dart';
import 'package:api_project/controllers/recommended_product_controller.dart';
import 'package:api_project/data/api/api_client.dart';
import 'package:api_project/data/repository/cat_repo.dart';
import 'package:api_project/data/repository/popular_product_repo.dart';
import 'package:api_project/data/repository/recommended_product_repo.dart';
import 'package:api_project/utils/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async {
  final sharedPreferences = await  SharedPreferences.getInstance();
   Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));
//repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CatRepo(sharedPreferences:Get.find()));

// controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find(), ));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CatController(catRepo: Get.find()));

}