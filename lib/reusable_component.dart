

 import 'package:flutter/material.dart';

 Widget myTextFormField({
   required TextEditingController controller,
   TextInputType textInputType = TextInputType.text,
   required FormFieldValidator <String>? validator,
   bool passwordVisible = false,
   required IconData prefixIcon,
   Widget? suffixIcon,
   required String label,
   GestureTapCallback? onTap,
   TextInputAction? textInputAction,
   TextInputType? keyboardType,
   ValueChanged<String>? onFieldSubmitted,
   obsecureText ,

 }) {
   return TextFormField(
     onTap: onTap,
     controller: controller,
     onFieldSubmitted: onFieldSubmitted,
     keyboardType: textInputType,
     textInputAction: textInputAction,
     obscureText: passwordVisible,
     validator: validator,
     decoration: InputDecoration(
         border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
         labelText: label,
         labelStyle: TextStyle(fontSize: 18),
         prefixIcon: Icon(prefixIcon,size: 22),
         suffixIcon: suffixIcon

     ),

   );
 }


 Widget myButtonWidget({
   required VoidCallback onPressed,
   required String texts,
   Color backgroundColor = Colors.blue,
   double height = 50,
   double width = 400}) {
   return ElevatedButton(
     onPressed:onPressed,
     child:Text(
         texts,style: TextStyle(
       fontSize: 18,
       fontWeight: FontWeight.bold,
     ),
         maxLines:1
     ),
     style: ElevatedButton.styleFrom(
         primary: backgroundColor,
         elevation:0,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(5),
         ),

         minimumSize: Size(width,height)),

   );
 }

