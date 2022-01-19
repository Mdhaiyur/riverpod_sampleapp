import 'package:flutter_riverpod/flutter_riverpod.dart';

class Observer extends ProviderObserver {
  @override
  void didDisposeProvider(
      ProviderBase provider, ProviderContainer containers) {}

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print('''
     {   
       "provider": "${provider.name ?? provider.runtimeType}",
       "newValue": "$newValue"
     }''');
  }
}
