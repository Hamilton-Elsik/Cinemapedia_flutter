import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/actor.dart';

import '../mappers/mappers.dart';
import '../models/models.dart';

class ActorMovieDBDatasource extends ActorsDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX',
    },

  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    final response = await dio.get(
      '/movie/$movieId/credits',
    );

    final castResponse =  CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }
}