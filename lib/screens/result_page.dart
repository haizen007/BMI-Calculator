import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultPage extends StatelessWidget {
  final Color textResultLabelColor;
  final String bmiResult;
  final String textResult;
  final String interpretation;

  ResultPage({
    @required this.textResultLabelColor,
    @required this.bmiResult,
    @required this.textResult,
    @required this.interpretation,
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
                      textResult.toUpperCase(),
                      style: kResultLabelTextStyle.apply(
                          color: textResultLabelColor),
                    ),
                    Text(
                      bmiResult,
                      style: kBMITextStyle,
                    ),
                    Text(
                      interpretation,
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
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
