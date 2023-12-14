import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodPage extends ConsumerWidget {
  const RiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.read(itemsProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            items[index],
          ),
        ),
      ),
    );
  }
}

final itemsProvider = Provider<List<String>>(
  (ref) => throw UnimplementedError('Needs configuration'),
);
