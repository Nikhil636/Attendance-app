import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/constants/assets.gen.dart';
import '../../../home/home.dart';
import '../../../qr_code_scanner/presentation/qr_code_page.dart';
import '../signup/sign_up_screen.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenh = MediaQuery.of(context).size.height;
    screenw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.images.login.path),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          Text(
            'LOGIN',
            style: textTheme.labelLarge?.copyWith(fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                fieldTitle('Employee ID', textTheme),
                customField('Enter your Employee ID', idController, false),
                const SizedBox(
                  height: 10,
                ),
                fieldTitle('Password', textTheme),
                customField('Enter your Password', passController, true),
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    String id = idController.text.trim();
                    String password = passController.text.trim();

                    if (id.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Employee id is still empty!'),
                      ));
                    } else if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Password is still empty!'),
                      ));
                    } else {
                      QuerySnapshot<Map<String, dynamic>> snap =
                          await FirebaseFirestore.instance
                              .collection('Employee')
                              .where('id', isEqualTo: id)
                              .get();

                      try {
                        if (password == snap.docs[0]['password']) {
                          sharedPreferences =
                              await SharedPreferences.getInstance();

                          await sharedPreferences
                              .setString('employeeId', id)
                              .then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<dynamic>(
                                    builder: (_) => const Homescreen()));
                          });
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Password is not correct!'),
                          ));
                        }
                      } catch (e) {
                        String error = ' ';

                        if (e.toString() ==
                            'RangeError (index): Invalid value: Valid value range is empty: 0') {
                          setState(() {
                            error = 'Employee id does not exist!';
                          });
                        } else {
                          setState(() {
                            error = 'Error occurred!';
                          });
                        }
                        if (!mounted) return;
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
                        'LOGIN',
                        style: textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontSize: screenw / 26,
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
          Text.rich(
            TextSpan(
              text: 'New gqr ? ',
              style: textTheme.labelSmall?.copyWith(
                fontSize: screenw / 26,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign Up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (_) =>  QrScannerScreen()),
                        ),
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.blue,
                    fontSize: screenw / 26,
                  ),
                ),
              ],
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text.rich(
            TextSpan(
              text: 'New User ? ',
              style: textTheme.labelSmall?.copyWith(
                fontSize: screenw / 26,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign Up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (_) => const SignUpScreen()),
                        ),
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.blue,
                    fontSize: screenw / 26,
                  ),
                ),
              ],
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenh / 70)
        ],
      ),
    );
  }
}

Widget fieldTitle(String title, TextTheme textTheme) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: textTheme.labelLarge?.copyWith(fontSize: screenw / 26),
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
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
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
