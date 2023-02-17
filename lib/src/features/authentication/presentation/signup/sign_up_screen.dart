import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../shared/common_textfields.dart';
import '../../../../../shared/loader_dialog.dart';
import '../../../../app/constants/assets.gen.dart';
import '../../../../utils/textfield_validators.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;
    ScrollController listController =
        useScrollController(initialScrollOffset: 100);
    TextEditingController fullNameController = useTextEditingController();
    TextEditingController emailController = useTextEditingController();
    TextEditingController passwordController = useTextEditingController();
    TextEditingController confirmPasswordController =
        useTextEditingController();
    Size size = MediaQuery.of(context).size;
    ref.listen<SignUpState>(
      signUpControllerProvider,
      (SignUpState? prev, SignUpState next) => next.maybeWhen(
        success: () {
          if (!mounted) return;
          LoaderDialog.hideDialog(context);
          //TODO: Navigate to a specific screen after successful sign up
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign up successful')));
          return null;
        },
        failure: (String? failure) {
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
            children: <Widget>[
              SizedBox(
                height: size.height / 3.5,
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
                      Assets.images.signup.path,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Scrollbar(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      controller: listController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      children: <Widget>[
                        Text(
                          'SIGN UP',
                          textAlign: TextAlign.center,
                          style: textTheme.labelLarge
                              ?.copyWith(fontSize: 22, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        NameFormField(
                          textEditingController: fullNameController,
                        ),
                        const SizedBox(height: 10),
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
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
                            await register(emailController.text.trim(),
                                passwordController.text.trim(), listController);
                          },
                          validator: (String? val) {
                            if (val != passwordController.text) {
                              return "Passwords don't match";
                            }
                            return TextFieldValidators.passwordValidator(val);
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    'SIGN UP',
                                    style: textTheme.labelMedium?.copyWith(
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
                  text: 'Already have an account? ',
                  style: textTheme.labelSmall
                      ?.copyWith(color: Colors.black, fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).maybePop(),
                      style: textTheme.labelSmall
                          ?.copyWith(color: Colors.blue, fontSize: 12),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register(
      String email, String password, ScrollController controller) async {
    if (_formKey.currentState!.validate()) {
      await ref
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
