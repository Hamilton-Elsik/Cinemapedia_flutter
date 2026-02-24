
import '../entities/entities.dart';

abstract class ActorsDatasource {
  Future <List<Actor>> getActorsByMovie(String movieId);
}