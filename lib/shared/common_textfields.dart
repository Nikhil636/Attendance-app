import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../src/features/authentication/app/providers/auth_providers.dart';
import '../src/utils/textfield_validators.dart';

class NameFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  const NameFormField(
      {Key? key,
      required this.textEditingController,
      this.onChanged,
      this.onFieldSubmitted,
      this.initialValue,
      this.autovalidateMode,
      this.validator,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: <FilteringTextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      autofillHints: const <String>[AutofillHints.name],
      autocorrect: true,
      maxLength: 25,
      validator: TextFieldValidators.nameValidator,
      onChanged: onChanged,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: 'Enter Full Name',
        labelText: 'Full Name',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
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
      onFieldSubmitted: onFieldSubmitted,
      validator: TextFieldValidators.emailValidator,
      onChanged: onChanged,
      autofillHints: const <String>[AutofillHints.email],
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintText: 'Enter your Email',
        fillColor: Colors.white,
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
      ),
    );
  }
}

class PasswordFormField extends ConsumerWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final bool? isConfirmPassword;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  const PasswordFormField({
    super.key,
    this.onEditingComplete,
    required this.textEditingController,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.isConfirmPassword = false,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isVisible = ref.watch(passwordVisibiltyProvider);
    return TextFormField(
      controller: textEditingController,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator ?? TextFieldValidators.passwordValidator,
      obscureText: isVisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: true,
      textInputAction: textInputAction,
      autocorrect: true,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: const <String>[AutofillHints.password],
      decoration: InputDecoration(
        hintText: isConfirmPassword ?? false
            ? 'Retype your password'
            : 'Enter your password',
        labelText: isConfirmPassword ?? false ? 'Confirm Password' : 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: GestureDetector(
          onTap: () => ref.read(passwordVisibiltyProvider.notifier).toggle(),
          child: isVisible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        filled: true,
        errorMaxLines: 2,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),
      ),
    );
  }
}
