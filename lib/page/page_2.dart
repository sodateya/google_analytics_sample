import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page2 extends ConsumerWidget {
  const Page2({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          'Page2',
          style: Theme.of(context).textTheme.headlineMedium,
        )),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'page2_1');
            },
            child: const Text('Page2-1へ遷移'),
          ),
        )
      ],
    );
  }
}
