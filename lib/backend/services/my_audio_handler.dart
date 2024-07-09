import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  AudioPlayer audioPlayer = AudioPlayer();

// فانکشن ساخت آدیو سرویس از مدیا آیتم----------------------------------------------------
  UriAudioSource createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

// به تغییرات فهرست آهنگ فعلی گوش بده و مدیا آیتم رو بروز کن---------------------------------
  void listenForCurrentSongIndexChange() {
    audioPlayer.currentIndexStream.listen((index) {
      final playList = queue.value;
      if (index == null || playList.isEmpty) return;
      mediaItem.add(playList[index]);
    });
  }

  // وضعیت پخش فعلی رو بر اساس رویداد پخش دریافتی پخش کن---------------------------------
  void broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: audioPlayer.currentIndex,
      ),
    );
  }

  // فانکشن مقداردهی اولیه آهنگ ها و راه اندازی پخش صوتی-------------------------------------
  Future<void> initSongs({required List<MediaItem> songs}) async {
    // به رویداد پخش گوش کن و وضعیت رو پخش کن------------------------------------------------
    audioPlayer.playbackEventStream.listen(broadcastState);

    //فهرستی از لیست آهنگ های ایجاد شده آدیو سورس------------------------
    final audioSource = songs.map(createAudioSource).toList();

    // آدیو سورس رو پیوسته از آدیو پلیر از آدیو سورس تنظیم میکنه---------------------------
    await audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: audioSource));

    // فهرست آهنگ ها رو از آدیو سورس بگیر و در صف پخش قرار بده---------------------------
    queue.value.clear();
    queue.value.addAll(songs);
    queue.add(queue.value);

    // به تغییرات توی فهرست آهنگ فعلی گوش بده-------------------------
    listenForCurrentSongIndexChange();

    // بعد تموم شدن آهنگ برو بعدی
    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) skipToNext();
    });
  }

  @override
  Future<void> play() => audioPlayer.play();

  @override
  Future<void> pause() async => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

//یه مورد خاص از صف رو پخش کن
  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  //تو صف به آهنگ بعدی برو----------------------------------------------
  @override
  Future<void> skipToNext() => audioPlayer.seekToNext();

  //تو صف به آهنگ قبلی برو----------------------------------------------
  @override
  Future<void> skipToPrevious() => audioPlayer.seekToPrevious();
}
