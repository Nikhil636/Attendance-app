import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/loader_dialog.dart';
import '../../../../app/constants/assets.gen.dart';
import '../../../home/presentation/home.dart';
import '../../app/providers/auth_providers.dart';
import '../../domain/state/login_state.dart';
import '../signup/sign_up_screen.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    //Flutter hooks
    TabController tabController = useTabController(initialLength: 2);
    TextEditingController idController = useTextEditingController();
    TextEditingController passController = useTextEditingController();
    //Method that listens to the updates in the login state
    ref.listen<LoginState>(
      loginControllerProvider,
      (LoginState? prev, LoginState next) => next.whenOrNull(
        success: () async {
          LoaderDialog.hideDialog(context);
          if (!mounted) return;
          //Push to home screen and reomve all the previous routes in navigation stack
          await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(builder: (_) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
          return null;
        },
        failure: (String failure) {
          LoaderDialog.hideDialog(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(failure)));
          return null;
        },
        loading: () async {
          await LoaderDialog.showLoaderDialog(context);
          return null;
        },
      ),
    );
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
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
                    height: size.height / 4,
                    width: size.width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.images.login.path),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
            Text(
              'LOGIN',
              style: textTheme.labelLarge?.copyWith(fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 10),
              child: SegmentedTabControl(
                radius: const Radius.circular(10),
                controller: tabController,
                backgroundColor: Colors.grey.shade300,
                indicatorColor: const Color.fromRGBO(2, 64, 116, 1),
                tabTextColor: Colors.black45,
                selectedTabTextColor: Colors.white,
                squeezeIntensity: 2,
                height: size.height * 0.06,
                tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 12),
                tabs: const <SegmentTab>[
                  SegmentTab(label: 'EMPLOYEE'),
                  SegmentTab(label: 'ADMIN'),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fieldTitle('Employee ID', textTheme, size),
                          const SizedBox(height: 5),
                          customField('Enter your Employee ID', idController,
                              false, size),
                          const SizedBox(height: 10),
                          fieldTitle('Password', textTheme, size),
                          const SizedBox(height: 5),
                          customField('Enter your Password', passController,
                              true, size),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fieldTitle('Admin', textTheme, size),
                          const SizedBox(height: 5),
                          customField(
                              'Enter your email', idController, false, size),
                          const SizedBox(height: 10),
                          fieldTitle('Password', textTheme, size),
                          const SizedBox(height: 5),
                          customField('Enter your Password', passController,
                              true, size),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  String id = idController.text.trim();
                  String password = passController.text.trim();
                  if (tabController.index != 0) {
                    //TODO: Admin login api call here
                    return;
                  }
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
                                builder: (_) => const HomeScreen()),
                          );
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
                  width: size.width,
                  margin: EdgeInsets.only(top: size.height / 40),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(2, 64, 116, 1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontSize: size.width / 26,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Text.rich(
              TextSpan(
                text: 'New User ? ',
                style:
                    textTheme.labelSmall?.copyWith(fontSize: size.width / 26),
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
                      fontSize: size.width / 26,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget fieldTitle(String title, TextTheme textTheme, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Expanded>[
        Expanded(
          child: Text(
            title,
            style: textTheme.labelLarge?.copyWith(fontSize: size.width / 26),
          ),
        ),
      ],
    );
  }

  Widget customField(
      String hint, TextEditingController controller, bool obscure, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: size.width,
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
              width: size.width / 6,
              child: Icon(
                Icons.person,
                size: size.width / 15,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: size.width / 12),
                child: TextFormField(
                  controller: controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: size.height / 45),
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
      ),
    );
  }
}
