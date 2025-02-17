import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  String? hintText,
  bool isPassword = false,
  bool isShowPassword = false,
  void Function()? onSuffixIconPressed,
  Color borderColor = Colors.white,
}) {
  IconData suffixIcon =
      isShowPassword ? Icons.visibility : Icons.visibility_off;
  return TextFormField(
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    obscureText: isShowPassword,
    style: TextStyle(
      color: borderColor,
      fontSize: 18,
      decoration: TextDecoration.none,
    ),
    maxLines: 1,
    cursorColor: borderColor,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: borderColor,
        fontSize: 14,
        decoration: TextDecoration.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: onSuffixIconPressed,
              icon: Icon(
                suffixIcon,
                color: borderColor,
              ),
            )
          : null,
    ),
  );
}

Widget messageTextField({
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  String? hintText,
  void Function()? onSuffixIconPressed,
  Color borderColor = Colors.white,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    style: TextStyle(
      color: borderColor,
      fontSize: 18,
      decoration: TextDecoration.none,
    ),
    maxLines: 1,
    cursorColor: borderColor,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: borderColor,
        fontSize: 14,
        decoration: TextDecoration.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      // suffixIcon: Container(
      //   decoration: BoxDecoration(
      //     color: kPrimaryColor,
      //     borderRadius: BorderRadius.circular(40),
      //   ),
      //   child: IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.send,
      //       color: Colors.white,
      //       size: 18,
      //     ),
      //   ),
      // ),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: IconButton(
            iconSize: 20,
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: onSuffixIconPressed,
          ),
        ),
      ),
    ),
  );
}

Widget customButton(
    {bool isLoading = false,
    void Function()? onButtonPressed,
    required String title}) {
  return GestureDetector(
    onTap: onButtonPressed,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLoading ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                ),
              ),
            )
          : Center(
              child: Text(
                title,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                ),
              ),
            ),
    ),
  );
}

Widget messageContainer({
  required bool isMe,
  required String message,
}) {
  AlignmentGeometry alignment =
      isMe ? Alignment.centerRight : Alignment.centerLeft;
  Color color = isMe ? const Color.fromARGB(255, 1, 110, 199) : kPrimaryColor;
  BorderRadius borderRadius = isMe
      ? BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        )
      : BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        );
  return Align(
    alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
