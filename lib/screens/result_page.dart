import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  final double resultBMI;
  final String resultLabel;
  final Color resultLabelColor;
  final String resultText;

  ResultPage({
    @required this.resultBMI,
    @required this.resultLabel,
    @required this.resultLabelColor,
    @required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('appTitle'.tr()),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.all(25),
                child: Text(
                  'resultTitle'.tr(),
                  style: kResultTitleTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ReusableCard(
                cardColor: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      resultLabel.toUpperCase(),
                      style:
                          kResultLabelTextStyle.apply(color: resultLabelColor),
                    ),
                    Text(
                      resultBMI.toString(),
                      style: kBMITextStyle,
                    ),
                    Text(
                      resultText,
                      style: kBodyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              buttonTitle: 're-calculate'.tr(),
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
