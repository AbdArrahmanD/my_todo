import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/controllers/controller.dart';
import 'package:my_todo/views/widgets/theme.dart';

class NotificationScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      centerTitle: true,
      title: Text(controller.payLoad.value.split('|')[0]),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
    );

    final screenHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'You Have New Notification',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.format_color_text_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                  ),
                  Container(
                    height: screenHeight / 1.4,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: primaryClr,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: const [
                              Icon(
                                Icons.description,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            controller.payLoad.value.split('|')[1],
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 13),
                        const Text(
                          'Date : ',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.payLoad.value.split('|')[2],
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                  ),
                ],
              ),
            ),
            //SizedBox(height: screenHeight * 0.009),
          ],
        ),
      ),
    );
  }
}
