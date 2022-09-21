import 'package:flutter/material.dart';

import '../../../domain/models/characters/character.dart';
import '../../templates/template_main.dart';

class CharactersDetailPage extends StatefulWidget {
  static const String routeName = '/detail_character';

  final CharacterModel character;

  const CharactersDetailPage({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  _CharactersDetailPageState createState() => _CharactersDetailPageState();
}

class _CharactersDetailPageState extends State<CharactersDetailPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateMainWidget(
      title: widget.character.name,
      body: ListView(
        //padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 40),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 400,
              ),
              Material(
                elevation: 2,
                child: Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(2), // Border radius
                    child:
                        ClipOval(child: Image.network(widget.character.image)),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: _buildData(),
          ),
        ],
      ),
    );
  }

  Widget _buildData() {
    return Column(
      children: <Widget>[
        _buildText(title: 'Genero: ', description: widget.character.gender),
        const SizedBox(height: 4),
        _buildText(
          title: 'Origen: ',
          description: widget.character.origin.name,
        ),
        const SizedBox(height: 4),
        _buildText(
          title: 'Ubicación: ',
          description: widget.character.location.name,
        ),
        const SizedBox(height: 4),
        _buildText(
          title: 'Número de episodios: ',
          description: widget.character.episode.length.toString(),
        ),
        const SizedBox(height: 4),
        _buildText(
          title: 'Fecha de creación: ',
          description: widget.character.created,
        ),
      ],
    );
  }

  Widget _buildText({
    required String title,
    required String description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Flexible(
          child: Text(
            description,
            style: const TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
