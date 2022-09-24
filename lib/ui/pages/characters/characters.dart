import 'package:flutter/material.dart';

import '../../../config/use_case_config.dart';
import '../../../domain/helpers/dialog.dart';
import '../../../domain/models/characters/character.dart';
import '../../../domain/models/characters/characters_api_resp.dart';
import '../../common/molecules/card/card.dart';
import '../../templates/template_main.dart';
import 'widgets/serie_numbers.dart';

class CharactersPage extends StatefulWidget {
  static const String routeName = '/characters';

  const CharactersPage({Key? key}) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final UseCaseConfig _config = UseCaseConfig();
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
        const SerieNumbers(),
        Expanded(
          child: NotificationListener<Notification>(
            child: _buildList(),
            onNotification: (Notification notification) {
              final bool endOfScroll = _scrollController.position.pixels >=
                  (_scrollController.position.maxScrollExtent - 10);

              if (endOfScroll && !_isLoading && _nextPath != null) {
                _getCharacters(path: _nextPath!);
                _isLoading = true;
                setState(() {});
              }

              return true;
            },
          ),
        ),
        if (_isLoading)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  offset: Offset(0, -10),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: _buildLoading(),
              ),
            ),
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
      itemBuilder: (BuildContext context, int number) =>
          CardWidget(character: _list[number]),
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
    String? path = 'https://rickandmortyapi.com/api/character',
  }) async {
    final CharactersApiRespModel apiCharacters =
        await _config.charactersUseCase.getCharacters(path!);

    _nextPath = apiCharacters.info?.next;

    // En caso de tener un mensaje de error
    if (apiCharacters.message != null) {
      _openDialog(message: apiCharacters.message!);
    }

    // Si obtiene resultados
    if (apiCharacters.results != null) {
      _list = _list + apiCharacters.results!;
    }

    _isLoading = false;
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
            _getCharacters(path: _nextPath);
            _isLoading = false;
          },
          child: const Text('Reintentar'),
        ),
      ],
    );
  }
}
