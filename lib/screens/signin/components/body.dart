import 'package:exam/models/db_helper.dart';
import 'package:exam/models/task.dart';
import 'package:exam/models/user.dart';
import 'package:exam/screens/signin/components/custom_button.dart';
import 'package:exam/screens/signin/components/smsCode.dart';
import 'package:exam/screens/signin/components/textInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController username = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // DB variables
  DatabaseHelper databaseHelper = DatabaseHelper();
  static DatabaseHelper? dbAccounts;
  static List<Account>? accountList;

  @override
  void initState() {
    accountList = <Account>[];
    dbAccounts = DatabaseHelper();
    dbAccounts!.fetchDatas().then((allAccountsList) {
      for (var readAccount in allAccountsList) {
        accountList!.add(Account.fromMap(readAccount));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: kDefaultPadding * 2),
              child: Image.asset(
                "assets/images/signIn_Svg.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              "Welcome back!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              "Log in to your existant account of Task App",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding * 1.7,
                ),
                child: Column(
                  children: [
                    TextInput(
                      controller: username,
                      prefixIcon: Icon(
                        CupertinoIcons.person,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Username",
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Enter at least 6 letters';
                        }
                      },
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    TextInput(
                      controller: phoneNumber,
                      prefixIcon: Icon(
                        CupertinoIcons.phone,
                      ),
                      keyboardType: TextInputType.phone,
                      hintText: "Phone Number",
                    ),
                    SizedBox(height: kDefaultPadding),
                    CustomButton(
                      size: size,
                      text: "Send",
                      onPressed: () async {
                        print(
                            "PHONE NUMBER: ${phoneNumber.text}, USERNAME: ${username.text}");
                        if (formKey.currentState!.validate()) {
                          await databaseHelper
                              .userAdd(Account(username.text, phoneNumber.text))
                              .then((uId) {
                            accountList!.clear();
                            dbAccounts!.fetchUser().then((allAccountsList) {
                              setState(() {
                                for (var readAccount in allAccountsList) {
                                  accountList!.add(Account.fromMap(readAccount));
                                }
                              });
                            });
                          });
                        }
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SmsCode(
                                phoneNumber: phoneNumber,
                                addUser: _addUser,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: kDefaultPadding * 1.5),
          ],
        ),
      ),
    );
  }

  _addUser() async {
    print("PHONE NUMBER: ${phoneNumber.text}, USERNAME: ${username.text}");
    if (formKey.currentState!.validate()) {
      await databaseHelper
          .userAdd(Account(username.text, phoneNumber.text))
          .then((uId) {
        accountList!.clear();
        dbAccounts!.fetchUser().then((allAccountsList) {
          setState(() {
            for (var readAccount in allAccountsList) {
              accountList!.add(Account.fromMap(readAccount));
            }
          });
        });
      });
    }
  }
}
