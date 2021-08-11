import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  var _currentMonth = Jiffy().month;
  var _currentYear = Jiffy().year;
  var _currentDate = Jiffy().date;

  var jiffy;

  var _fromDate;
  var _toDate;

  var _selectedDate;
  @override
  void initState() {
    super.initState();
    jiffy = Jiffy([_currentYear, _currentMonth, _currentDate]);
    _fromDate = Jiffy([jiffy.year - 1, 1, 1]);
    _toDate = Jiffy([jiffy.year + 1, 1, 1]);
    _selectedDate = jiffy.date;
  }

  @override
  Widget build(BuildContext context) {
    jiffy = Jiffy([_currentYear, _currentMonth, _currentDate]);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100.0),
            Container(
              color: Color.fromRGBO(30, 30, 32, 1),
              width: 380,
              height: 148,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Text(
                        "${jiffy.MMMM}, ${jiffy.year}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                      GestureDetector(
                        onTap: () {
                          if (jiffy.format("MM.yyyy") !=
                              _fromDate.format("MM.yyyy")) {
                            setState(() {
                              _currentMonth--;
                              _selectedDate = 1;
                            });
                          }
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (jiffy.format("MM.yyyy") !=
                                _toDate.format("MM.yyyy")) {
                              _currentMonth++;
                              _selectedDate = 1;
                            }
                          });
                        },
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          child: Icon(
                            CupertinoIcons.forward,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    height: 75,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jiffy.daysInMonth,
                      itemBuilder: (context, index) {
                        return dateWidget(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateWidget(int index) {
    Color today = Colors.transparent;
    if (_selectedDate == index + 1) {
      today = Color.fromRGBO(0, 167, 149, 1);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = index + 1;
        });
      },
      child: Container(
        decoration:
            BoxDecoration(color: today, borderRadius: BorderRadius.circular(6)),
        width: 50,
        height: 52,
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Text(
                "${Jiffy([jiffy.year, jiffy.month, index + 1]).E}",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color.fromRGBO(209, 209, 209, 1)),
              ),
            ),
            Text("${index + 1}",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color.fromRGBO(209, 209, 209, 1))),
            Container(
              margin: EdgeInsets.only(top: 4, bottom: 5),
              width: 17,
              height: 1,
              color: Color.fromRGBO(209, 209, 209, 1),
            )
          ],
        ),
      ),
    );
  }
}
