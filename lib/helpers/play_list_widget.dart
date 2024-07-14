import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_test/helpers/endpoint.dart';
import 'package:my_test/modules/home/controllers/play_list_controller.dart';

class PlayListWidget extends StatelessWidget {
  PlayListWidget({Key? key}) : super(key: key);

  final PlayListController controller = Get.find<PlayListController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayListController>(
      builder: (_) {
        return SizedBox(
          height: controller.playList.length * 120,
          child: Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.playList.length,
              itemBuilder: (context, index) {
                final playList = controller.playList[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedPlayList(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.selectedIndex.value == index
                              ? Color.fromARGB(255, 71, 80, 99)
                              : Theme.of(context).scaffoldBackgroundColor),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child:
                                //Image-------------------------------------------------------------------
                                CachedNetworkImage(
                              imageUrl: Endpoint.base +
                                  playList.pictureUrl.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Title-----------------------------------------------------------
                              SizedBox(
                                width: 200,
                                child: Text(
                                  playList.trackName ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              //Name singer-----------------------------------------------------
                              Text(
                                playList.artistName ?? '',
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                fontSize: 30,
                                color: controller.selectedIndex.value == index
                                    ? Colors.red
                                    : Colors.white),
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
