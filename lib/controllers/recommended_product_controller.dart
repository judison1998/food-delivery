
import 'package:api_project/data/repository/popular_product_repo.dart';
import 'package:api_project/data/repository/recommended_product_repo.dart';
import 'package:api_project/models/popular_product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];

  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isloaded= false;
  bool get isloaded =>_isloaded;
  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got products");
      _recommendedProductList = [];

      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductList);
      _isloaded=true;
      update();
    }
    else {
      print("not got products");
    }
  }
}


