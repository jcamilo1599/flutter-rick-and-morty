import '../domain/use_cases/characters/characters_use_case.dart';
import '../domain/use_cases/episodes/episodes_use_case.dart';
import '../infrastructure/driven_adapter/characters/characters_api.dart';
import '../infrastructure/driven_adapter/episodes/episodes_api.dart';

class UseCaseConfig {
  // Personajes
  late CharactersUseCase charactersUseCase;
  late CharactersApi _charactersApi;

  // Episodios
  late EpisodesUseCase episodesUseCase;
  late EpisodesApi _episodesApi;

  UseCaseConfig() {
    // Personajes
    _charactersApi = CharactersApi();
    charactersUseCase = CharactersUseCase(_charactersApi);

    // Episodios
    _episodesApi = EpisodesApi();
    episodesUseCase = EpisodesUseCase(_episodesApi);
  }
}
