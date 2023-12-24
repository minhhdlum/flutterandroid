import 'package:connection/models/course.dart';
import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/repositories/course_repository.dart';
import 'package:connection/ui/custom_ctrl.dart';
import 'package:flutter/material.dart';

import 'AppConstant.dart';

class SubPageDSHP extends StatelessWidget {
  const SubPageDSHP({super.key});
  static int idpage = 4;

  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();
    final size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => MainViewModel().closeMenu(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.mainColor,
            title: const Text(
              'Danh Sách Học Phần',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: FutureBuilder(
            // Hiển thị dữ liệu được tải từ Future
            future: courseRepository.getListCourse(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomSpinner(size: size);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Course> courses = snapshot.data as List<Course>;
                return Container(
                  color: AppConstant.mainColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Số cột trong mỗi dòng
                        crossAxisSpacing: 16.0, // Khoảng cách giữa các cột
                        mainAxisSpacing: 16.0, // Khoảng cách giữa các dòng
                      ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              courses[index].tenhocphan,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Text(
                              'Giảng viên: ${courses[index].tengv}',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
                // List<Course> courses = snapshot.data as List<Course>;
                // // Hiển thị danh sách courses ở đây
                // return ListView.builder(
                //   itemCount: courses.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(courses[index].tenhocphan),
                //       subtitle: Text(courses[index].tengv),
                //       // Các thuộc tính khác của Course có thể được hiển thị ở đây
                //     );
                //   },
                // );
              }
            },
          ),
        ));
  }
}
