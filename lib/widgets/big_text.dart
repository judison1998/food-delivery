import 'package:flutter/cupertino.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'dimensions.dart';
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow? overflow;

  BigText({Key? key, this.color=const Color(0xFF332d2b), required this.text,
    this.size=0,
    this.overflow=TextOverflow.ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: "robonto",
        fontSize: Dimensions.font20,
      ),
    );
  }
}
