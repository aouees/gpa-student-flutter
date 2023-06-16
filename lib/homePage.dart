import 'dart:math';
import 'package:flutter/material.dart';
import 'myColor.dart';
import 'subject.dart';
import 'component.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var form1 = GlobalKey<FormState>();
  var form2 = GlobalKey<FormState>();
  List<MySubject> mySubjects = [];
  var lastCGPAController = TextEditingController();
  var cumulativeController = TextEditingController();
  double gpaResult = 0.0;
  double cgpaResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.myWhite,
        appBar: AppBar(
            backgroundColor: MyColor.myWhite,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Image.asset(
                    'assets/UOK_logo.gif',
                    width: 50,
                    height: 50,
                  ),
                ),
                const Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Text(
                    "GPA for UOK student",
                    style: TextStyle(color: MyColor.myBlue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Form(
                key: form1,
                child: Row(
                  children: [
                    Expanded(
                      child: myTextFormT1(
                          controller: lastCGPAController,
                          hintText: "Your Last CGPA",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "OOPS is empty";
                            }
                            double? x=double.tryParse(value);
                            if (x! > 4.0) {
                              return "enter right value";
                            }
                            if (x < 0.0) {
                              return "incorrect value";
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: myTextFormT1(
                        hintText: " Cumulative hours ",
                        controller: cumulativeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "OOPS is empty";
                          }
                          if (value.contains('.')) {
                            return "non-Integer value";
                          }
                          if (double.tryParse(value)! < 0.0) {
                            return "incorrect value";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: MyColor.myBlue,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "subject",
                        style: TextStyle(
                          color: MyColor.myWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "number hours",
                        style: TextStyle(
                          color: MyColor.myWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "mark",
                        style: TextStyle(
                          color: MyColor.myWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "old mark if repeated",
                        style: TextStyle(
                          color: MyColor.myWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: form2,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == mySubjects.length) {
                          return operation();
                        }
                        return mySubjectWidget(mySubject: mySubjects[index], number: index + 1);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                            width: double.infinity,
                            height: 2,
                            child: Container(
                              color: MyColor.myBlue.withOpacity(0.3),
                            ));
                      },
                      itemCount: mySubjects.length + 1),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (form2.currentState!.validate()) {
                              setState(() {
                                calcGPA();
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateColor.resolveWith((states) => MyColor.myBlue)),
                          child: const Text("GPA"))),
                  Expanded(
                      child: Text(
                        "$gpaResult/4.0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gpaResult >= 2.0 ? MyColor.myGreen : MyColor.myRed),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (form1.currentState!.validate() && form2.currentState!.validate()) {
                              setState(() {
                                calcCGPA();
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateColor.resolveWith((states) => MyColor.myBlue)),
                          child: const Text("CGPA"))),
                  Expanded(
                      child: Text(
                        "$cgpaResult/4.0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cgpaResult >= 2.0 ? MyColor.myGreen : MyColor.myRed),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  operation() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              reset();
              setState(() {});
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => MyColor.myOrange)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Reset"),
                Icon(Icons.delete_forever),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              mySubjects.add(MySubject());
              setState(() {});
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => MyColor.myOrange)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add new subject"),
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void reset() {
    mySubjects.clear();
    cumulativeController.clear();
    lastCGPAController.clear();
    gpaResult = 0.0;
    cgpaResult = 0.0;
  }

  double getPointMark(double numHours, double mark) {
    double p;
    if (mark >= 98) {
      p = numHours * 4;
    } else if (mark >= 95) {
      p = numHours * 3.75;
    } else if (mark >= 90) {
      p = numHours * 3.5;
    } else if (mark >= 85) {
      p = numHours * 3.25;
    } else if (mark >= 80) {
      p = numHours * 3;
    } else if (mark >= 75) {
      p = numHours * 2.75;
    } else if (mark >= 70) {
      p = numHours * 2.5;
    } else if (mark >= 65) {
      p = numHours * 2.25;
    } else if (mark >= 60) {
      p = numHours * 2;
    } else if (mark >= 55) {
      p = numHours * 1.75;
    } else if (mark >= 50) {
      p = numHours * 1.5;
    } else {
      p = 0;
    }
    return p;
  }

  void calcGPA() {
    double sumPoint = 0.0;
    double sumHours = 0.0;
    for (var element in mySubjects) {
      sumPoint += getPointMark(element.getNumHours(), max(element.getMark(), element.getOldMark()));
      sumHours += element.getNumHours();
    }
    gpaResult = double.parse((sumPoint / sumHours).toStringAsFixed(2));
  }

  void calcCGPA() {
    calcGPA();
    double oldPoint =
        double.parse(lastCGPAController.text) * double.parse(cumulativeController.text);
    double failPoint = 0.0, failNumHours = 0.0, newNumHours = 0.0;
    for (var element in mySubjects) {
      if (element.getOldMark() != -1.0) {
        failPoint += getPointMark(element.getNumHours(), element.getOldMark());
        failNumHours += element.getNumHours();
      }
      newNumHours += element.getNumHours();
    }
    double newPoint = gpaResult * newNumHours;
    double oldNumHours = double.parse(cumulativeController.text);
    cgpaResult = (oldPoint + newPoint - failPoint) / (oldNumHours + newNumHours - failNumHours);
    cgpaResult = double.parse(cgpaResult.toStringAsFixed(2));
  }
}