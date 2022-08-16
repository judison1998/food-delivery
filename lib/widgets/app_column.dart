
import 'package:flutter/material.dart';
import 'package:api_project/widgets/small_text.dart';

import '../colors.dart';
import 'big_text.dart';
import 'dimensions.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star,color: AppColors.maincolor,)),
            ),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "1267"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "coments"),
          ],
        ),
        Row(
          children: [
            IconAndText(icon: Icons.circle_sharp,
                text: "Normal",
                iconcolor: AppColors.iconcolor1),
            IconAndText(icon: Icons.location_on,
                text: "1.7km", iconcolor:
                AppColors.maincolor),
            IconAndText(icon: Icons.access_time_rounded,
                text: "1.7km", iconcolor:
                AppColors.iconcolor2),
          ],
        )
      ],
    );
  }
}
