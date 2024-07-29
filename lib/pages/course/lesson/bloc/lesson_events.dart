// ignore_for_file: override_on_non_overriding_member

import 'package:ulearning_app/common/entities/lesson.dart';

abstract class LessonEvents{
  const LessonEvents();
}

class TriggerLessonVideo extends LessonEvents{
  const TriggerLessonVideo(this.lessonVideoItem);
  final List<LessonVideoItem> lessonVideoItem;

  @override
  List<Object?> get props => [lessonVideoItem];
}

class TriggerUrlItem extends LessonEvents{
  final Future<void>? initVideoPlayerFuture;
  const TriggerUrlItem(this.initVideoPlayerFuture);

  @override
  List<Object?> get props => [initVideoPlayerFuture];
}

class TriggerPlay extends LessonEvents{
  final bool isPLay;
  const TriggerPlay(this.isPLay);

  @override
  List<Object?> get props => [isPLay];
}

class TriggerVideoIndex extends LessonEvents{
  final int videoIndex;
  const TriggerVideoIndex(this.videoIndex);

  @override
  List<Object?> get props => [videoIndex];
}