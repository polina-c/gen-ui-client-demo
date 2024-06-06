import 'package:flutter/material.dart';

class GenUiRouter extends StatelessWidget {
  const GenUiRouter({super.key, required this.frameId});

  final String? frameId;

  @override
  Widget build(BuildContext context) {
    return switch (frameId) {
      '1' => const _Frame1(),
      '2' => const _Frame2(),
      '3' => const _Frame3(),
      _ => Text('fallback for frame $frameId'),
    };
  }
}

class _Frame1 extends StatelessWidget {
  const _Frame1();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: const Text('I am Widget for frame 1'),
    );
  }
}

class _Frame2 extends StatelessWidget {
  const _Frame2();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('I am widget for frame 2'),
    );
  }
}

class _Frame3 extends StatelessWidget {
  const _Frame3();

  @override
  Widget build(BuildContext context) {
    //return SizedBox.shrink();
    return ElevatedButton(
      onPressed: () {},
      child: Text('I am widget for frame 3',
          style:
              TextStyle(color: Colors.black, backgroundColor: Colors.yellow)),
    );
  }
}
