import 'package:flutter/material.dart';
import 'package:gpa_student/subject.dart';

import 'myColor.dart';

myTextFormT1({required hintText, required controller, required validator}) {
  return TextFormField(
    controller: controller,
    cursorColor: MyColor.myOrange,
    decoration: InputDecoration(
      focusColor: MyColor.myOrange,
      floatingLabelStyle: const TextStyle(color: MyColor.myOrange),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: MyColor.myBlue)),
      labelText: hintText,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: MyColor.myOrange)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: MyColor.myRed)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: MyColor.myBlue)),
    ),
    keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
    validator: validator,
  );
}

myTextFormT2({required controller, required validator}) {
  return TextFormField(
    textAlign: TextAlign.center,
    controller: controller,
    validator: validator,
    cursorColor: MyColor.myBlue,
    decoration: const InputDecoration(
      focusColor: MyColor.myBlue,
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: MyColor.myBlue)),
    ),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}

mySubjectWidget({required MySubject mySubject, required number}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "subject$number",
            textAlign: TextAlign.center,
            style: const TextStyle(color: MyColor.myBlue),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
            child: myTextFormT2(
                controller: mySubject.numHour,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "OOPS is empty";
                  }
                  if (value!.contains('.')) {
                    return "non-Integer value";
                  }
                  if (double.tryParse(value)! < 0.0) {
                    return "incorrect value";
                  }
                  return null;
                })),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: myTextFormT2(
              controller: mySubject.mark,
              validator: (value) {
                if (value!.isEmpty) {
                  return "OOPS is empty";
                }
                if (value!.contains('.')) {
                  return "non-Integer value";
                }
                double? x = double.tryParse(value);
                if (x! < 0.0 || x > 100.0) {
                  return "incorrect value";
                }
                return null;
              }),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: myTextFormT2(
              controller: mySubject.oldMark,
              validator: (value) {
                if (value!.contains('.')) {
                  return "non-Integer value";
                }
                double? x = double.tryParse(value);
                if (x != null && (x < 0.0 || x > 100.0)) {
                  return "incorrect value";
                }
                return null;
              }),
        ),
      ],
    ),
  );
}
