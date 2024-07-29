import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_states.dart';

class LessonBlocs extends Bloc<LessonEvents, LessonStates>{
  LessonBlocs():super(const LessonStates()){
    on<TriggerLessonVideo>(_triggerLessonVideoHandler);
    on<TriggerUrlItem>(_triggerUrlItemHandler);
    on<TriggerPlay>(_triggerPlayHandler);
    on<TriggerVideoIndex>(_triggerVideoIndexHandler);
  }

  void _triggerLessonVideoHandler(TriggerLessonVideo event, Emitter<LessonStates> emit){
    emit(state.copyWith(lessonVideoItem: event.lessonVideoItem));
  }

  void _triggerUrlItemHandler(TriggerUrlItem event, Emitter<LessonStates> emit){
    emit(state.copyWith(initializeVideoPlayerFuture: event.initVideoPlayerFuture));
  }

  void _triggerPlayHandler(TriggerPlay event, Emitter<LessonStates> emit){
    emit(state.copyWith(isPlay: event.isPLay));
  }

  void _triggerVideoIndexHandler(TriggerVideoIndex event, Emitter<LessonStates> emit){
    emit(state.copyWith(videoIndex: event.videoIndex));
  }

}