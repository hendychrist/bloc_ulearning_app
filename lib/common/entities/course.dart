
class CourseRequestEntity {
  int? id;

  CourseRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class SearchRequestEntity {
  String? search;

  SearchRequestEntity({
    this.search,
  });

  Map<String, dynamic> toJson() => {
    "search": search,
  };
}

class CourseListResponseEntity {
  int? code;
  String? msg;
  List<CourseItem>? data;

  CourseListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory CourseListResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null 
            ? [] 
            : List<CourseItem>.from(json["data"].map((x) => CourseItem.fromJson(x))),
      );
}

class CourseDetailResponseEntity {
  int? code;
  String? msg;
  CourseItem? data;

  CourseDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory CourseDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] != null ? CourseItem.fromJson(json["data"]) : null,
      );
}

class AuthorRequestEntity {
  String? token;

  AuthorRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
//api post response msg
class AuthorResponseEntity {
  int? code;
  String? msg;
  AuthorItem? data;

  AuthorResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory AuthorResponseEntity.fromJson(Map<String, dynamic> json) =>
      AuthorResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: AuthorItem.fromJson(json["data"]),
      );
}


class AuthorItem {
  String? token;
  String? name;
  String? description;
  String? avatar;
  String? job;
  int? follow;
  int? score;
  int? download;
  int? online;

  AuthorItem({
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.job,
    this.follow,
    this.score,
    this.download,
    this.online,
  });

  factory AuthorItem.fromJson(Map<String, dynamic> json) =>
      AuthorItem(
        token: json["token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        job: json["job"],
        follow: json["follow"],
        score: json["score"],
        download: json["download"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
    "description": description,
    "avatar": avatar,
    "job": job,
    "follow": follow,
    "score": score,
    "download": download,
    "online": online,
  };

}

class CourseItem {
  String? user_token;
  String? name;
  String? description;
  String? thumbnail;
  String? video;
  String? price;
  String? amount_total;
  int? lesson_num;
  int? video_length; // Change to int to match JSON type
  int? id;
  int? down_num;

  CourseItem({
    this.user_token,
    this.name,
    this.description,
    this.thumbnail,
    this.video,
    this.price,
    this.amount_total,
    this.lesson_num,
    this.video_length,
    this.id,
    this.down_num,
  });

  factory CourseItem.fromJson(Map<String, dynamic> json) => CourseItem(
        user_token: json["user_token"],
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        price: json["price"].toString(), // Ensure price is a string
        amount_total: json["amount_total"],
        lesson_num: json["lesson_num"], // Ensure lesson_num is an int
        video_length: json["video_length"] is int ? json["video_length"] : int.tryParse(json["video_length"] ?? '0'), // Ensure video_length is an int
        id: json["id"],
        down_num: json['downloadable_res'],
      );

  Map<String, dynamic> toJson() => {
        "user_token": user_token,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "video": video,
        "price": price,
        "amount_total": amount_total,
        "lesson_num": lesson_num,
        "video_length": video_length,
        "id": id,
      };
}

