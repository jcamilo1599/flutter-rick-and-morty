import '../../models/episodes/episodes_api_resp.dart';
import '../../models/episodes/gateway/episodes_api_gateway.dart';

class EpisodesUseCase {
  final EpisodesApiGateway _gateway;

  EpisodesUseCase(this._gateway);

  Future<EpisodesApiRespModel> getEpisodes() async {
    return _gateway.getEpisodes();
  }
}
