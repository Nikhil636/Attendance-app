import 'package:attendance/shared/common_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 3,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(2, 64, 116, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.asset(
                      'assets/images/signup.png',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "SIGN UP",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "KdaMThmorPro"),
              ),
              const SizedBox(
                height: 20,
              ),
              NameFormField(textEditingController: fullNameController),
              const SizedBox(
                height: 20,
              ),
              EmailFormField(textEditingController: emailController),
              const SizedBox(
                height: 20,
              ),
              PasswordFormField(textEditingController: passwordController),
              const SizedBox(
                height: 20,
              ),
              PasswordFormField(
                  textEditingController: confirmPasswordController),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(2, 64, 116, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontFamily: "KdaMThmorPro",
                          fontSize: size.width / 26,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
