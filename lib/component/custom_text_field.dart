import 'package:calender_schedular/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true면 시간, false면 내용 --> only digits 적용 구분해줄라고
  final bool isTime;
  final FormFieldSetter<String> onSaved;


  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
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
   return  TextFormField(
   onSaved: onSaved,

     validator: (String? val){
      // Null이 리턴되면 에러가 없다
      // 에러가 있으면 에러를 string값으로 리턴해준다
       if(val == null || val.isEmpty){
         return '값을 입력해주세요';
       }
       if(isTime){
         // String val을 int로 변환
         int time = int.parse(val);

         if(time < 0){
           return '0 이상의 숫자를 입력해주세요';
         }

         if(time > 24){
           return '24 이하의 숫자를 입력해주세요';
         }
       }else{
        if(val.length > 500){
          return '500자 이하의 글자를 입력해주세요.';
        }
       }

       return null;
     },
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
