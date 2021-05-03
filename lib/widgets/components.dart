import 'package:flutter/material.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  // String hinttext,
  @required String title,
  TextInputType inputtype,
  Function onfieldsubmit,
  @required Function validate,
  @required IconData prefixicon,
  IconData suffixicon,
  Function ontapfunction,
}) =>
    TextFormField(
      onTap: ontapfunction,
      validator: validate,
      maxLines: 1,
      controller: controller,
      keyboardType: inputtype,
      onFieldSubmitted: onfieldsubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixicon),
        suffixIcon: Icon(suffixicon),
        //  hintText: hinttext,
        border: OutlineInputBorder(),
        labelText: title,
      ),
    );
