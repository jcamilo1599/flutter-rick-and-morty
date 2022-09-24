import '../characters_api_resp.dart';

abstract class CharactersApiGateway {
  Future<CharactersApiRespModel> getCharacters({required String path});
}
