import 'package:flutter/material.dart';

import '../../ui/pages/characters/characters.dart';
import '../driven_adapter/characters/characters_api.dart';
import '../driven_adapter/episodes/episodes_api.dart';

class Handlers {
  /// Todas las rutas de la app
  Map<String, WidgetBuilder> getRoutes(BuildContext context) =>
      <String, WidgetBuilder>{
        CharactersPage.routeName: (BuildContext context) => CharactersPage(
              charactersApi: CharactersListApi(),
              episodesApi: EpisodesListApi(),
            ),
      };

  /// Ruta inicial de la app
  String getInitialRoute() => CharactersPage.routeName;
}
