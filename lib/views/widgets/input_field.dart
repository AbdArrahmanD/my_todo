import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart';
import '../../models/themes.dart';

ThemeController homeController = Get.put(ThemeController());

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.widget,
      this.controller})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title, style: titleStyle()),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    width: 1,
                    color: homeController.theme.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  )),
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: widget != null ? true : false,
                      autofocus: false,
                      controller: controller,
                      cursorColor: homeController.theme.value == ThemeMode.dark
                          ? Colors.grey[100]
                          : Colors.grey[700],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: subTitleStyle(),
                      ),
                    ),
                  ),
                  widget ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
