import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final String text;
  const PaddedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall,),
    );
  }
}


