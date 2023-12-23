import 'package:connection/models/course.dart';
import 'package:connection/services/api_services.dart';

class CourseRepository {
  Future<List<Course>> getListCourse() async {
    List<Course> list = [];
    // list.add(Course(id: 1, tenhocphan: 'Lap trinh di dong', tengv: 'Giang IT'));
    var response = await ApiService().getCourseList();
    if (response != null) {
      var datas = response.data['data'];
      for (var data in datas) {
        var course = Course.fromJson(data);
        list.add(course);
        // print(course.tengv);
      }
    }
    return list;
  }
}
