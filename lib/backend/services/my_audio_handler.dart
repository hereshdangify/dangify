import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_test/backend/model/play_list_model.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    notifyAudioHandlerAboutPlaybackEvents();
  }

  void notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
      ));
    });
  }

  playPlaylist() async {
    PlayList? playlist;
    if (playlist!.trackUrl != null) {
      await _player.setUrl(playlist.trackUrl!);
      _updateMediaItem(playlist);
      _player.play();
    }
  }

  void _updateMediaItem(PlayList playlist) {
    mediaItem.add(
      MediaItem(
        id: playlist.trackId.toString(),
        album: playlist.albumName ?? '',
        title: playlist.trackName ?? '',
        artist: playlist.artistName ?? '',
        artUri: Uri.parse(playlist.pictureUrl ?? ''),
        duration: _player.duration,
      ),
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();
}
