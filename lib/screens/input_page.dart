import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/custom_slider.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/measure_button.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:bmi_calculator/controller/calculator_brain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

enum Gender { male, female }
enum Weight { imperial, metric }
enum Height { imperial, metric }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender genderSelected;
  Color genderColor = kInactiveCardColor;
  IconData genderIcon = FontAwesomeIcons.question;
  String genderLabel = 'gender'.tr().toUpperCase();

  // the app starts with Metric values as default
  Weight selectedWeight = Weight.metric;
  Height selectedHeight = Height.metric;

  // vars get Metric values as default
  double weight = kDefaultKgs;
  double height = kDefaultCm;

  // Slider gets Kgs and Cm as default
  double minWeight = kMinKgs;
  double maxWeight = kMaxKgs;
  int divWeight = kDivKgs;

  // just to initialize the vars with equivalent value in Cm
  double inches = 5;
  double feet = 11;

  // age does not influence the BMI result
  int age = 35;

  // user needs to select a Gender even though that does not influence the BMI result
  bool isGenderSelected() {
    if (genderSelected == null) {
      BotToast.showSimpleNotification(title: "genderToast".tr());
      return false;
    } else {
      BotToast.showLoading(
        duration: Duration(milliseconds: 325),
      );
      return true;
    }
  }

  // 'Ft + In' or 'Centimeters' shows the Slider depending of the selectedHeight
  Widget getCustomSlider() {
    if (selectedHeight == Height.imperial)
      return Row(
        children: <Widget>[
          Expanded(
            child: CustomSlider(
              value: feet,
              min: kMinFeet,
              max: kMaxFeet,
              divisions: kDivFeet,
              thumbShape: kThumbShape,
              overlayShape: kOverlayShape,
              onChanged: (double newValue) {
                setState(() {
                  // round number eg 5.77 to 5.0
                  feet = newValue.floorToDouble();
                });
              },
            ),
          ),
          Expanded(
            child: CustomSlider(
              value: inches,
              min: kMinInches,
              max: kMaxInches,
              divisions: kDivInches,
              thumbShape: kThumbShape,
              overlayShape: kOverlayShape,
              onChanged: (double newValue) {
                setState(() {
                  // round number eg 5.77 to 5.0
                  inches = newValue.floorToDouble();
                });
              },
            ),
          ),
        ],
      );
    return CustomSlider(
      value: height,
      min: kMinCm,
      max: kMaxCm,
      divisions: kDivCm,
      thumbShape: kThumbShape,
      overlayShape: kOverlayShape,
      onChanged: (double newValue) {
        setState(() {
          height = newValue;
        });
      },
    );
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
                    height: kSizedBoxHeight1,
                  ),
                  Text(
                    'weight'.tr().toUpperCase(),
                    style: kLabelTextStyle,
                  ),
                  SizedBox(
                    height: kSizedBoxHeight2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: kSizedBoxWidth,
                      ),
                      Expanded(
                        child: MeasureButton(
                          onPressed: () {
                            setState(() {
                              // doesn't convert if it's already selected Imperial
                              if (selectedWeight != Weight.imperial) {
                                selectedWeight = Weight.imperial;
                                // convert kgs to lbs
                                weight = weight * 2.205;
                                // if converted Value is lower than Min
                                if (weight <= kMinLbs) {
                                  weight = kMinLbs;
                                }
                                minWeight = kMinLbs;
                                maxWeight = kMaxLbs;
                                divWeight = kDivLbs;
                              }
                            });
                          },
                          colors: selectedWeight == Weight.imperial
                              ? kActiveMeasureColorImperial
                              : kInactiveMeasureColor,
                          child: Text('weightImperial'.tr(),
                              style: kMeasureTextStyle),
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
                        child: MeasureButton(
                          onPressed: () {
                            setState(() {
                              // doesn't convert if it's already selected Metric
                              if (selectedWeight != Weight.metric) {
                                selectedWeight = Weight.metric;
                                // convert lbs to kgs
                                weight = weight / 2.205;
                                // if converted Value is higher than Max
                                if (weight >= kMaxKgs) {
                                  weight = kMaxKgs;
                                }
                                minWeight = kMinKgs;
                                maxWeight = kMaxKgs;
                                divWeight = kDivKgs;
                              }
                            });
                          },
                          colors: selectedWeight == Weight.metric
                              ? kActiveMeasureColorMetric
                              : kInactiveMeasureColor,
                          child: Text('weightMetric'.tr(),
                              style: kMeasureTextStyle),
                        ),
                      ),
                      SizedBox(
                        width: kSizedBoxWidth,
                      ),
                    ],
                  ),
                  CustomSlider(
                    value: weight,
                    min: minWeight,
                    max: maxWeight,
                    divisions: divWeight,
                    thumbShape: kThumbShape,
                    overlayShape: kOverlayShape,
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
                    height: kSizedBoxHeight1,
                  ),
                  Text(
                    'height'.tr().toUpperCase(),
                    style: kLabelTextStyle,
                  ),
                  SizedBox(
                    height: kSizedBoxHeight2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: kSizedBoxWidth,
                      ),
                      Expanded(
                        child: MeasureButton(
                          onPressed: () {
                            setState(() {
                              // doesn't convert if it's already selected Imperial
                              if (selectedHeight != Height.imperial) {
                                selectedHeight = Height.imperial;
                                // convert cm to feet
                                height = height / 30.48;
                                // round number eg 5.77 to 5.0
                                feet = height.floorToDouble();
                                // convert the decimal part to inches (5.77 - 5.0) = 0.77
                                inches = ((height - feet) * 12);
                                // if converted Value is higher than Max
                                if (feet > kMaxFeet) {
                                  feet = kMaxFeet;
                                  inches = kMaxInches;
                                  // if converted Value is lower than Min
                                } else if (feet < kMinFeet) {
                                  feet = kMinFeet;
                                  inches = kMinInches;
                                }
                              }
                            });
                          },
                          colors: selectedHeight == Height.imperial
                              ? kActiveMeasureColorImperial
                              : kInactiveMeasureColor,
                          child: Text('heightImperial'.tr(),
                              style: kMeasureTextStyle),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          /**
                           * check if the conversion is correct 
                           * https://www.asknumbers.com/cm-to-feet.aspx
                           */
                          selectedHeight == Height.imperial
                              ? (feet.toStringAsFixed(0) +
                                  '\'' +
                                  inches.toStringAsFixed(0) +
                                  '"')
                              : height.toStringAsFixed(1),
                          style: kNumberTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: MeasureButton(
                          onPressed: () {
                            setState(() {
                              // doesn't convert if it's already selected Metric
                              if (selectedHeight != Height.metric) {
                                selectedHeight = Height.metric;
                                // convert ft + in to cm
                                height = (feet + (inches / 12)) * 30.48;
                              }
                            });
                          },
                          colors: selectedHeight == Height.metric
                              ? kActiveMeasureColorMetric
                              : kInactiveMeasureColor,
                          child: Text('heightMetric'.tr(),
                              style: kMeasureTextStyle),
                        ),
                      ),
                      SizedBox(
                        width: kSizedBoxWidth,
                      ),
                    ],
                  ),
                  // get the Slider depending of the 'selectedHeight'
                  getCustomSlider(),
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
                        // only changes if the user clicks otherwise 'genderIcon = question'
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
              if (isGenderSelected()) {
                CalculatorBrain calc = CalculatorBrain(
                  height: height,
                  weight: weight,
                  feet: feet,
                  inches: inches,
                  h: selectedHeight,
                  w: selectedWeight,
                );
                Get.to(
                  ResultPage(
                    resultBMI: calc.calculateBMI(),
                    resultLabel: calc.getLabelResult(),
                    resultLabelColor: calc.getLabelResultColor(),
                    resultText: calc.getResultText(),
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
