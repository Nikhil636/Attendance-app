import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLogger implements ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    log('Provider Updated: ${provider.name}, $previousValue, $newValue, $container',
        name: 'ProviderLogger');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    log('Provider added: ${provider.name}, $value, $container',
        name: 'ProviderLogger');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    log('Provider disposed: ${provider.name}, $container',
        name: 'ProviderLogger');
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    log('Provider Failed: ${provider.name}, $error, $stackTrace, $container',
        name: 'ProviderLogger');
  }
}
