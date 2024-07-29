
class BaseResponseEntity {
  int? code;
  String? msg;
  dynamic data;

  BaseResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
      "code": code,
      "msg": msg,
      "data": data,
  };
}

class BindFcmTokenRequestEntity {
  String? fcmtoken;

  BindFcmTokenRequestEntity({
    this.fcmtoken,
  });

  Map<String, dynamic> toJson() => {
    "fcmtoken": fcmtoken,
  };
}