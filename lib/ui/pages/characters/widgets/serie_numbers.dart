import 'package:flutter/material.dart';

import '../../../../config/use_case_config.dart';
import '../../../../domain/helpers/dialog.dart';
import '../../../../domain/models/episodes/episodes_api_resp.dart';

class SerieNumbers extends StatefulWidget {
  const SerieNumbers({Key? key}) : super(key: key);

  @override
  State<SerieNumbers> createState() => _SerieNumbersState();
}

class _SerieNumbersState extends State<SerieNumbers> {
  final UseCaseConfig _config = UseCaseConfig();
  int _episodes = 0;
  bool _loadingEpisodes = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 1500), () async {
        await _getEpisodes();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Colors.grey.withOpacity(.2),
        child: Column(
          children: <Widget>[
            const Text(
              'La serie en números',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildEpisodesNumber(),
                const SizedBox(width: 4),
                const Text('número de episodios')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodesNumber() {
    Widget response = Text(
      _episodes.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );

    if (_loadingEpisodes) {
      response = _buildLoading();
    }

    return response;
  }

  Widget _buildLoading() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        SizedBox(
          height: 12,
          width: 12,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        SizedBox(width: 6),
      ],
    );
  }

  Future<void> _getEpisodes() async {
    final EpisodesApiRespModel apiEpisodes =
        await _config.episodesUseCase.getEpisodes();

    // En caso de tener un mensaje de error
    if (apiEpisodes.message != null) {
      _openDialog(message: apiEpisodes.message!);
    }

    // Si obtiene resultados
    if (apiEpisodes.info != null) {
      _episodes = apiEpisodes.info!.count;
    }

    _loadingEpisodes = false;
    setState(() {});
  }

  void _openDialog({required String message}) {
    dialog(
      context: context,
      title: 'Upps...',
      description: message,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            _getEpisodes();
            _loadingEpisodes = false;
          },
          child: const Text('Reintentar'),
        ),
      ],
    );
  }
}
