import '../../models/characters/characters_api_resp_location.dart';

class CharactersApiRespLocationMapper {
  Map<String, dynamic> data;

  CharactersApiRespLocationMapper(this.data);

  CharactersApiRespLocationModel execute() {
    return CharactersApiRespLocationModel(
      name: data['name'],
      url: data['url'],
    );
  }
}
