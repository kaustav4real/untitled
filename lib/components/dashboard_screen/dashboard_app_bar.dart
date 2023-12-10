import 'package:flutter/material.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:untitled/screens/logout_screen.dart';


class DashBoardAppBar extends StatelessWidget {
  const DashBoardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final  userInfo=getUserInfo();
    return Container(
      decoration: const BoxDecoration(
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
                userInfo.fullName,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
           Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                nextScreen(context, const LogoutScreen());
              },
              child: const Image(
                image: AssetImage('assets/college_logo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
