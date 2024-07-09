// import 'package:just_audio/just_audio.dart';

// import 'package:my_test/backend/repository/base_repository.dart';
// import 'package:my_test/backend/response/play_list_response.dart';
// import 'package:my_test/helpers/endpoint.dart';

// class PlayListRepository extends BaseRepository {
//   final audioPlayer = AudioPlayer();
//   // final List<PlayList> playList = [];
//   // List<MediaItem> offerMediaItems = [];

//   // Future<PlayListResponse> getplayLists() async {
//   //   var resPlayList = await dio.post(Endpoint.getTracks);
//   //   return PlayListResponse.fromJson(resPlayList.data);
//   // }

//   // Future<void> getPlayListMusic() async {
//   //   var resPlayAudio = await dio.post(Endpoint.getTracks);
//   //   playList.clear();
//   //   for (var item in resPlayAudio.data['data']) {
//   //     playList.add(
//   //       PlayList(
//   //         trackName: item['track_name'].toString(),
//   //         artistName: item['artist_name'].toString(),
//   //         pictureUrl: item['picture_url'].toString(),
//   //         trackUrl: item['track_url'].toString(),
//   //         listenCounter: item['listen_counter'] ?? 0,
//   //         albumName: item['album_name'].toString(),
//   //         trackId: item['track_id'] ?? 0,
//   //       ),
//   //     );

//   //     offerMediaItems.add(
//   //       MediaItem(
//   //         id: Endpoint.base + item['track_id'].toString(),
//   //         album: item['album_name'].toString(),
//   //         title: item['track_name'].toString(),
//   //         artist: item['artist_name'].toString(),
//   //         playable: item['track_url'].toString().isNotEmpty,
//   //       ),
//   //     );
//   //     await audioPlayer.setUrl(Endpoint.base + item['track_url'].toString());
//   //     // await audioPlayer.play();
//   //   }

//   //   // await audioPlayer.pause();
//   // }

//   // Future<void> getPlayListMusic() async {
//   //   var resPlayAudio = await dio.post(
//   //     Endpoint.getTracks,
//   //   );
//   //   playList.clear();
//   //   for (var item in resPlayAudio.data['data']) {
//   //     playList.add(
//   //       PlayList(
//   //         trackName: item['track_name'].toString(),
//   //         artistName: item['artist_name'].toString(),
//   //         pictureUrl: item['picture_url'].toString(),
//   //         trackUrl: item['track_url'].toString(),
//   //         listenCounter: item['listen_counter'] ?? 0,
//   //         albumName: item['album_name'].toString(),
//   //         trackId: item['track_id'] ?? 0,
//   //       ),
//   //     );

//   //     offerMediaItems.add(
//   //       MediaItem(
//   //         id: Endpoint.base + item['track_id'].toString(),
//   //         album: item['album_name'].toString(),
//   //         title: Endpoint.base + item['track_name'].toString(),
//   //         artist: Endpoint.base + item['artist_name'].toString(),
//   //         playable: item['track_url'].toString().isNotEmpty,
//   //       ),
//   //     );
//   //     await audioPlayer.setUrl(Endpoint.base + item['track_url'].toString());
//   //     await audioPlayer.play();
//   //     await audioPlayer.pause();
//   //   }
//   // }
// }
