import 'package:flutter/material.dart';
import 'package:fluttersample1/models/Popular_moviedao.dart';
import 'package:fluttersample1/provider/test_provider.dart';
import 'package:fluttersample1/provider/test_provider.dart';
import 'package:provider/provider.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments
        as PopularMovieDao; //recupera los datos de una ruta
    final testprovider = Provider.of<TestProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => testprovider.name = 'Rubensin',
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          opacity: .7,
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
        )),
      ),
    );
  }
}
