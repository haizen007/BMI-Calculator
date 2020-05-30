import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/custom_slider.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/measure_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:bmi_calculator/calculator_brain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';

enum Gender { male, female }
enum MeasureWeight { lbs, kgs }
enum MeasureHeight { ft, cm }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender genderSelected;
  Color genderColor = kInactiveCardColor;
  IconData genderIcon = FontAwesomeIcons.question;
  String genderLabel = 'gender'.tr().toUpperCase();

  MeasureWeight selectedWeight = MeasureWeight.kgs;
  MeasureHeight selectedHeight = MeasureHeight.cm;

  double weight = kDefaultWeightKGS;
  double height = kDefaultHeightCM;

  double minWeight = kMinWeightKGS;
  double maxWeight = kMaxWeightKGS;
  int divWeight = kDivWeightKGS;

  double minHeight = kMinHeightCM;
  double maxHeight = kMaxHeightCM;
  int divHeight = kDivHeightCM;

  int age = 35;

  bool allFieldsChecked() {
    if (genderSelected == null) {
      BotToast.showSimpleNotification(title: "genderSelectToast".tr());
      return false;
    } else {
      BotToast.showLoading(
        duration: Duration(milliseconds: 325),
      );
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appTitle'.tr().toUpperCase()),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ReusableCard(
              cardColor: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: heightSizedBox1,
                  ),
                  Text(
                    'weight'.tr().toUpperCase(),
                    style: kLabelTextStyle,
                  ),
                  SizedBox(
                    height: heightSizedBox2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: widthSizedBox,
                      ),
                      Expanded(
                        child: MeasureContent(
                          onPressed: () {
                            setState(() {
                              selectedWeight = MeasureWeight.lbs;
                              weight = kDefaultWeightLBS;
                              minWeight = kMinWeightLBS;
                              maxWeight = kMaxWeightLBS;
                              divWeight = kDivWeightLBS;
                            });
                          },
                          measureColor: selectedWeight == MeasureWeight.lbs
                              ? kActiveMeasureColorImperial
                              : kInactiveMeasureColor,
                          measureChild:
                              Text('pounds'.tr(), style: kMeasureTextStyle),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          weight.toStringAsFixed(1),
                          style: kNumberTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: MeasureContent(
                          onPressed: () {
                            setState(() {
                              selectedWeight = MeasureWeight.kgs;
                              weight = kDefaultWeightKGS;
                              minWeight = kMinWeightKGS;
                              maxWeight = kMaxWeightKGS;
                              divWeight = kDivWeightKGS;
                            });
                          },
                          measureColor: selectedWeight == MeasureWeight.kgs
                              ? kActiveMeasureColorMetric
                              : kInactiveMeasureColor,
                          measureChild:
                              Text('kilograms'.tr(), style: kMeasureTextStyle),
                        ),
                      ),
                      SizedBox(
                        width: widthSizedBox,
                      ),
                    ],
                  ),
                  CustomSlider(
                    value: weight,
                    min: minWeight,
                    max: maxWeight,
                    divisions: divWeight,
                    thumbShape: 12.5,
                    overlayShape: 25,
                    onChanged: (double newValue) {
                      setState(() {
                        weight = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ReusableCard(
              cardColor: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: heightSizedBox1,
                  ),
                  Text(
                    'height'.tr().toUpperCase(),
                    style: kLabelTextStyle,
                  ),
                  SizedBox(
                    height: heightSizedBox2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: widthSizedBox,
                      ),
                      Expanded(
                        child: MeasureContent(
                          onPressed: () {
                            setState(() {
                              selectedHeight = MeasureHeight.ft;
                              height = kDefaultHeightFT;
                              minHeight = kMinHeightFT;
                              maxHeight = kMaxHeightFT;
                              divHeight = kDivHeightFT;
                            });
                          },
                          measureColor: selectedHeight == MeasureHeight.ft
                              ? kActiveMeasureColorImperial
                              : kInactiveMeasureColor,
                          measureChild:
                              Text('feet'.tr(), style: kMeasureTextStyle),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          height.toStringAsFixed(1),
                          style: kNumberTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: MeasureContent(
                          onPressed: () {
                            setState(() {
                              selectedHeight = MeasureHeight.cm;
                              height = kDefaultHeightCM;
                              minHeight = kMinHeightCM;
                              maxHeight = kMaxHeightCM;
                              divHeight = kDivHeightCM;
                            });
                          },
                          measureColor: selectedHeight == MeasureHeight.cm
                              ? kActiveMeasureColorMetric
                              : kInactiveMeasureColor,
                          measureChild: Text('centimeters'.tr(),
                              style: kMeasureTextStyle),
                        ),
                      ),
                      SizedBox(
                        width: widthSizedBox,
                      ),
                    ],
                  ),
                  CustomSlider(
                    value: height,
                    min: minHeight,
                    max: maxHeight,
                    divisions: divHeight,
                    thumbShape: 12.5,
                    overlayShape: 25,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (genderSelected == Gender.female) {
                          genderIcon = FontAwesomeIcons.mars;
                          genderColor = kActiveCardColor;
                          genderLabel = 'genderMale'.tr().toUpperCase();
                          genderSelected = Gender.male;
                        } else {
                          genderIcon = FontAwesomeIcons.venus;
                          genderColor = kActiveCardColor;
                          genderLabel = 'genderFemale'.tr().toUpperCase();
                          genderSelected = Gender.female;
                        }
                      });
                    },
                    child: ReusableCard(
                      cardColor: genderColor,
                      cardChild: IconContent(
                        icon: genderIcon,
                        label: genderLabel,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardColor: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'age'.tr().toUpperCase(),
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 12.5,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'calculate'.tr().toUpperCase(),
            onTap: () {
              if (allFieldsChecked()) {
                CalculatorBrain calc = CalculatorBrain(
                  height: height,
                  weight: weight,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmiResult: calc.calculateBMI(
                          selectedWeight, selectedHeight, weight, height),
                      textResult: calc.getResult(),
                      interpretation: calc.getInterpretation(),
                      textResultLabelColor: calc.getResultColor(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
