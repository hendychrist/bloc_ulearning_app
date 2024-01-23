
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class UserAPI{

  static login({LoginRequestEntity? params}) async {
    var response = await HttpUtil().post(
                                    'api/login', 
                                    queryParameters: params?.toJson());

    print("DEBUG: user_api.dart -> login() -> ${response.toString()}");
  }

}