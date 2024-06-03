// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DrawerBodyClass {
  IconData icon;
  String title;
  void Function() onTap;
  DrawerBodyClass({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
