import 'package:flutter/material.dart';
import 'package:api_project/colors.dart';
import 'package:api_project/widgets/dimensions.dart';
import 'package:api_project/widgets/small_text.dart';

class ExpendableText extends StatefulWidget {
  final String text;
  const ExpendableText({Key? key, required this.text}) : super(key: key);
  @override
  State<ExpendableText> createState() => _ExpendableTextState();
}

class _ExpendableTextState extends State<ExpendableText> {
  late String firsthalf;
  late String secondhalf;
  bool hiddentext  = true;
  double textheight = Dimensions.screenHeight/5.63;
  // i love this meal, actually it is the best all the times
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textheight){
      firsthalf = widget.text.substring(0,textheight.toInt());
      secondhalf = widget.text.substring(textheight.toInt()+1, widget.text.length);

    }else{
      firsthalf=widget.text;
      secondhalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty?SmallText(text: firsthalf):Column(
        children: [
          SmallText(height: 1.8,color: AppColors.textcolor,size: Dimensions.font20,text: hiddentext?(firsthalf+"..."):(firsthalf+secondhalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddentext=!hiddentext;
              });
            },
            child: Row(
              children: [
                SmallText(text: "show more",color: AppColors.maincolor,),
                Icon(hiddentext?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.maincolor,),
              ],
            ),
          )
        ],
      ),

    );
  }
}
