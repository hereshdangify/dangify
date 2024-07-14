import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_test/backend/model/play_list_model.dart';
import 'package:my_test/helpers/endpoint.dart';
import 'package:my_test/backend/services/my_audio_handler.dart';

class PlayListController extends GetxController {
  List<MediaItem> offerMediaItems = [];
  final audioPlayer = AudioPlayer();
  // final List<PlayList> playList = [];
  // List<PlayList>? playList;

  final List<AudioService> audioService = [];
  final player = AudioService();
  MyAudioHandler myAudioHandler = MyAudioHandler();
  Dio dio = Dio(BaseOptions(baseUrl: Endpoint.base));

  Duration? totalDuration;
  Duration? currentPosition;

  final playList = <PlayList>[];
  RxInt selectedIndex = 0.obs;
  RxBool isPlaying = false.obs;

  bool isLoading = false;

  // void changeTrack(int index) {
  //   if (selectedIndex >= playList.length + 1) {
  //     selectedIndex.value = index;
  //   }
  // }

  playAndPause() async {
    audioPlayer.setUrl(Endpoint.base + playList[selectedIndex.value].trackUrl!);
    !audioPlayer.playing ? audioPlayer.play() : audioPlayer.pause();

    update();
  }

  getplayLists() async {
    isLoading = true;
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

      isLoading = false;
      update();
    }
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

  void forward() {
    selectedIndex.value = (selectedIndex.value + 1) % playList.length;
    audioPlayer.setUrl(Endpoint.base + playList[selectedIndex.value].trackUrl!);
    update();

    // if (controller.selectedIndex.value <
    //                             controller.playList.length - 1) {
    //                           controller.selectedIndex.value++;
    //                         } else {
    //                           controller.selectedIndex.value = 0;
    //                         }
  }

  void backward() {
    selectedIndex.value =
        (selectedIndex.value - 1 + playList.length) % playList.length;
    audioPlayer.setUrl(Endpoint.base + playList[selectedIndex.value].trackUrl!);
    update();

    // if (controller.selectedIndex.value > 0) {
    //                       controller.selectedIndex.value--;
    //                     } else {
    //                       controller.selectedIndex.value =
    //                           controller.playList.length - 1;
    //                     }
  }

  void selectedPlayList(int index) {
    selectedIndex.value = index;
    audioPlayer.setUrl(Endpoint.base + playList[selectedIndex.value].trackUrl!);
    update();
  }

  // Future<void> initAudio() async {
  //   totalDuration = await audioPlayer
  //       .setUrl(Endpoint.base + playList[0].trackUrl!.toString());
  //   audioPlayer.positionStream.listen((event) {
  //     currentPosition = event;
  //     update();
  //   });
  // }

  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  //   return '$twoDigitMinutes:$twoDigitSeconds';
  // }

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
    super.onInit();
  }
}
