

//Este repositorio es inmutable
import 'package:flutter_cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});