import 'package:flutter/material.dart';
import 'package:google_analytics_sample/page/page_1.dart';
import 'package:google_analytics_sample/page/page_2-1.dart';
import 'package:google_analytics_sample/page/page_2.dart';
import 'package:google_analytics_sample/page/page_3.dart';

/// ルーティング管理
/// 基本的にインスタンス化せずに利用します
class Routes {
  /// ルーティング一覧
  static final Map<String, Widget Function(BuildContext)> routes = {
    'page1': (context) => const Page1(),
    'page2': (context) => const Page2(),
    'page2_1': (context) => const Page2_1(),
    'page3': (context) => const Page3(),
  };
}
