import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../domain/models/characters/characters_api_resp.dart';
import '../../../domain/models/characters/gateway/characters_api_gateway.dart';
import '../../mappers/characters/characters_api_resp_mapper.dart';

class CharactersApi implements CharactersApiGateway {
  @override
  Future<CharactersApiRespModel> getCharacters({required String path}) async {
    CharactersApiRespModel response;

    try {
      final Uri url = Uri.parse(path);
      final http.Response httpResponse = await http.get(url);
      final CharactersApiRespMapper charactersApiMapper =
          CharactersApiRespMapper(
        json.decode(utf8.decode(httpResponse.bodyBytes)),
      );

      response = charactersApiMapper.execute();
    } on Exception catch (error) {
      String message = '';

      if (error is HttpException) {
        message = 'Se produjo un error... HttpException';
      } else if (error is FormatException) {
        message = 'Se produjo un error... FormatException';
      } else if (error is SocketException) {
        message = 'Se produjo un error... SocketException';
      } else if (error is TimeoutException) {
        message = 'Se produjo un error... TimeoutException';
      } else {
        message = 'Se produjo un error indefinido ☠️';
      }

      response = CharactersApiRespModel(
        info: null,
        results: null,
        message: message,
      );
    }

    return response;
  }
}
