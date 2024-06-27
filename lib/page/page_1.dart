import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_analytics_sample/repository/analytics_repository.dart';

class Page1 extends ConsumerWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> logEvent() async {
      final analytics = ref.read(analyticsRepository);
      await analytics.logEvent(
        name: 'test_event',
        parameters: <String, dynamic>{
          'string': 'string_value',
          'int': 42,
          'long': 1234567890,
          'double': 42.0,
        },
      );
    }

    Future a() async {
      final analytics = ref.read(analyticsRepository);
      await analytics.logBeginCheckout(
          value: 230.0, //値段
          currency: 'JPY', //通過の種類
          items: [
            AnalyticsEventItem(
                itemName: 'Socks', itemId: 'xjw73ndnw', price: 320.0),
          ],
          coupon: '10PERCENTOFF');
    }

    Future b() async {
      final analytics = ref.read(analyticsRepository);
      analytics.setDefaultEventParameters({'version': '1.2.3'});
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          logEvent();
          a();
          b();
          print('pon');
        },
        child: const Text('Log Event 残す'),
      ),
    );
  }
}
