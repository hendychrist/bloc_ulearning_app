
// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/lesson.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:ulearning_app/pages/course/lesson/lesson_controller.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_states.dart';
import 'package:video_player/video_player.dart';
import 'package:ulearning_app/pages/common_widget.dart';

Widget videoPlayer(LessonStates state, LessonController lessonController){
  return  Container(
            width: 325.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.h),
              image: const DecorationImage(
                image: AssetImage(
                          "assets/icons/video.png" 
                        )
              )
            ),
            child: FutureBuilder(
              future: state.initializeVideoPlayerFuture,
              builder: (context, snapshot){

                print('Hendie ---- video snapshot is ${snapshot.connectionState} ----');

                // check if the connection is made to the certain video on the server
                if(snapshot.connectionState == ConnectionState.done){
                  return lessonController.videoPlayerController == null 
                          ?
                            const Text('lessonController.videPlayerController is null')
                          :
                            AspectRatio(
                              aspectRatio: lessonController.videoPlayerController!.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  VideoPlayer(lessonController.videoPlayerController!,),
                                  VideoProgressIndicator(
                                    lessonController.videoPlayerController!, 
                                    allowScrubbing: true,
                                    colors: VideoProgressColors(playedColor: AppColors.primaryElement),
                                  ) 

                                ],
                              ),

                            );
                }else{

                /*    https://firebasestorage.googleapis.com/v0/b/ulearning-app-f6f8e.appspot.com/o/fd.mp4?alt=media&token=955d4d2c-fcf0-49ce-a1f1-a9abde6a74e0 */
                
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

              }
            ),
          );

}

Widget videoControls(LessonStates state, LessonController lessonController, BuildContext context){
 return Container(  //video buttons
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // left button
              GestureDetector(
                onTap: (){
                  var videoIndex = context.read<LessonBlocs>().state.videoIndex;

                  videoIndex = videoIndex - 1;

                  if(videoIndex < 0){
                    videoIndex = 0;

                    context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
                    toastInfo(msg: "This is the first video you are watching");

                    return;
                  }else{
                    var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                    lessonController.playVideo(videoItem.url!);
                  }

                  context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
                },
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  margin: EdgeInsets.only(right: 15.w),
                  child: Image.asset("assets/icons/rewind-left.png"),
                ),
              ),

              // play and pause button
              GestureDetector(
                onTap: (){

                  // if it's already playing
                  if(state.isPlay){
                    lessonController.videoPlayerController?.pause();
                    context.read<LessonBlocs>().add(const TriggerPlay(false));
                  }else{
                  // if it's not playing, then play
                    lessonController.videoPlayerController?.play();
                    context.read<LessonBlocs>().add(const TriggerPlay(true));
                  }

                },
                child: state.isPlay
                        ?
                          Container(
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset("assets/icons/pause.png"),
                          )
                        :
                          Container(
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset("assets/icons/play-circle.png"),
                          )
              ),
              
              // Right button
              GestureDetector(
                onTap: (){
                  var videoIndex = context.read<LessonBlocs>().state.videoIndex;

                  videoIndex = videoIndex + 1;

                  if(videoIndex > state.lessonVideoItem.length){
                    videoIndex = videoIndex - 1;

                    context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
                    toastInfo(msg: "No videos in the play list");

                    return;
                  }else{
                    var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                    lessonController.playVideo(videoItem.url!);
                  }

                  context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
                },
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  margin: EdgeInsets.only(right: 15.w),
                  child: Image.asset("assets/icons/rewind-right.png"),
                ),
              ),
            ],
          ),
        );

}

// Video List 
SliverPadding videoList(LessonStates state, LessonController lessonController){
  return   SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 18.h,
                      horizontal: 25.w,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                                  (context, index){
                                    return _buildLessonItems(context, index, state.lessonVideoItem[index], lessonController);
                                  },
                                  childCount: state.lessonVideoItem.length
                                ),
                    ),
                  );
}

Widget _buildLessonItems(BuildContext context, int index, LessonVideoItem item, LessonController lessonController){
    return Container(
      width: 325.w,
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: InkWell(
        onTap: (){
          context.read<LessonBlocs>().add(TriggerVideoIndex(index));
          // videoIndex = index;

          if(item.url != null && item.url!.isNotEmpty){
            lessonController.playVideo(item.url!);  
          }else{
            toastInfo(msg: 'item url is empty or null: ${item.url}');
          }
          
        },
        child: Row(
          children: [

            Container(
              width: 60.h,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(processThumbnailUrl("${item.thumbnail}")), 
                )
              ),
            ),

            Expanded(
              child: Container(
                height: 60.h,
                color: Colors.green,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    reusableText(
                        "${item.name}",
                         color: Colors.black, 
                         fontWeight: FontWeight.bold, 
                         fontSize: 13.sp
                    ),

                    GestureDetector(
                      onTap: (){
                         context.read<LessonBlocs>().add(TriggerVideoIndex(index));
                        // videoIndex = index;

                        if(item.url != null && item.url!.isNotEmpty){
                          lessonController.playVideo(item.url!);  
                        }else{
                          toastInfo(msg: 'item url is empty or null: ${item.url}');
                        }

                      },
                      child: reusableText(
                        "Play", 
                        color: Colors.black, 
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp
                      ),
                    ),

                  ],
                ),
              ),
            ),
         
          ],
        ),
      ),
    );
  }
