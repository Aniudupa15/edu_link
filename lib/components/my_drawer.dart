import 'package:flutter/material.dart';
class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(children: [

        // drawer header





        // home title
        ListTile(
          leading: Icon(Icons.home),
        )



        // profile title



        // user title
      ],),
      
      
    );
  }
}