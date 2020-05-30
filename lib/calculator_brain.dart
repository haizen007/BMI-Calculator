import 'dart:math';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CalculatorBrain {
  final Color color;
  final double height;
  final double weight;

  CalculatorBrain({
    @required this.height,
    @required this.weight,
    this.color,
  });

  double _bmi = 0;

/*
 * Metric BMI Formula
 * BMI = weight (kg) / [height (m)]2
 * 
 * Imperial BMI Formula
 * BMI = 703 × weight (lbs) / [height (in)]2
 */
  String calculateBMI(
      MeasureWeight w, MeasureHeight h, double weight, double height) {
    if (w == MeasureWeight.kgs && h == MeasureHeight.cm) {
      // kg and cm
      _bmi =
          weight / pow(height / 100, 2); // metric calc, convert cm to sq meter
      return _bmi.toStringAsFixed(1);
    } else if (w == MeasureWeight.lbs && h == MeasureHeight.cm) {
      // pounds and cm
      _bmi = (weight / 2.205) /
          pow(height / 100, 2); // convert Pounds to Kg before calc
      return _bmi.toStringAsFixed(1);
    } else if (w == MeasureWeight.kgs && h == MeasureHeight.ft) {
      // kg and feet
      _bmi = weight /
          pow((height * 30.48) / 100, 2); // convert Feet to Cm before calc
      return _bmi.toStringAsFixed(1);
    } else {
      // pounds and feet
      _bmi = weight /
          ((height * height) * 144) *
          703; // imperial, convert sq feet to sq inches
      return _bmi.toStringAsFixed(1);
    }
  }

  Color getResultColor() {
    if (_bmi >= 30) {
      return kObeseColor;
    } else if (_bmi > 25) {
      return kOverweightColor;
    } else if (_bmi > 18.5) {
      return kNormalColor;
    } else {
      return kUnderweightColor;
    }
  }

  String getResult() {
    if (_bmi >= 30) {
      return 'resultObese'.tr().toUpperCase();
    } else if (_bmi > 25) {
      return 'resultOverweight'.tr().toUpperCase();
    } else if (_bmi > 18.5) {
      return 'resultNormal'.tr().toUpperCase();
    } else {
      return 'resultUnderweight'.tr().toUpperCase();
    }
  }

  String getInterpretation() {
    if (_bmi >= 30) {
      return 'resultObeseText'.tr();
    } else if (_bmi >= 25) {
      return 'resultOverweightText'.tr();
    } else if (_bmi >= 18.5) {
      return 'resultNormalText'.tr();
    } else {
      return 'resultUnderweightText'.tr();
    }
  }
}
