import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AutoDisposeCacheStrategy on AutoDisposeRef<dynamic> {
  ///Cache the provider for the given duration
  void cacheProvider(Duration duration, {void Function()? onDisposedCallback}) {
    KeepAliveLink keepAliveLink = keepAlive();
    Timer timer = Timer(duration, keepAliveLink.close);
    onDispose(() {
      timer.cancel();
      onDisposedCallback?.call();
    });
  }
}
