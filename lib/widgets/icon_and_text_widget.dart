import 'package:flutter/material.dart';
import 'package:api_project/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconcolor;

  const IconAndText({Key? key,
    required this.icon,
    required this.text,

    required this.iconcolor}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Icon(icon,color: iconcolor,),
          SizedBox(width: 5,),
          SmallText(text: text)
        ]

    );
  }
}
