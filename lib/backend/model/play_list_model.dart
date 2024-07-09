class PlayList {
  String? trackUrl;
  String? pictureUrl;
  int? trackId;
  String? trackName;
  String? artistName;
  String? albumName;
  int? listenCounter;

  PlayList(
      {this.trackUrl,
      this.pictureUrl,
      this.trackId,
      this.trackName,
      this.artistName,
      this.albumName,
      this.listenCounter});

  PlayList.fromJson(Map<String, dynamic> json) {
    trackUrl = json['track_url'];
    pictureUrl = json['picture_url'];
    trackId = json['track_id'];
    trackName = json['track_name'];
    artistName = json['artist_name'];
    albumName = json['album_name'];
    listenCounter = json['listen_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['track_url'] = this.trackUrl;
    data['picture_url'] = this.pictureUrl;
    data['track_id'] = this.trackId;
    data['track_name'] = this.trackName;
    data['artist_name'] = this.artistName;
    data['album_name'] = this.albumName;
    data['listen_counter'] = this.listenCounter;
    return data;
  }
}
