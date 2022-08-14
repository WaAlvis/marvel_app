import 'package:flutter/material.dart';
import 'package:marvel_app_test/models/models.dart';
import 'package:marvel_app_test/screens/detail_character_screen.dart';

class SliderHorizontalCard extends StatefulWidget {
  final List<Character> characters;
  final Function onNextPage;

  const SliderHorizontalCard({
    required this.characters,
    Key? key, required this.onNextPage,
  }) : super(key: key);

  @override
  State<SliderHorizontalCard> createState() => _SliderHorizontalCardState();

}

class _SliderHorizontalCardState extends State<SliderHorizontalCard> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        print('llamar provider para obtener nuevos personajes');
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text(
              'Personajes Marvel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text('Ver todos'),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Flexible(
          child: ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.characters.length,
            itemBuilder: (_, int i) {
              final character = widget.characters[i];
              return  CardSwip(character);
            },
            separatorBuilder: (_, int i) {
              return const SizedBox(
                width: 10,
              );
            },
          ),
        )
      ],
    );
  }
}

class CardSwip extends StatelessWidget {
  final Character character;

  const CardSwip(
    this.character, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,

      child: GestureDetector(
        onTap: ()=>Navigator.pushNamed(context, DetailCharacterScreen.nameRoute, arguments: character),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: character.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage(
                  fit: BoxFit.cover,
                  height: 180,
                  width: 130,
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(character.fullImgCharacter),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              character.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
