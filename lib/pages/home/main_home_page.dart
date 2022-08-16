
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_project/colors.dart';
import 'package:api_project/widgets/big_text.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/small_text.dart';


import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "UGANDA",color: AppColors.maincolor,size: Dimensions.font20,),
                      Row(
                        children: [
                          SmallText(text: "MBALE",color: Colors.black,size: Dimensions.font15,),
                          Icon(Icons.arrow_drop_down),
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      child: Icon(Icons.search,color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.maincolor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: FoodPageBordy(),
              )),
        ],
      ),


    );

  }
}
