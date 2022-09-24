import '../episodes_api_resp.dart';

abstract class EpisodesApiGateway {
  Future<EpisodesApiRespModel> getEpisodes();
}
