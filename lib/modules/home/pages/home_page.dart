import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_test/helpers/appbar_widget.dart';
import 'package:my_test/helpers/endpoint.dart';
import 'package:my_test/helpers/music_widget.dart';
import 'package:my_test/helpers/play_list_widget.dart';
import 'package:my_test/modules/home/controllers/play_list_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayListController>(
      init: PlayListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xff2F3645),
          body: SafeArea(
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // AppBar---------------------------------------------------------
                        CustomAppbar(
                          title: 'New Playing',
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: Endpoint.base +
                                      controller
                                          .playList[
                                              controller.selectedIndex.value]
                                          .pictureUrl
                                          .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //Name singer-----------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      controller
                                          .playList[
                                              controller.selectedIndex.value]
                                          .trackName
                                          .toString(),
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  Spacer(),
                                  //Icons------------------------------------------------------

                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.lyrics,
                                        color: Colors.white, size: 24),
                                  ),
                                  // Icon(Icons.lyrics, color: Colors.white, size: 24),
                                  SizedBox(width: 10),
                                  Icon(Iconsax.add_square,
                                      color: Colors.white, size: 24),
                                  SizedBox(width: 10),
                                  Icon(Iconsax.heart,
                                      color: Colors.white, size: 24),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                controller
                                    .playList[controller.selectedIndex.value]
                                    .artistName
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Music----------------------------------------------------------
                        MusicWidget(),
                        SizedBox(height: 15),
                        //PlayList-------------------------------------------------------
                        PlayListWidget(),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
