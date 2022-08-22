import 'package:flutter/material.dart';
import 'package:marvel_app_test/providers/providers.dart';
import 'package:marvel_app_test/screens/screens.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MarvelSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar personajes';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptySuggestion();
    }

    final marvelProvider = Provider.of<MarvelProvider>(context, listen: false);

    return FutureBuilder(
        future: marvelProvider.searchCharacter(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Character>> snapshot) {
          if (!snapshot.hasData) return _emptySuggestion();

          final charactersSuggestion = snapshot.data!;

          return ListView.builder(
            itemCount: charactersSuggestion.length,
            itemBuilder: (_, int index) => _CharacterItem(
              charactersSuggestion[index],
            ),
          );
        });
  }

  Widget _emptySuggestion() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        size: 130,
      ),
    );
  }
}

class _CharacterItem extends StatelessWidget {
  final Character character;

  const _CharacterItem(this.character);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.id,
      child: ListTile(
        onTap: () => Navigator.pushNamed( context , DetailCharacterScreen.nameRoute, arguments: character),
        title: Text(character.name),
        leading: FadeInImage(
          width: 65,
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(character.fullImgCharacter),
        ),
      ),
    );
  }
}
