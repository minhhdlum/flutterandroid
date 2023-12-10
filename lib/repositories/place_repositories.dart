import 'package:connection/models/place.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:connection/services/api_services.dart';

ProfileViewModel viewmodel = ProfileViewModel();

class PlaceRepository {
  Future<List<City>> getListCity() async {
    List<City> list = [];
    list.add(City(id: 0, name: '---Chọn---'));
    var datas = await ApiService().getListCity();
    if (datas == null && viewmodel.ds == 0) {
      viewmodel.displaySpinner();
      print('Đang lấy dữ liệu tỉnh!');
      getListCity();
    } else {
      for (var item in datas!) {
        var city = City.fromJson(item);
        list.add(city);
      }
      print('Đã lấy dữ liệu tỉnh');
      viewmodel.ds = 1;
    }
    viewmodel.hideSpinner();
    return list;
  }

  Future<List<District>> getListDistrict(int id) async {
    List<District> list = [];
    list.add(District(id: 0, name: '---Chọn---', level: 0));
    var datas = await ApiService().getListDistric(id);
    if (datas == null && viewmodel.dshuyen == 0) {
      viewmodel.displaySpinner();
      print('Đang lấy dữ liệu huyện!');
      getListDistrict(id);
    } else {
      for (var item in datas!) {
        var district = District.fromJson(item);
        list.add(district);
      }
      print('Đã lấy dữ liệu huyện');
      viewmodel.dshuyen = 1;
    }
    viewmodel.hideSpinner();
    return list;
  }

  Future<List<Ward>> getListWard(int id) async {
    List<Ward> list = [];
    list.add(Ward(id: 0, name: '---Chọn---'));
    var datas = await ApiService().getListWard(id);
    if (datas == null && viewmodel.dsxa == 0) {
      viewmodel.displaySpinner();
      print('Đang lấy dữ liệu xã!');

      getListCity();
    } else {
      for (var item in datas!) {
        var ward = Ward.fromJson(item);
        list.add(ward);
      }
      print('Đã lấy dữ liệu xã');
      viewmodel.dsxa = 1;
    }
    viewmodel.hideSpinner();
    return list;
  }
}
