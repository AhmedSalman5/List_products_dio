import 'package:dio/dio.dart';

import 'models/model.dart';

class ApiProvider {
  DataModel? dataModel;

  Future <DataModel?> getResponse() async {
    Response response = await Dio().get('https://dummyjson.com/products');
    // print(response.data);
    dataModel = DataModel.fromJson(response.data);
    // print(dataModel!.products![0].title);
    return dataModel;
  }
}
