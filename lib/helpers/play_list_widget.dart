import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_test/backend/model/play_list_model.dart';
import 'package:my_test/helpers/endpoint.dart';

class PlayListWidget extends StatelessWidget {
  const PlayListWidget({Key? key, required this.playList}) : super(key: key);

  final List<PlayList> playList;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return SizedBox(
          height: playList.length * 120,
          child: Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: playList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child:

                                //Image-------------------------------------------------------------------
                                CachedNetworkImage(
                              imageUrl:
                                  Endpoint.base + playList[index].pictureUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Title-----------------------------------------------------------
                              Text(
                                playList[index].trackName ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),

                              //Name singer-----------------------------------------------------
                              Text(
                                playList[index].artistName ?? '',
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
