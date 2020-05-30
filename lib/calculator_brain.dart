import 'dart:math';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CalculatorBrain {
  final double height;
  final double weight;

  CalculatorBrain({
    @required this.height,
    @required this.weight,
  });

  double _bmi;

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  final double _minUnderweight = 17.0;
  final double _minNormal = 18.5;
  final double _minOverweight = 25.0;
  final double _minObese = 30.0;

/*
 * Metric BMI Formula
 * BMI = weight (kg) / [height (m)]2
 * 
 * Imperial BMI Formula
 * BMI = 703 × weight (lbs) / [height (in)]2
 */
  double calculateBMI(
      MeasureWeight w, MeasureHeight h, double weight, double height) {
    if (w == MeasureWeight.kgs && h == MeasureHeight.cm) {
      // kg and cm
      _bmi =
          weight / pow(height / 100, 2); // metric calc, convert cm to sq meter
      return _bmi = roundDouble(_bmi, 1);
    } else if (w == MeasureWeight.lbs && h == MeasureHeight.cm) {
      // pounds and cm
      _bmi = (weight / 2.205) /
          pow(height / 100, 2); // convert Pounds to Kg before calc
      return _bmi = roundDouble(_bmi, 1);
    } else if (w == MeasureWeight.kgs && h == MeasureHeight.ft) {
      // kg and feet
      _bmi = weight /
          pow((height * 30.48) / 100, 2); // convert ft to cm before calc
      return _bmi = roundDouble(_bmi, 1);
    } else {
      // pounds and feet
      _bmi = weight /
          ((height * height) * 144) *
          703; // imperial, convert sq ft to sq inches
      return _bmi = roundDouble(_bmi, 1);
    }
  }

  Color getLabelResultColor() {
    if (_bmi >= _minObese) {
      return kObeseColor;
    } else if (_bmi >= _minOverweight) {
      return kOverweightColor;
    } else if (_bmi >= _minNormal) {
      return kNormalColor;
    } else if (_bmi >= _minUnderweight) {
      return kUnderweightColor;
    } else {
      return kSeverelyUnderweightColor;
    }
  }

  String getLabelResult() {
    if (_bmi >= _minObese) {
      return 'resultLabelObese'.tr().toUpperCase();
    } else if (_bmi >= _minOverweight) {
      return 'resultLabelOverweight'.tr().toUpperCase();
    } else if (_bmi >= _minNormal) {
      return 'resultLabelNormal'.tr().toUpperCase();
    } else if (_bmi >= _minUnderweight) {
      return 'resultLabelUnderweight'.tr().toUpperCase();
    } else {
      return 'resultLabelSeverelyUnderweight'.tr().toUpperCase();
    }
  }

  String getResultText() {
    if (_bmi >= _minObese) {
      return 'resultTextObese'.tr();
    } else if (_bmi >= _minOverweight) {
      return 'resultTextOverweight'.tr();
    } else if (_bmi >= _minNormal) {
      return 'resultTextNormal'.tr();
    } else if (_bmi >= _minUnderweight) {
      return 'resultTextUnderweight'.tr();
    } else {
      return 'resultTextSeverelyUnderweight'.tr();
    }
  }
}
