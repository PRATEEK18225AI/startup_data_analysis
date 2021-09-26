import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:startup_funding_prediction/authenticate/auth_service.dart';
import 'package:startup_funding_prediction/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authenticate>(create: (context) => Authenticate()),
        StreamProvider(
            create: (context) => context.read<Authenticate>().authStateChanges,
            initialData: null),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
