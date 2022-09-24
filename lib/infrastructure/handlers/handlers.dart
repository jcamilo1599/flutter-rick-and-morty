import 'package:flutter/material.dart';

import '../../ui/pages/characters/characters.dart';

class Handlers {
  /// Todas las rutas de la app
  Map<String, WidgetBuilder> getRoutes(BuildContext context) =>
      <String, WidgetBuilder>{
        CharactersPage.routeName: (BuildContext context) =>
            const CharactersPage(),
      };

  /// Ruta inicial de la app
  String getInitialRoute() => CharactersPage.routeName;
}
