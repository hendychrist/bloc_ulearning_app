// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/lesson_api.dart';
import 'package:ulearning_app/common/entities/lesson.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/pages/common_widget.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:video_player/video_player.dart';

class LessonController{
  final BuildContext context;
  VideoPlayerController? videoPlayerController;

  LessonController({required this.context});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    // set the earlier video to false means, stop playing
    context.read<LessonBlocs>().add(const TriggerPlay(false));
    await asyncLoadLessonData(args['id']);
  }

  Future<void> asyncLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity = LessonRequestEntity(); 
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonDetail(params: lessonRequestEntity);

    if(result.code == 200){
      if(context.mounted){
        if(result.data != null && result.data!.isNotEmpty){
          context.read<LessonBlocs>().add(TriggerLessonVideo(result.data!));

          String? urlString = result.data!.elementAt(0).url; 

          if (urlString != null) {
            String cutUrl = processThumbnailUrl(urlString);
            Uri url = Uri.parse(cutUrl);

            print('Hendie - video url is : $url');

            // this url is important for init video player
            videoPlayerController = VideoPlayerController.networkUrl(url); 

            // here actually stream starts to happend
            var initPlayer = videoPlayerController?.initialize();
            context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));

          } else {
              toastInfo(msg: 'LessonAPI.lessonDetail result.data urlString is null');
            // handle the case where urlString is null
          }

        }else{
          toastInfo(msg: 'LessonAPI.lessonDetail result.data is null');
        }
      }

      
    }

  }

  void playVideo(String url){
    if(videoPlayerController != null){
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }else{
      Uri uri = Uri.parse(url);
      videoPlayerController = VideoPlayerController.networkUrl(uri);

      context.read<LessonBlocs>().add(TriggerPlay(false));
      context.read<LessonBlocs>().add(TriggerUrlItem(null));

      var initPlayer = videoPlayerController?.initialize().then((value){
        videoPlayerController?.seekTo(Duration(milliseconds: 0));
      });

      context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
      context.read<LessonBlocs>().add(TriggerPlay(true));
      videoPlayerController?.play();
    }
  }

}