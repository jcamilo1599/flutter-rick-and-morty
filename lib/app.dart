import 'package:flutter/material.dart';

import 'infrastructure/handlers/handlers.dart';
import 'source/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Handlers handlers = Handlers();

    return MaterialApp(
      title: 'Rick and Morty',
      routes: handlers.getRoutes(context),
      initialRoute: handlers.getInitialRoute(),
      theme: themeData,
    );
  }
}
