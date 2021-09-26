import 'package:flutter/material.dart';
import 'package:startup_funding_prediction/authenticate/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:startup_funding_prediction/utilities/input_fields.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                await context.read<Authenticate>().signOut();
              },
              color: Colors.blue,
              child: Text('sign out'),
            ),
            MaterialButton(
              onPressed: () async {
                var data = await loadJsonFile('asset_files/fields.json');
                print(data['month'].toString());
              },
              color: Colors.blue,
              child: Text('Show Fields'),
            ),
          ]),
    );
  }
}
