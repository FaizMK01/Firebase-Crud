import 'package:flutter/material.dart';

class Reusable{

  //ToastMessage
  static toastMessage(String message,context,int second,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: second),
      backgroundColor: color,

    ));
  }

  //TexFormField
  static Widget textField(TextEditingController controller,String labelText, {String? Function(String?)? validator,TextInputType? type}){
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
        const TextStyle(color: Colors.black54, fontSize: 18),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: 16),
        //notselected textfield color show
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        //click textfield color show
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.greenAccent.shade100, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
          BorderSide(color: Colors.redAccent, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),

      // textColor
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  //ElevatedButton

  static Widget elevatedButton(String text,Color bgColor,Color fgColor,{required void Function()? onTap}){
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor
      ),
      child:  Text(text),
    );

  }

  static Widget text(String message,double size,{Color? color}){
    return Text(message,style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color

    ),);
  }


}