import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screens/account_profile.dart';
import 'custom_button.dart';

Widget customdialog1(context, {String? text}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Personal Details Required!"
            .text
            .bold
            .size(18)
            .color(Vx.gray800)
            .make(),
        const Divider(),
        10.heightBox,
        "We noticed that you have not linked your $text, which is required to give a suggestion.Would you like to link it now"
            .text
            .size(16)
            .color(Vx.gray800)
            .make(),
        10.heightBox,
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            customButton(
                color: Colors.green,
                onPress: () {
                  Get.offAll(() => AccountProfile());
                },
                textColor: Colors.white,
                title: "Go to Account Screen"),
            20.widthBox,
            customButton(
                color: Colors.green,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                title: "Not now"),
          ],
        ),
      ],
    ).box.color(Vx.gray100).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}

Widget customdialog(context, {String? text}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Personal Details Required!"
            .text
            .bold
            .size(18)
            .color(Vx.gray800)
            .make(),
        const Divider(),
        10.heightBox,
        "We noticed that you have not linked your $text, which is required to give a quotation.Would you like to link it now"
            .text
            .size(16)
            .color(Vx.gray800)
            .make(),
        10.heightBox,
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            customButton(
                color: Colors.green,
                onPress: () {
                  Get.offAll(() => AccountProfile());
                },
                textColor: Colors.white,
                title: "Go to Account Screen"),
            20.widthBox,
            customButton(
                color: Colors.green,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                title: "Not now"),
          ],
        ),
      ],
    ).box.color(Vx.gray100).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
