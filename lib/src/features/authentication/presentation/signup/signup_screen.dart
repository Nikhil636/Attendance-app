import 'package:attendance/shared/common_textfields.dart';
import 'package:attendance/shared/loader_dialog.dart';
import 'package:attendance/src/utils/textfield_validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/providers/auth_providers.dart';
import '../../domain/state/sign_up_state.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final listController = useScrollController(initialScrollOffset: 100);
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    Size size = MediaQuery.of(context).size;
    ref.listen<SignUpState>(
      signUpControllerProvider,
      (prev, next) => next.maybeWhen(
        success: () {
          if (!mounted) return;
          LoaderDialog.hideDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sign up successful")));
          return null;
        },
        failure: (failure) {
          if (!mounted) return;
          LoaderDialog.hideDialog(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(failure.toString())));
          return null;
        },
        loading: () async {
          if (!mounted) return;
          await LoaderDialog.showLoaderDialog(context);
          return null;
        },
        orElse: () => null,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 3.3,
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
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Scrollbar(
                    child: ListView(
                      controller: listController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      children: [
                        const Text(
                          "SIGN UP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: "KdaMThmorPro"),
                        ),
                        const SizedBox(height: 20),
                        NameFormField(
                          textEditingController: fullNameController,
                        ),
                        const SizedBox(height: 20),
                        EmailFormField(
                          textEditingController: emailController,
                        ),
                        const SizedBox(height: 20),
                        PasswordFormField(
                          textEditingController: passwordController,
                        ),
                        const SizedBox(height: 20),
                        PasswordFormField(
                          textEditingController: confirmPasswordController,
                          isConfirmPassword: true,
                          textInputAction: TextInputAction.done,
                          validator: (p0) {
                            if (p0 != passwordController.text) {
                              return "Passwords don't match";
                            }
                            return TextFieldValidators.passwordValidator(p0);
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await register(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      listController,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(2, 64, 116, 1),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
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
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                    fontFamily: "KdaMThmorPro",
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).maybePop(),
                      style: const TextStyle(
                        fontFamily: "KdaMThmorPro",
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register(
      String email, String password, ScrollController controller) async {
    if (_formKey.currentState!.validate()) {
      ref
          .read(signUpControllerProvider.notifier)
          .signUp(email: email, password: password);
      return;
    }
    animateToBottom(controller);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form has errors')),
    );
  }

  void animateToBottom(ScrollController listController) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        listController.animateTo(
          listController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
}
