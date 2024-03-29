import 'package:flutter/material.dart';


class DashBoardModel{
  int id;
  Widget child;
  String name;
  IconData icon;

  DashBoardModel({
    required this.id,
    required this.child,
    required this.name,
    required this.icon,
});
}