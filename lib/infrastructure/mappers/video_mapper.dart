import '../../domain/entities/entities.dart';

class VideoMapper {
  static moviedbVideoToEntity(moviedbVideo) => Video(
    id: moviedbVideo.id,
    name: moviedbVideo.name,
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt,
  );
}
