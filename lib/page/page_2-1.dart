import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page2_1 extends ConsumerWidget {
  const Page2_1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page2-1'),
        ),
        body: Center(
            child: Text(
          'Page2-1',
          style: Theme.of(context).textTheme.headlineMedium,
        )));
  }
}
