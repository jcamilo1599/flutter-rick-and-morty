import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../domain/interfaces/episodes/episodes_api_interface.dart';
import '../../../domain/mappers/episodes/episodes_api_resp_mapper.dart';
import '../../../domain/models/episodes/episodes_api_resp.dart';

class EpisodesListApi implements EpisodesApiInterface {
  @override
  Future<EpisodesApiRespModel> execute() async {
    EpisodesApiRespModel response;

    try {
      final Uri url = Uri.parse('https://rickandmortyapi.com/api/episode');
      final http.Response httpResponse = await http.get(url);
      final EpisodesApiRespMapper charactersApiMapper = EpisodesApiRespMapper(
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

      response = EpisodesApiRespModel(
        info: null,
        results: null,
        message: message,
      );
    }

    return response;
  }
}
