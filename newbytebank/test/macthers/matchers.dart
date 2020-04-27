import 'package:flutter/material.dart';
import 'package:newbytebank/screens/dashboard.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if(widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }
  return false;
}

bool textFieldByLabelText(Widget widget, String labelText) {
  if(widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}