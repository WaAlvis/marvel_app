import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget{
  final Function() onPressed;
  const AppbarCustom({Key? key, required this.onPressed}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions:  <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed:  onPressed,
        ),
        const SizedBox(
          width: 16,
        )
      ],
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child:  Row(
          children:   const <Widget>[
            CircleAvatar(
              foregroundImage: NetworkImage(
                  'https://as01.epimg.net/meristation/imagenes/2020/09/30/noticias/1601498876_582320_1601498920_noticia_normal.jpg'),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Nombre del Usuario',
            )
          ],
        ),
      ),
    );
  }
}
