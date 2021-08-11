import 'package:exam/constants.dart';
import 'package:exam/screens/signin/signin.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            // Picture SECTION
            Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(170),
                    bottomRight: Radius.circular(170),
                  ),
                  image: DecorationImage(
                      image: AssetImage("assets/images/onboarding_pic.jpg"))),
            ),
            SizedBox(height: size.height * 0.12),

            // TITLE SECTION
            Text(
              "Manage your daily tasks",
              style: TextStyle(
                color: kTextColor,
                fontSize: 34.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: kDefaultPadding),
            // Description SECTION
            Text(
              "Team and Project managment with solution providing App",
              style: TextStyle(
                color: kTextColor.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: kDefaultPadding),

            // Button SECTION
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  // to overflow elements outside the container we use Clip.none
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      bottom: size.width * 0.06,
                      left: size.width * 0.07,
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
