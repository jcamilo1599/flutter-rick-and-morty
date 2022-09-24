import '../../../domain/models/characters/characters_api_resp_origin.dart';

class CharactersApiRespOriginMapper {
  Map<String, dynamic> data;

  CharactersApiRespOriginMapper(this.data);

  CharactersApiRespOriginModel execute() {
    return CharactersApiRespOriginModel(
      name: data['name'],
      url: data['url'],
    );
  }
}
