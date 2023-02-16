class TextFieldValidators {
  /// Validates the email field
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validates the password field
  static String? passwordValidator(String? val) {
    if (val!.isEmpty) {
      return 'Please enter your password';
    } else if (val.length < 8) {
      return 'Must have at least 8 alphanumeric characters';
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(val)) {
      return 'Must have combition of letters, number and special character';
    }
    return null;
  }

  /// Validates the name field
  static String? nameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Name is required';
    }
    return null;
  }
}
