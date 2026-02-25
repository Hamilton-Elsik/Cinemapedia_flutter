import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/entities/entities.dart';
import 'package:animate_do/animate_do.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(  String query );


class SearchMovieDelegate extends SearchDelegate<Movie?>{
  
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  
  Timer? _debouncerTimer; 

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }):super(
    searchFieldLabel: 'Buscar películas',
  );

  void clearStreams(){
    debouncedMovies.close();
  }

  void _onQueryChanged( String query ){
    isLoadingStream.add(true);

    if( _debouncerTimer?.isActive ??  false) _debouncerTimer!.cancel();

    _debouncerTimer = Timer(const Duration( milliseconds: 500), () async {
      final movies = await searchMovies( query );
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);

    });
  }

  Widget buidResultsAndSuggestions(){
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot){
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie){
              clearStreams();
              close(context, movie);
            }
          ),
        );
      },
    );
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot){
          if (  snapshot.data ?? false ){
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '', 
                icon: const Icon( Icons.refresh_rounded)
                ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '', 
              icon: const Icon( Icons.clear )
            ),
          );

        },
      ),
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}