import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_test/modules/home/controllers/play_list_controller.dart';

class MusicWidget extends StatelessWidget {
  const MusicWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayListController>(
        init: PlayListController(),
        builder: (controller) {
          return Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color(0xffE76F51),
                  thumbColor: Color(0xffE76F51),
                ),

                //Slider--------------------------------------------------------------------
                child: Slider(
                  value: controller.currentPosition == null
                      ? 0
                      : (controller.currentPosition!.inSeconds /
                          controller.totalDuration!.inSeconds),
                  onChanged: (value) {
                    controller.audioPlayer.seek(
                      Duration(
                        seconds: (value * controller.totalDuration!.inSeconds)
                            .round(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    //Total time-------------------------------------------------------------
                    Text(
                      // controller.totalDuration == null
                      // ?
                      '00:00',
                      // : controller
                      //     .formatDuration(controller.totalDuration!),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),

                    //Current time-----------------------------------------------------------
                    Text(
                      // controller.currentPosition == null
                      // ?
                      '00:00',
                      // : controller
                      //     .formatDuration(controller.currentPosition!),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: Row(
                  children: [
                    Icon(Iconsax.repeate_music4, color: Colors.white, size: 40),
                    Spacer(),
                    Row(
                      children: [
                        //backward-------------------------------------------------
                        IconButton(
                          onPressed: () {
                            if (controller.selectedIndex.value > 0) {
                              controller.selectedIndex.value--;
                            } else {
                              controller.selectedIndex.value =
                                  controller.playList.length - 1;
                            }

                            controller.update();
                          },
                          icon: Icon(CupertinoIcons.backward_end_fill,
                              color: Colors.white, size: 50),
                        ),
                        SizedBox(width: 15),

                        //play and pause-----------------------------------------------------
                        IconButton(
                          onPressed: () {
                            // myAudioHandler.playPlaylist();
                          },
                          icon: Icon(
                            // controller.audioPlayer.playing == false
                            //     ? CupertinoIcons.play_circle_fill
                            //     :
                            CupertinoIcons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                        SizedBox(width: 15),

                        //forward-------------------------------------------------
                        IconButton(
                          onPressed: () {
                            if (controller.selectedIndex.value <
                                controller.playList.length - 1) {
                              controller.selectedIndex.value++;
                            } else {
                              controller.selectedIndex.value = 0;
                            }

                            controller.update();
                          },
                          icon: Icon(CupertinoIcons.forward_end_fill,
                              color: Colors.white, size: 40),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.download_circle,
                          color: Colors.white, size: 40),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
