import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../sistema.dart';
import '../utils/personalizacion.dart' as prs;

String img(String img) {
  if (img == null) return 'S/N';
  return (img.contains('https://', 0)
      ? img
      : img.length > 10
          ? ('${Sistema.storage}$img?alt=media')
          : '');
}

Widget acronicmo(String acronimo,
    {double width,
    double height,
    double fontSize: 30.0,
    Color color: Colors.white,
    int days: 90,
    int minutes: 0}) {
  return Container(
    color: color,
    width: width,
    height: height,
    child: Center(
      child: Text(
        acronimo,
        style: TextStyle(fontSize: fontSize, color: prs.colorTextDescription),
      ),
    ),
  );
}

Widget fadeImage(String img,
    {double width,
    double height,
    String acronimo: 'S/N',
    double fontSize: 30.0,
    Color color: Colors.white,
    int days: 90,
    int minutes: 0}) {
  if (img != null && img.contains('assets/', 0))
    return Image(
        width: width,
        height: height,
        image: AssetImage(img),
        fit: BoxFit.cover);

  if (img == null || img.toString().length <= 10 && acronimo == 'S/N')
    return Image(
        width: width,
        height: height,
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover);

  if (img == null || img.toString().length <= 10)
    return Container(
        color: color,
        width: width,
        height: height,
        child: Center(
          child: Text(
            acronimo,
            style:
                TextStyle(fontSize: fontSize, color: prs.colorTextDescription),
          ),
        ));

  return SizedBox(
    width: width,
    child: ClipRRect(
      child: img.isEmpty || img.length <= 10
          ? Image.asset('assets/no-image.png')
          : CachedNetworkImage(
              imageUrl: img,
              placeholder: (context, url) => Image.asset('assets/no-image.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/no-image.png'),
            ),
    ),
  );
}

ImageProvider image(String img) {
  if (img == null || img.toString().length <= 10)
    return AssetImage('assets/screen/direcciones.png');
  return Image(
    image: NetworkImage(img),
    fit: BoxFit.cover,
  ).image;
}
