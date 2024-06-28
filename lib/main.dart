import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_analytics_sample/firebase_options.dart';
import 'package:google_analytics_sample/page/page_1.dart';
import 'package:google_analytics_sample/page/page_2.dart';
import 'package:google_analytics_sample/page/page_3.dart';
import 'package:google_analytics_sample/provider/bottom_navigation_provider.dart';
import 'package:google_analytics_sample/repository/analytics_repository.dart';
import 'package:google_analytics_sample/router/sample_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //main関数内でsetDefaultEventParametersを呼ぶことで,全てのイベントでデフォルトで記録しておきたいものを設定してける
  //version,uid,など設定しておくと便利かも
  final container = ProviderContainer();
  await container.read(analyticsRepository).setDefaultEventParameters(
      {'version': '1.2.3', 'uid': 'fdshfasasas02okndabfiau'});

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsObserver = ref.watch(analyticsObserverRepository);
    return MaterialApp(
      navigatorObservers: [analyticsObserver], //画面遷移を監視するための仕組み
      title: 'Google Analytics Sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: Routes.routes,
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationBarIndexProvider);
    void setDefaultEventParameters() async {
      final analyticsService = ref.read(analyticsRepository);
      await analyticsService.setDefaultEventParameters({'version': '1.2.3'});
    }

    // 画面が表示される時にデフォルトのイベントパラメータを設定
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setDefaultEventParameters();
    });
    final List<Widget> pages = [
      const Page1(),
      const Page2(),
      const Page3(),
    ];

    void onItemTapped(int index) {
      final analytics = ref.read(analyticsRepository);
      ref.read(bottomNavigationBarIndexProvider.notifier).state = index;
      //ボトムナビゲーションバーを使う際は、pushで遷移しないため自動的に記録されないため任意の名前を入れて記録させると良さそう
      //ページをenumにしたりすると良いかも
      analytics.logScreenView(screenName: '名前');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Analytics Sample'),
      ),
      body: pages[currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'Page1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Page2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: 'Page3',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }
}
