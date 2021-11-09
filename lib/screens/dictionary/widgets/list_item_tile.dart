import 'package:flutter/material.dart';

class ListItemTile extends StatelessWidget {
  final MapEntry dictionary;

  const ListItemTile({Key? key, required this.dictionary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.book_online),
          title: Text('${dictionary.key} : ${dictionary.value} '),

          dense: true,
        ),
        const Divider(),
      ],
    );
  }
}
