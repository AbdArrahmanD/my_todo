import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/models/themes.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller = TextEditingController();
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  width: 1,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                )),
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget != null ? true : false,
                    autofocus: false,
                    controller: controller,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: subTitleStyle,
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
