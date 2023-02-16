import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordFieldNotifier extends AutoDisposeNotifier<bool> {
  void toggle() {
    state = !state;
  }

  @override
  bool build() {
    return true;
  }
}
