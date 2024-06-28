import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_analytics_sample/repository/analytics_repository.dart';

class Page1 extends ConsumerWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ボタンを押したイベントなどを記録したい時に使う
    Future<void> logEvent() async {
      final analytics = ref.read(analyticsRepository);
      await analytics.logEvent(
        name: 'test_event', //イベントの名前
        parameters: <String, dynamic>{
          //自由にパラメーターを決める
          'string': 'string_value',
          'int': 42,
          'long': 1234567890,
          'double': 42.0,
        },
      );
    }

    //以下eコマース(購入系？)ログ
    //購入開始のログ
    Future beginCheckout() async {
      final analytics = ref.read(analyticsRepository);
      await analytics.logBeginCheckout(
          value: 230.0, //値段
          currency: 'JPY', //通過の種類
          items: [
            AnalyticsEventItem(
                itemName: 'Socks', itemId: 'xjw73ndnw', price: 320.0),
          ],
          coupon: '10PERCENTOFF');
      print('BeginCheckout');
    }

    //支払い情報を送信したときに送る
    Future addPaymentInfo() async {
      await FirebaseAnalytics.instance.logAddPaymentInfo(
        currency: 'USD',
        value: 15.98,
        coupon: "SUMMER_FUN",
        paymentType: "Visa",
        items: [
          AnalyticsEventItem(
              itemName: 'Socks', itemId: 'xjw73ndnw', price: 320.0),
        ],
      );
      print('AddPaymentInfo');
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          logEvent();
          // b();
          // print('pon');
        },
        child: const Text('Log Event 残す'),
      ),
    );
  }
}
