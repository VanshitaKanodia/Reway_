import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../services/googlesheets.dart';
import '../services/sheetscolums.dart';

// ignore: must_be_immutable
class SuggestionScreen extends StatefulWidget {
  var data;
  SuggestionScreen({super.key, this.data});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  double currentValue = 0.0;
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Vx.gray700,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        title: "Feedback".text.gray700.size(18).make(),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        style: TextStyle(color: Vx.gray600, fontSize: 18),
                        children: [
                      TextSpan(
                          text: "Company Name: ",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: "${widget.data['Recycler_Name']}")
                    ])),
              ],
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        style: TextStyle(color: Vx.gray600, fontSize: 18),
                        children: [
                      TextSpan(
                          text: "Email id: ",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: "${widget.data['Email']}")
                    ])),
              ],
            ),
            20.heightBox,
            TextField(
              controller: nameController,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1, horizontal: 40),
                hintText: 'Enter your name',
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            20.heightBox,
            TextField(
              controller: designationController,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1, horizontal: 40),
                hintText: 'Enter Your designation in the company',
                labelText: 'Designation',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            20.heightBox,
            TextField(
              controller: subjectController,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1, horizontal: 40),
                hintText: 'Enter subject',
                labelText: 'Subject',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            20.heightBox,
            TextField(
              controller: feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                hintText: 'Enter your Query/suggestion here',
                labelText: ' Query/suggestion ',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rating :",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Vx.gray700,
                      fontSize: 16),
                ),
                VxRating(
                  isSelectable: true,
                  value: currentValue,
                  maxRating: 5,
                  onRatingUpdate: (value) {
                    currentValue = double.parse(value);
                  },
                  normalColor: Vx.gray200,
                  selectionColor: Vx.green500,
                ),
              ],
            ),
            20.heightBox,
            ElevatedButton(
                onPressed: () async {
                  final feedBack = {
                    SheetsColumn.name: nameController.text.toString(),
                    SheetsColumn.Email: "${widget.data['Email']}",
                    SheetsColumn.companyName: "${widget.data['Recycler_Name']}",
                    SheetsColumn.designation:
                        designationController.text.toString(),
                    SheetsColumn.subject: subjectController.text.toString(),
                    SheetsColumn.feedback: feedbackController.text.toString(),
                    SheetsColumn.rating: currentValue.toString(),
                  };

                  await SheetsFlutter.insert([feedBack]);
                  VxToast.show(context, msg: "Feedback Submitted");
                  nameController.text = '';
                  designationController.text = '';
                  subjectController.text = '';
                  feedbackController.text = '';
                },
                child: "Submit".text.make())
          ],
        ),
      )),
    );
  }
}
