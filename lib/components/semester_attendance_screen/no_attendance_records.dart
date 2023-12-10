import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/messages.dart';

class NoClassesAssigned extends StatelessWidget {
  const NoClassesAssigned({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/search_found.json'),
        Text(
          noClassAssigned,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
