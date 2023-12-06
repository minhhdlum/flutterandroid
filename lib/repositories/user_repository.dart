import 'package:connection/models/user.dart';
import 'package:connection/services/api_services.dart';

class UserRepository{
  Future<User> getUserInfo()async
  {
    User user=User();
    final response =await ApiService().getUserInfo();
    if(response != null){
      var json=response.data['data'];
      user=User.fromJson(json);
    }
    return user;
  }
}