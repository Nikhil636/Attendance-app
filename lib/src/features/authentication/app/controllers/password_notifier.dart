import 'package:hooks_riverpod/hooks_riverpod.dart' show AutoDisposeNotifier;

class PasswordFieldNotifier extends AutoDisposeNotifier<bool> {
  void toggle() {
    state = !state;
  }

  @override
  bool build() {
    return true;
  }
}
