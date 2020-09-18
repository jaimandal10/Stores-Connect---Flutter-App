import 'package:flutter/material.dart';

const kTxtFld = InputDecoration(
  hintText: 'Enter data',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  focusColor: Colors.black,
  isDense: true,
  errorMaxLines: 3,
  contentPadding:EdgeInsets.symmetric(vertical: 3),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.5,
    ),
  ),
);

