import 'package:flutter/material.dart';

import '../../../domain/helpers/dialog.dart';
import '../../../domain/interfaces/characters/characters_api_interface.dart';
import '../../../domain/interfaces/episodes/episodes_api_interface.dart';
import '../../../domain/models/characters/character.dart';
import '../../../domain/models/characters/characters_api_resp.dart';
import '../../molecules/card/card.dart';
import '../../templates/template_main.dart';
import 'widgets/serie_numbers.dart';

class CharactersPage extends StatefulWidget {
  static const String routeName = '/characters';

  final CharactersApiInterface charactersApi;
  final EpisodesApiInterface episodesApi;

  const CharactersPage({
    required this.charactersApi,
    required this.episodesApi,
    Key? key,
  }) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();
  List<CharacterModel> _list = <CharacterModel>[];
  bool _isLoading = false;
  String? _nextPath;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCharacters();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateMainWidget(
      title: 'Rick and Morty',
      body: _list.isEmpty && _isLoading ? _buildLoading() : _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        SerieNumbers(episodesApi: widget.episodesApi),
        Expanded(
          child: NotificationListener<Notification>(
            child: _buildList(),
            onNotification: (Notification notification) {
              final bool endOfScroll = _scrollController.position.pixels >=
                  (_scrollController.position.maxScrollExtent - 10);

              if (endOfScroll && !_isLoading) {
                _isLoading = true;
                setState(() {});
              } else if (!endOfScroll && _isLoading) {
                _isLoading = false;
                setState(() {});
              }

              return true;
            },
          ),
        ),
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: _buildLoading(),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _list.length,
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (BuildContext context, int number) {
        Widget response = const SizedBox.shrink();

        if ((number + 1) == _list.length && _nextPath != null && !_isLoading) {
          _getCharacters(path: _nextPath!, firstLoading: true);
        } else {
          response = CardWidget(character: _list[number]);
        }

        return response;
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _getCharacters({
    String path = 'https://rickandmortyapi.com/api/character',
    bool firstLoading = false,
  }) async {
    if (!firstLoading) {
      _isLoading = true;
      setState(() {});
    }

    final CharactersApiRespModel apiCharacters =
        await widget.charactersApi.execute(path: path);

    _nextPath = apiCharacters.info?.next;

    // En caso de tener un mensaje de error
    if (apiCharacters.message != null) {
      await dialog(
        context: context,
        title: 'Upps...',
        description: apiCharacters.message!,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getCharacters();
              _isLoading = false;
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    }

    // Si obtiene resultados
    if (apiCharacters.results != null) {
      _list = _list + apiCharacters.results!;
    }

    if (!firstLoading) {
      _isLoading = false;
    }

    setState(() {});
  }
}
