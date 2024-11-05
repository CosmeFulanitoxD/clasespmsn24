import 'package:flutter/material.dart';
import 'package:fluttersample1/database/movies_database.dart';
import 'package:fluttersample1/models/MoviesDAO.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key, this.moviesdao});

  MoviesDAO? moviesdao;

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

    final btnSave = ElevatedButton(
      onPressed: () {
        if (widget.moviesdao! == null) {
          moviesDatabase!.INSERT('tblmovies', {
            'nameMovie': ConName.text,
            'overview': ConOverView.text,
            'idGenre': 1,
            'imgMovie': ConImgMovie.text,
            'releaseDate': ConRelease.text,
          }).then((value) {
            if (value > 0) {
              GlobalValues.banUpdListMovies.value =
                  !GlobalValues.banUpdListMovies.value;
              return QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Transaction Completed Successfully!',
                  autoCloseDuration: const Duration(seconds: 2),
                  showConfirmBtn: true);
            } else {
              return QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  text: 'Something was wrong!',
                  autoCloseDuration: const Duration(seconds: 2),
                  showConfirmBtn: true);
            }
          });
        } else {
          moviesDatabase!.UPDATE('tblmovies', {
            'idMovie': widget.moviesdao!.idMovie,
            'nameMovie': ConName.text,
            'overview': ConOverView.text,
            'idGenre': 1,
            'imgMovie': ConImgMovie.text,
            'releaseDate': ConRelease.text,
          }).then((value) {
            final msj;
            QuickAlertType type = QuickAlertType.success;
            if (value > 0) {
              GlobalValues.banUpdListMovies.value =
                  !GlobalValues.banUpdListMovies.value;
              type = QuickAlertType.success;
              msj = 'Transaction Completed successfully';
            } else {
              type = QuickAlertType.error;
              msj = 'Something went wrong';
            }
            return QuickAlert.show(
                context: context,
                type: type,
                text: msj,
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false);
          });
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
      child: const Text('Guardar'),
    );
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [txtNameMovie, txtOverview, txtImgMovie, txtRelease, btnSave],
    );
  }
}
