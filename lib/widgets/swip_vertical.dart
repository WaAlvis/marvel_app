import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marvel_app_test/models/models.dart';
import 'dart:math' show Random;

import 'package:marvel_app_test/screens/screens.dart';

class SwipVertical extends StatelessWidget {
  final List<Comic> listComics;

  const SwipVertical({
    Key? key,
    required this.listComics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String rating = '3.5';
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const _TitleSection(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: listComics.isEmpty
              ? const CupertinoActivityIndicator()
              : ListView.separated(
                  itemCount: 7,
                  itemBuilder: (_, i) {
                    final comic = listComics[i];
                    return Hero(
                      tag: comic.id,
                      child: _CardView(
                        comic,
                        onTap: () => Navigator.pushNamed(
                            context, DetailComicScreen.nameRoute,
                            arguments: comic,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 12,
                  ),
                ),
        )
      ],
    );
  }
}

class _CardView extends StatelessWidget {
  final Comic comic;
  final void Function()? onTap;

  const _CardView(
    this.comic, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImgCard(comic.fullCoverImg),
          const SizedBox(
            width: 20,
          ),
          _DataTextCard(comic)
        ],
      ),
    );
  }
}

class _DataTextCard extends StatelessWidget {
  final Comic comic;

  const _DataTextCard(
    this.comic, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = Random().nextInt(5) + 1.5;
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comic.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              RatingBarIndicator(
                rating: rating.toDouble(),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 4,
                itemSize: 20.0,
                // direction: Axis.vertical,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                rating.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text('ID: ${comic.id} ',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('U.S PRICE \$${comic.priceComic}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Icon(Icons.arrow_forward),
            ],
          )
        ],
      ),
    );
  }
}

class _ImgCard extends StatelessWidget {
  final String imgPath;

  const _ImgCard(
    this.imgPath, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 150,
        width: 115,
        placeholder: AssetImage('assets/no-image.jpg'),
        image: NetworkImage(imgPath),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text(
          'Comics',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text('Ver todos'),
      ],
    );
  }
}
