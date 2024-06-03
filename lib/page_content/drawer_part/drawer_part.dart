import 'package:flutter/material.dart';
import 'package:movie_app/page_content/drawer_part/drawer_body.dart';

class DrawerPart extends StatefulWidget {
  const DrawerPart({super.key});

  @override
  State<DrawerPart> createState() => _DrawerPartState();
}

class _DrawerPartState extends State<DrawerPart> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: DrawerBody(),
    );
  }
}
