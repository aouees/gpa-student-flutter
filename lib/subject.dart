import 'package:flutter/material.dart';

class MySubject  {
  TextEditingController numHour=TextEditingController();
  TextEditingController mark=TextEditingController();
  TextEditingController oldMark=TextEditingController();
  getNumHours(){
    return double.parse(numHour.text);
  }
  getMark(){
    return double.parse(mark.text);
  }
  getOldMark(){
    if(oldMark.text.isNotEmpty) {
      return double.parse(oldMark.text);
    } else {
      return -1.0;
    }
  }
}