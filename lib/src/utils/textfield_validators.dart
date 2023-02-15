class TextFieldValidators {
  static String emailValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    return 'Email is mdanatory';
  }

  // static String? passwordValidator(String? value) {
  //   if (value?.isEmpty) {
  //     return 'Password is required';
  //   }
  //   if (value?.length ?? fals0 < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   return null;
  // }

  static String? nameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Name is required';
    }
    return null;
  }
}
