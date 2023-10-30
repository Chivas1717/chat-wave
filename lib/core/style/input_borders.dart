import 'package:flutter/material.dart';

import 'border_radiuses.dart';
import 'colors.dart';

abstract class COutlineInputBorders {
  static const activeTextField = OutlineInputBorder(
    borderRadius: CBorderRadius.all10,
    borderSide: BorderSide(color: CColors.white, width: 0.0),
  );

  static const inactiveTextField = OutlineInputBorder(
    borderRadius: CBorderRadius.all10,
    borderSide: BorderSide(color: CColors.white, width: 0.0),
  );

  static const errorTextField = OutlineInputBorder(
    borderRadius: CBorderRadius.all10,
    borderSide: BorderSide(color: CColors.white, width: 0.0),
  );
}
