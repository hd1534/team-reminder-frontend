import 'package:flutter/material.dart';

import 'package:team_reminder_frontend/widgets/group.dart';

class Groupthread extends StatelessWidget {
  const Groupthread({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(48, 48, 48, 0.8),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: GroupWidget(),
        ),
        Expanded(
          flex: 2,
          child: Container(color: Colors.red),
        ),
      ]),
    );
  }
}
