import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_test/helpers/appbar_widget.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppBar---------------------------------------------------------
                    CustomAppbar(
                      title: 'New Playing',
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset('assets/images/h.jpeg'),
                      ),
                    ),

                    //Name singer-----------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Sawzale (Arrangement by Dilzar Abedi)',
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
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
                          Icon(Iconsax.heart, color: Colors.white, size: 24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Hasan Zirak',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    //Music----------------------------------------------------------
                    MusicWidget(),
                    SizedBox(height: 15),
                    //PlayList-------------------------------------------------------
                    PlayListWidget(
                      playList: controller.playList,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
