import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import '../const/data.dart';

class StatRepository{
  //static로 선언하면 ()안붙여도 됩니다
  static Future<List<StatModel>> fetchData() async{
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'itemCode':'PM10',
        'numOfRows':30,
        'pageNo':1,
        'dataGubun':'HOUR',
        'searchCodition':'WEEK'
      },
    );

    return response.data['response']['body']['items'].map<StatModel>(
          (item)=> StatModel.fromJson(json: item),
    ).toList();
  }
}