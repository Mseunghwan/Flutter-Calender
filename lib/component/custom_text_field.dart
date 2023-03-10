import 'package:calender_schedular/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true면 시간, false면 내용 --> only digits 적용 구분해줄라고
  final bool isTime;


  const CustomTextField({
    required this.label,
    required this.isTime,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label
        ,style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),),
        if(isTime) renderTextField(),
        if(!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField(){
   return  TextField(
     maxLines: isTime? 1 : null, // 줄 내려갈 수 있게
     expands: isTime? false : true, // 내용이 최대한 사이즈로 보여주게
     keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
     inputFormatters: isTime? [
       FilteringTextInputFormatter.digitsOnly, // 숫자만 들어갈 수 있도록
     ] : [],
     cursorColor: Colors.grey,
     decoration: InputDecoration(
       border: InputBorder.none,
       filled: true,
       fillColor: Colors.grey[300],
     ),
   );
  }
}
