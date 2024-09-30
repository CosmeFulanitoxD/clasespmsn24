import 'package:flutter/material.dart';
import 'package:fluttersample1/database/movies_database.dart';
import 'package:fluttersample1/models/MoviesDAO.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key, this.moviesdao});

  Moviesdao? moviesdao;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  TextEditingController ConName = TextEditingController();
  TextEditingController ConOverView = TextEditingController();
  TextEditingController ConImgMovie = TextEditingController();
  TextEditingController ConRelease = TextEditingController();
  MoviesDatabase? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
    if (widget.moviesdao != null) {
      ConName.text = widget.moviesdao!.nameMovie!;
      ConOverView.text = widget.moviesdao!.overview!;
      ConImgMovie.text = widget.moviesdao!.imgMovie!;
      ConRelease.text = widget.moviesdao!.releaseDate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameMovie = TextFormField(
      controller: ConName,
      decoration: InputDecoration(hintText: 'nombre pleicula'),
    );
    final txtOverview = TextFormField(
      controller: ConOverView,
      maxLines: 5,
      decoration: InputDecoration(hintText: 'overview'),
    );
    final txtImgMovie = TextFormField(
      controller: ConImgMovie,
      decoration: InputDecoration(hintText: 'imagen'),
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: ConRelease,
      decoration: InputDecoration(hintText: 'fecha'),
      onTap: () async {
        DateTime? pickeddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025));
        if (pickeddate != null) {
          String formatteddate = DateFormat('dd-MM-yyyy').format(pickeddate);
          ConRelease.text = formatteddate;
          setState(() {});
        } else {}
      },
    );

    final btnsave = ElevatedButton(
      onPressed: () {
        moviesDatabase!.INSERT('tblmovies', {
          'nameMovie': ConName.text,
          'overview': ConOverView.text,
          'IdGenre': 1,
          'imgMovie': ConImgMovie.text,
          'releaseDate': ConRelease.text
        }).then((value) {
          if (value > 0) {
            GlobalValues.banUpdListMovies.value =
                !GlobalValues.banUpdListMovies.value;
            return QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Transaction Completed Successfully!',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          } else {
            return QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'something was wrong',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          }
        });
      },
      child: const Text('Guardar'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    );
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [txtNameMovie, txtOverview, txtImgMovie, txtRelease, btnsave],
    );
  }
}
