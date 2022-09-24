import '../../../domain/models/characters/character.dart';
import '../../../domain/models/characters/characters_api_resp.dart';
import 'character_mapper.dart';
import 'characters_api_resp_info_mapper.dart';

class CharactersApiRespMapper {
  Map<String, dynamic> data;

  CharactersApiRespMapper(this.data);

  CharactersApiRespModel execute() {
    final List<CharacterModel>? characters = (data['results'] != null)
        ? List<CharacterModel>.from(data['results'].map((dynamic character) {
            return CharacterMapper(character).execute();
          }))
        : null;

    return CharactersApiRespModel(
      info: CharactersApiRespInfoMapper(data['info']).execute(),
      results: characters,
    );
  }
}
