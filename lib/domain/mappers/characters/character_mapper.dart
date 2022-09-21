import '../../models/characters/character.dart';
import 'characters_api_resp_location_mapper.dart';
import 'characters_api_resp_origin_mapper.dart';

class CharacterMapper {
  Map<String, dynamic> data;

  CharacterMapper(this.data);

  CharacterModel execute() => CharacterModel(
        id: data['id'],
        name: data['name'],
        status: data['status'],
        species: data['species'],
        type: data['type'],
        gender: data['gender'],
        origin: CharactersApiRespOriginMapper(data['origin']).execute(),
        location: CharactersApiRespLocationMapper(data['location']).execute(),
        image: data['image'],
        episode: data['episode'],
        url: data['url'],
        created: data['created'],
      );
}
