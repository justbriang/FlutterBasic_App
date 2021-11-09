import 'package:flutter/material.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
        height: 24.0,
        width: 150.0,
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        color: Colors.grey[200]);
  }
}
