import 'package:my_test/backend/model/play_list_model.dart';

class PlayListResponse {
  String? status;
  String? message;
  List<PlayList>? playLists;

  PlayListResponse({this.status, this.message, this.playLists});

  PlayListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      playLists = <PlayList>[];
      json['data'].forEach((v) {
        playLists!.add(new PlayList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.playLists != null) {
      data['data'] = this.playLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
