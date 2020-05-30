import 'dart:math';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum Label {
  severelyUnderweight,
  underweight,
  normal,
  overweigh,
  obese1,
  obese2,
  obese3
}

class CalculatorBrain {
  double _bmi;
  Label _label;

  final double height;
  final double weight;
  final Height h;
  final Weight w;
  final double feet;
  final double inches;

  CalculatorBrain({
    @required this.height,
    @required this.weight,
    @required this.h,
    @required this.w,
    @required this.feet,
    @required this.inches,
  });

  //  round to no more than the value 'places' eg just 1 decimal
  double roundToDecimal(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  double convertToInches(double n) {
    return n * 12; // feet to inches
  }

  double convertToPounds(double n) {
    return n * 2.205; // kg to lbs
  }

  double convertToKg(double n) {
    return n / 2.205; // lbs to kg
  }

/*
 * Metric BMI Formula
 * BMI = weight (kg) / [height (m)]2
 * 
 * Imperial BMI Formula
 * BMI = 703 × weight (Imperial) / [height (in)]2
 */
  double calculateBMI() {
    if (w == Weight.metric && h == Height.metric) {
      // kg and cm, Metric calc, convert cm to Sq Meter
      _bmi = weight / pow(height / 100, 2);
      _bmi = roundToDecimal(_bmi, 1);
      setLabel(_bmi);
      return _bmi;
    } else if (w == Weight.imperial && h == Height.metric) {
      // lbs and kg, convert lbs to kg before calc
      _bmi = convertToKg(weight) / pow(height / 100, 2);
      _bmi = roundToDecimal(_bmi, 1);
      setLabel(_bmi);
      return _bmi;
    } else if (w == Weight.metric && h == Height.imperial) {
      // kg and ft + in, convert to Imperial before calc
      _bmi = 703 *
          convertToPounds(weight) /
          pow(convertToInches(feet) + inches, 2);
      _bmi = roundToDecimal(_bmi, 1);
      setLabel(_bmi);
      return _bmi;
    } else {
      // lbs and ft + in, Imperial calc, convert ft to inches
      _bmi = 703 * weight / pow(convertToInches(feet) + inches, 2);
      _bmi = roundToDecimal(_bmi, 1);
      setLabel(_bmi);
      return _bmi;
    }
  }

  void setLabel(_bmi) {
    if (_bmi >= 40) {
      _label = Label.obese3;
    } else if (_bmi >= 35) {
      _label = Label.obese2;
    } else if (_bmi >= 30) {
      _label = Label.obese1;
    } else if (_bmi >= 25) {
      _label = Label.overweigh;
    } else if (_bmi >= 18.5) {
      _label = Label.normal;
    } else if (_bmi >= 17) {
      _label = Label.underweight;
    } else {
      _label = Label.severelyUnderweight;
    }
  }

  Color getLabelResultColor() {
    if (_label == Label.obese3) {
      return kObese3Color;
    } else if (_label == Label.obese2) {
      return kObese2Color;
    } else if (_label == Label.obese1) {
      return kObese1Color;
    } else if (_label == Label.overweigh) {
      return kOverweightColor;
    } else if (_label == Label.normal) {
      return kNormalColor;
    } else if (_label == Label.underweight) {
      return kUnderweightColor;
    } else {
      return kSeverelyUnderweightColor;
    }
  }

  String getLabelResult() {
    if (_label == Label.obese3) {
      return 'resultLabelObese3'.tr().toUpperCase();
    } else if (_label == Label.obese2) {
      return 'resultLabelObese2'.tr().toUpperCase();
    } else if (_label == Label.obese1) {
      return 'resultLabelObese1'.tr().toUpperCase();
    } else if (_label == Label.overweigh) {
      return 'resultLabelOverweight'.tr().toUpperCase();
    } else if (_label == Label.normal) {
      return 'resultLabelNormal'.tr().toUpperCase();
    } else if (_label == Label.underweight) {
      return 'resultLabelUnderweight'.tr().toUpperCase();
    } else {
      return 'resultLabelSeverelyUnderweight'.tr().toUpperCase();
    }
  }

  String getResultText() {
    if (_label == Label.obese3) {
      return 'resultTextObese3'.tr();
    } else if (_label == Label.obese2) {
      return 'resultTextObese2'.tr();
    } else if (_label == Label.obese1) {
      return 'resultTextObese1'.tr();
    } else if (_label == Label.overweigh) {
      return 'resultTextOverweight'.tr();
    } else if (_label == Label.normal) {
      return 'resultTextNormal'.tr();
    } else if (_label == Label.underweight) {
      return 'resultTextUnderweight'.tr();
    } else {
      return 'resultTextSeverelyUnderweight'.tr();
    }
  }
}
