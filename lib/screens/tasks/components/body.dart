import 'package:exam/constants.dart';
import 'package:exam/screens/task/task.dart';
import 'package:exam/screens/tasks/components/avatar.dart';
import 'package:exam/screens/tasks/components/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The row contains the user's avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage("assets/icons/Calendar.png"),
                    color: Colors.white,
                  ),
                  Avatar(img: "assets/images/myPic.jpg", radius: 15)
                ],
              ),
              SizedBox(height: size.height * 0.05),

              // Title SECTION
              Column(
                children: [
                  Text(
                    'Hi Asadbek',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "6 Tasks are pending",
                    style: TextStyle(
                      color: Color(0xff99A7e8),
                    ),
                  )
                ],
              ),

              SizedBox(height: size.height * 0.05),

              // CURRENT TASK SECTION
              TaskItem(
                title: 'Mobile App Design',
                subtitle: 'Mike and Anita',
                time: 'Now',
                users: [
                  Avatar(img: "assets/images/myPic.jpg", radius: 15),
                  Avatar(
                    img: "assets/images/myPic.jpg",
                    radius: 15,
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),
              // TASK Review SECTION
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monthly Review",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: ImageIcon(
                        AssetImage("assets/icons/Calendar.png"),
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Task(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                width: size.width,
                height: size.height * 0.37,
                child: StaggeredGridView.countBuilder(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) => Container(
                    decoration: BoxDecoration(
                      color: Color(0xff5450D6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "22",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                            ),
                          ),
                          Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 1.5),
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding,
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
