import 'package:exam/constants.dart';
import 'package:exam/screens/tasks/components/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _currentMonth = Jiffy().month;
  var _currentYear = Jiffy().year;
  var _currentDate = Jiffy().date;

  var jiffy;

  var _fromDate;
  var _toDate;

  var _selectedDate;

  // to scrool current day
  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;
  @override
  initState() {
    super.initState();
    jiffy = Jiffy([_currentYear, _currentMonth, _currentDate]);
    _fromDate = Jiffy([jiffy.year - 1, 1, 1]);
    _toDate = Jiffy([jiffy.year + 1, 1, 1]);
    _selectedDate = jiffy.date;
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
  }

  @override
  Widget build(BuildContext context) {
    // SchedulerBinding.instance!.addPostFrameCallback(
    //   (_) => itemScrollController.scrollTo(
    //       index: _selectedDate - 2,
    //       duration: Duration(seconds: 1),
    //       curve: Curves.easeInOutCubic),
    // );
    var size = MediaQuery.of(context).size;
    jiffy = Jiffy([_currentYear, _currentMonth, _currentDate]);
    var month1 = Jiffy([_currentYear, _currentMonth - 1, _currentDate]);
    var month2 = Jiffy([_currentYear, _currentMonth + 1, _currentDate]);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: kTextColor),
                        onPressed: () {
                          if (jiffy.format("MM.yyyy") !=
                              _fromDate.format("MM.yyyy")) {
                            setState(() {
                              _currentMonth--;
                              _selectedDate = 1;
                            });
                          }
                        },
                      ),
                      Text(
                        "${month1.MMM.toString()}",
                        style: TextStyle(fontSize: 13.0, color: kTextColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${jiffy.MMMM.toString()}",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: kTextColor,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "${month2.MMM.toString()}",
                        style: TextStyle(fontSize: 13.0, color: kTextColor),
                      ),
                      IconButton(
                        onPressed: () {
                          if (jiffy.format("MM.yyyy") !=
                              _fromDate.format("MM.yyyy")) {
                            setState(() {
                              _currentMonth++;
                              _selectedDate = 1;
                            });
                          }
                        },
                        icon: Icon(Icons.arrow_forward, color: kTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              height: kDefaultPadding * 5,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: jiffy.daysInMonth,
                itemBuilder: (context, index) {
                  return dayItem(
                    day: "${index + 1}",
                    weeksday:
                        "${Jiffy([jiffy.year, jiffy.month, index + 1]).E}",
                    index: index,
                  );
                },
                // itemPositionsListener: itemPositionsListener,
                // itemScrollController: itemScrollController,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Ongoing",
              style: TextStyle(
                fontSize: 20.0,
                color: kTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Column(
              children: [
                taskItemWithTime(
                  title: "Mobile App Design",
                  subtitle: "Asadbek",
                  fromtime: "9:00",
                  toTime: "10:00",
                  fromTimeFormat: "AM",
                  toTimeFormat: "PM",
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("10 AM", style: TextStyle(color: kSecondaryColor)),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.circle,
                        color: Colors.redAccent,
                        size: 10.0,
                      ),
                    ),
                    Container(
                      width: size.width * 0.65,
                      child: Divider(
                        height: 1,
                        color: Colors.redAccent,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                taskItemWithTime(
                  title: "Software Testing",
                  subtitle: "Asadbek",
                  fromtime: "10:00",
                  toTime: "12:20",
                  fromTimeFormat: "AM",
                  toTimeFormat: "AM",
                ),
                SizedBox(height: size.height * 0.02),
                taskItemWithTime(
                  title: "Web Development",
                  subtitle: "Asadbek",
                  fromtime: "1:00",
                  toTime: "2:00",
                  fromTimeFormat: "PM",
                  toTimeFormat: "PM",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget taskItemWithTime(
      {title, subtitle, fromtime, toTime, fromTimeFormat, toTimeFormat}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${fromtime.split(":")[0]} $fromTimeFormat",
                style: TextStyle(color: kSecondaryColor)),
            SizedBox(height: kDefaultPadding * 2),
            Text("${fromtime.split(":")[0]} $toTimeFormat",
                style: TextStyle(color: kSecondaryColor)),
          ],
        ),
        taskItem(
          title: "$title",
          subtitle: "$subtitle",
          time: "$fromtime $fromTimeFormat - $toTime $toTimeFormat",
          users: [
            Avatar(img: "assets/images/myPic.jpg", radius: 15),
          ],
        ),
      ],
    );
  }

  Widget dayItem({required day, required weeksday, required index}) {
    Color bg = Colors.white;
    Color dayColor = kPrimaryColor;
    if (_selectedDate == index + 1) {
      bg = kPrimaryColor;
      dayColor = Colors.white;
    }
    return ElevatedButton(
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 1.1, vertical: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$day",
              style: TextStyle(
                color: dayColor,
                fontSize: 26.0,
              ),
            ),
            Text(
              "$weeksday",
              style: TextStyle(
                color: kTextColor,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedDate = index + 1;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
    );
  }

  Widget taskItem({
    required title,
    required subtitle,
    required users,
    required time,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Color(0xff5450D6),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          Text(
            "$subtitle",
            style: TextStyle(
              color: Color(0xff99A7e8),
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: users,
              ),
              Text(
                "$time",
                style: TextStyle(
                  color: Color(0xff99A7e8),
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
