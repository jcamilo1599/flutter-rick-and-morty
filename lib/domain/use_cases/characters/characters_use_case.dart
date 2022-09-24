import '../../models/characters/characters_api_resp.dart';
import '../../models/characters/gateway/characters_api_gateway.dart';

class CharactersUseCase {
  final CharactersApiGateway _gateway;

  CharactersUseCase(this._gateway);

  Future<CharactersApiRespModel> getCharacters(String path) async {
    return _gateway.getCharacters(path: path);
  }
}
