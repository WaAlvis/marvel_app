import 'package:flutter/material.dart';
import 'package:marvel_app_test/models/models.dart';
import 'package:marvel_app_test/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailCharacterScreen extends StatelessWidget {
  static const String nameRoute = 'detail_character _screen';

  const DetailCharacterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    final marvelProvider = Provider.of<MarvelProvider>(context);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Personaje Marvel'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _PosterAndTitle(character),
                _SearchGoogle(
                  element: character.name,
                ),
                if (character.urls.isNotEmpty)
                  _UrlsCharacter(urlCharacter: character.urls),
                _OverView(character),
              ],
            ),
          )),
    );
  }
}

class _UrlsCharacter extends StatelessWidget {
  const _UrlsCharacter({Key? key, required this.urlCharacter})
      : super(key: key);

  final List<UrlCharacter> urlCharacter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: urlCharacter.length,
        itemBuilder: (_, i) {
          print(urlCharacter[i].url);
          return GestureDetector(
            onTap: () => _launchUrl(urlCharacter[i].url),
            child: Chip(
              avatar: CircleAvatar(
                child: Text(urlCharacter[i].type[0]),
              ),
                backgroundColor: Colors.blue,
                label: Text(urlCharacter[i].type, style: TextStyle(color: Colors.white),)),
          );
        },
        separatorBuilder: (_, i) => SizedBox(width: 10),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    print('***** $_url');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

class _SearchGoogle extends StatelessWidget {
  final String element;

  const _SearchGoogle({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ElevatedButton.icon(
          onPressed: () => _launchUrl(element),
          icon: Icon(Icons.travel_explore),
          label: Text('Resultados en Google'),
        )
      ],
    );
  }

  Future<void> _launchUrl(String element) async {
    final Uri _url = Uri.parse('https://www.google.com/search?q=$element');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

class _OverView extends StatelessWidget {
  final Character character;

  const _OverView(this.character, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Text(
        character.description.isNotEmpty
            ? character.description
            : 'no descripcion \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet dictum sit amet justo donec enim diam vulputate. Enim sed faucibus turpis in eu mi. Nibh cras pulvinar mattis nunc sed blandit libero. Cras tincidunt lobortis feugiat vivamus at augue eget arcu.',
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Character character;

  const _PosterAndTitle(
    this.character,
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Hero(
            tag: character.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  height: 160,
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(character.fullImgCharacter)),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      character.id.toString(),
                      style: textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
