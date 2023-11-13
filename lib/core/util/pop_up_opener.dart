import 'package:flutter/material.dart';

void showPopUp(BuildContext context, Widget popUp) {
  showDialog(
    context: context,
    builder: (_) => popUp,
  );
}
