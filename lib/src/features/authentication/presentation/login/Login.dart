import 'package:attendance/Home.dart';
import 'package:attendance/src/features/authentication/presentation/signup/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController idController = TextEditingController();
TextEditingController passController = TextEditingController();
double screenh = 0;
double screenw = 0;

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenh = MediaQuery.of(context).size.height;
    screenw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          isKeyboardVisible
              ? const SizedBox(height: 35)
              : Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(2, 64, 116, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                  ),
                  height: screenh / 2.5,
                  width: screenw,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(60),
                      child: Container(
                          // height: screenh / 1.5,
                          // width: screenw / 1.5,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/login.png")))),
                    ),
                  )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "KdaMThmorPro"),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fieldTitle("Employee ID"),
                customField("Enter your Employee ID", idController, false),
                const SizedBox(
                  height: 10,
                ),
                fieldTitle("Password"),
                customField("Enter your Password", passController, true),
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    String id = idController.text.trim();
                    String password = passController.text.trim();

                    if (id.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Employee id is still empty!"),
                      ));
                    } else if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Password is still empty!"),
                      ));
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("Employee")
                          .where('id', isEqualTo: id)
                          .get();

                      try {
                        if (password == snap.docs[0]['password']) {
                          sharedPreferences =
                              await SharedPreferences.getInstance();

                          sharedPreferences
                              .setString('employeeId', id)
                              .then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Homescreen()));
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Password is not correct!"),
                          ));
                        }
                      } catch (e) {
                        String error = " ";

                        if (e.toString() ==
                            "RangeError (index): Invalid value: Valid value range is empty: 0") {
                          setState(() {
                            error = "Employee id does not exist!";
                          });
                        } else {
                          setState(() {
                            error = "Error occurred!";
                          });
                        }

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(error),
                        ));
                      }
                    }
                  },
                  child: Container(
                    height: 60,
                    width: screenw,
                    margin: EdgeInsets.only(top: screenh / 40),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(2, 64, 116, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: "KdaMThmorPro",
                          fontSize: screenw / 26,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
                  child: const Text(
                    "New User? Sign Up",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: "KdaMThmorPro",
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenh / 70,
          )
        ],
      ),
    );
  }
}

Widget fieldTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        fontSize: screenw / 26,
        fontFamily: "NexaBold",
      ),
    ),
  );
}

Widget customField(
    String hint, TextEditingController controller, bool obscure) {
  return Container(
    width: screenw / 1.1,
    margin: const EdgeInsets.only(bottom: 12),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          width: screenw / 6,
          child: Icon(
            Icons.person,
            size: screenw / 15,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: screenw / 12),
            child: TextFormField(
              controller: controller,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenh / 45,
                ),
                border: InputBorder.none,
                hintText: hint,
              ),
              maxLines: 1,
              obscureText: obscure,
            ),
          ),
        )
      ],
    ),
  );
}
