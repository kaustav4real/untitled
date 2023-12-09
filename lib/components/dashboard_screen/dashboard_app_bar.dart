import 'package:flutter/material.dart';
import 'package:untitled/helpers/date_functions.dart';

class DashBoardAppBar extends StatelessWidget {
  const DashBoardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.transparent)],
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('WELCOME BACK', style: Theme.of(context).textTheme.titleSmall,),
              Text(
                'DR RUPAM BARUAH',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Image(
              image: AssetImage('assets/college_logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
