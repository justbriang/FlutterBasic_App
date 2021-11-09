import 'package:flutter/material.dart';
import 'package:flutterbasic/core/models/response.dart';

class ListItemTile extends StatelessWidget {
  final Response response;

  const ListItemTile({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text(response.title!),
          subtitle: Text(response.completed.toString()),
          dense: true,
        ),
        Divider(),
      ],
    );
  }
}
