import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_test/backend/model/play_list_model.dart';
import 'package:my_test/helpers/endpoint.dart';
import 'package:my_test/backend/services/my_audio_handler.dart';

class PlayListController extends GetxController {
  List<MediaItem> offerMediaItems = [];
  AudioPlayer audioPlayer = AudioPlayer();
  final List<PlayList> playList = [];
  final List<AudioService> audioService = [];
  final player = AudioService();
  MyAudioHandler myAudioHandler = MyAudioHandler();
  Dio dio = Dio(BaseOptions(baseUrl: Endpoint.base));

  Duration? totalDuration;
  Duration? currentPosition;

  getplayLists() async {
    var resPlayList = await dio.post(Endpoint.getTracks);
    playList.clear();
    for (var item in resPlayList.data['data']) {
      playList.add(
        PlayList(
          trackName: item['track_name'].toString(),
          artistName: item['artist_name'].toString(),
          pictureUrl: item['picture_url'].toString(),
          trackUrl: item['track_url'].toString(),
          listenCounter: item['listen_counter'] ?? 0,
          albumName: item['album_name'].toString(),
          trackId: item['track_id'] ?? 0,
        ),
      );
    }
    // log("kkkkkkkkk ${playList.length.toString()}");
    castTrackModeltoMediaItem();
    update();
  }

  castTrackModeltoMediaItem() {
    offerMediaItems.clear();
    for (var item in playList) {
      offerMediaItems.add(
        MediaItem(
          id: Endpoint.base + item.trackUrl.toString(),
          album: item.albumName ?? '',
          title: item.trackName ?? '',
          artist: item.artistName ?? '',
          artUri: Uri.parse(Endpoint.base + item.pictureUrl.toString()),
          playable: item.trackUrl.toString().isNotEmpty,
        ),
      );
    }
  }

  togglePlayPause() {
    // !audioPlayer.playing ? audioPlayer.play() : audioPlayer.pause();
    myAudioHandler.play();
    myAudioHandler.pause();
    update();
  }

  Future<void> initAudio() async {
    totalDuration = await audioPlayer
        .setUrl(Endpoint.base + playList[0].trackUrl.toString());
    audioPlayer.positionStream.listen((event) {
      currentPosition = event;
      update();
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  // togglePlayPause() {
  //   if (isPlaying.value) {
  //     audioPlayer.play();
  //   } else if (!isPlaying.value) {
  //     audioPlayer.pause();
  //   }
  //   update();
  // }

  @override
  void onInit() {
    getplayLists();
    togglePlayPause();
    initAudio();

    super.onInit();
  }
}
