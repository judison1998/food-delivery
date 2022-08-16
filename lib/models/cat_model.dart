import 'package:api_project/models/popular_product_model.dart';

class CatModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel?   product;
  CatModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product
  });
  CatModel.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    price=json["price"];
    img=json["img"];
    quantity=json["quantity"];
    isExist=json["isExist"];
    time=json["time"];
    product=ProductModel.fromJson(json['product']);

  }
  Map<String ,dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time,
      "product":this.product!.toJson()
    };

  }
}