import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page3 extends ConsumerWidget {
  const Page3({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text(
        'Page3',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
