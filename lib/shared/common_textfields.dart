import 'package:attendance/src/utils/textfield_validators.dart';
import 'package:flutter/material.dart';

class NameFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final String? Function(String?)? validator;
  const NameFormField(
      {Key? key,
      required this.textEditingController,
      this.onChanged,
      this.onFieldSubmitted,
      this.initialValue,
      this.autovalidateMode,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) => TextFieldValidators.nameValidator(value),
      onChanged: onChanged,
      textCapitalization: TextCapitalization.words,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: "Full Name",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
        filled: true,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w200,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), gapPadding: 10),
      ),
    );
  }
}

class EmailFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final String? Function(String?)? validator;
  const EmailFormField(
      {Key? key,
      required this.textEditingController,
      this.onChanged,
      this.onFieldSubmitted,
      this.initialValue,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: (value) => TextFieldValidators.emailValidator(value),
      onChanged: (value) {},
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
        filled: true,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w200,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), gapPadding: 10),
      ),
    );
  }
}

class PasswordFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final bool? isConfirmPassword;
  final ValueChanged<String>? onFieldSubmitted;
  const PasswordFormField(
      {Key? key,
      required this.textEditingController,
      this.onChanged,
      this.onFieldSubmitted,
      this.obscureText = true,
      this.isConfirmPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? true,
      decoration: InputDecoration(
        hintText: isConfirmPassword ?? false ? "Confirm Password" : "Password",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon: const Icon(Icons.lock),
        contentPadding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
        filled: true,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w200,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), gapPadding: 10),
      ),
    );
  }
}
