import 'package:flutter2/model/base_model.dart';
import 'package:flutter2/net/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:flutter2/model/user_info.dart';
import 'package:flutter2/model/signup_type_bean.dart';
import 'package:flutter2/utils/sputils.dart';
import 'package:flutter2/model/HomeTreeBean.dart';
import 'package:flutter2/model/home_banner_model.dart';
import 'package:flutter2/model/tip_bean.dart';
import 'package:flutter2/common/constant.dart';
import 'package:flutter2/model/course_list_model.dart';
import 'package:flutter2/model/category_model.dart';
import 'package:flutter2/model/course_collect_model.dart';

class ServiceApi {
  DioFactory dioFactory;
  static ServiceApi instance;
  static ServiceApi getInstance() {
    if (instance == null) instance = ServiceApi();
    return instance;
  }

  Future<BaseModel> getSignBean() async {
    dioFactory = DioFactory.getInstance();
    Dio dio = dioFactory.getDio();
    dioFactory.setOptions();
    String url = "/k/v2/subjects/tree/static";
    Response response = await dio.get(url);
    print(response.data);
    BaseModel<List<dynamic>> baseModel = BaseModel.fromjson(response.data);
    print(baseModel.data);
    List<SignUpTypeBean> signUpTypeBean =
        baseModel.data.map((i) => SignUpTypeBean.fromJson(i)).toList();
    print(signUpTypeBean.toString());
    return baseModel;
  }

  Future<UserInfo> login(String accout, String pws) async {
    SPUtil spUtil = await SPUtil.getInstance();
    Dio dio = DioFactory.getInstance().getDio();
    String path = "u/v3/users/login?account=" +
        accout +
        "&password=" +
        pws +
        "&catgory=" +
        spUtil.getUserCatgory().toString() +
        "&deviceToken=AgGMqSr63coUwT1rPyDIkEJmqikAneWfCz9N7rEkYaIg";
    print("login...then..." + path);
    Response response = await dio.post(path);
    print("login...then..." + response.data.toString());
    BaseModel<Map<String, dynamic>> baseModel =
        BaseModel.fromjson(response.data);
    int code = baseModel.code;
    UserInfo userInfo = null;
    if (code == Constant.ERROR_SUCCESS) {
      userInfo = UserInfo.fromJson(baseModel.data);
      DioFactory.getInstance().putOptions(
          userInfo.token, userInfo.id, userInfo.subject, userInfo.catgory);
    }
    return userInfo;
  }

  List<HomeTreeBean> items;
  Future<List<HomeTreeBean>> getHomeDatas() async {
    if (items != null) return items;
    Dio dio = DioFactory.getInstance().getDio();
    DioFactory.getInstance().setOptions();
    String path = 'k/v1/points';
    Response response = await dio.get(path);
    BaseModel<List<dynamic>> baseModel = BaseModel.fromjson(response.data);
    if (baseModel.code == Constant.ERROR_SUCCESS) {
      items = baseModel.data.map((t) => HomeTreeBean.fromJson(t)).toList();
      print('HomeDatas...' + items.toString());
      return items;
    }
    return items;
  }

  List<HomeBannerItem> bannerItmes;
  Future<List<HomeBannerItem>> getBannerDatas() async {
    if (bannerItmes != null) return bannerItmes;
    Dio dio = DioFactory.getInstance().getDio();
    DioFactory.getInstance().setOptions();
    String path = 'u/v3/users/bc/list';
    Response response = await dio.get(path);
    print('HomeBanner...' + response.data.toString());
    BaseModel<List<dynamic>> baseModel = BaseModel.fromjson(response.data);
    if (baseModel.code == Constant.ERROR_SUCCESS) {
      bannerItmes =
          baseModel.data.map((t) => HomeBannerItem.fromJson(t)).toList();
    }
    return bannerItmes;
  }

  List<TipNewBean> tipBeans;
  Future<List<TipNewBean>> getMatchIdForNewTip() async {
    if (tipBeans != null) return tipBeans;
    Dio dio = DioFactory.getInstance().getDio();
    String path = 'p/v3/papers/idList';
    Response response = await dio.get(path);
    print("getMatchIdForNewTip ==" + response.data.toString());
    BaseModel<List<dynamic>> baseModel = BaseModel.fromjson(response.data);
    if (baseModel.code == Constant.ERROR_SUCCESS) {
      tipBeans =
          baseModel.data.map((json) => TipNewBean.fromJson(json)).toList();
    }
    return tipBeans;
  }

  Future<List<CourseList>> getCourseList(String cateId) async {
    String path = 'c/v6/courses/list?cateId=' + cateId;
    print('CourseList....' + path);
    Dio dio = DioFactory.getInstance().getDio();
    Response response = await dio.get(path);
    BaseModel<List<dynamic>> baseModel = BaseModel.fromjson(response.data);
    print('..CourseList..' + baseModel.data.toString());
    List<CourseList> courseList = null;
    if (baseModel.code == Constant.ERROR_SUCCESS) {
      courseList =
          baseModel.data.map((json) => CourseList.fromJson(json)).toList();
    }
    return courseList;
  }

  List<CourseCategoryBean> categorys;
  Future<List<CourseCategoryBean>> getCategoryList() async {
    String path = 'c/v6/my/cateList';
    Dio dio = DioFactory.getInstance().getDio();
    Response response = await dio.get(path);
    BaseModel<List<dynamic>> baseModel = BaseModel.fromjson(response.data);
    print('..getCategoryList..' + baseModel.data.toString());
    if (baseModel.code == Constant.ERROR_SUCCESS) {
      categorys = baseModel.data
          .map((category) => CourseCategoryBean.fromJson(category))
          .toList();
    }
    return categorys;
  }

  Future<CourseCollectList>  getCollectCourseBean(String cateId, int page, int pageSize) async{
    String path = 'c/v6/courses/collectDetail?collectId=${cateId}&page=${page}&pageSize=${pageSize}';
    Dio dio = DioFactory.getInstance().getDio();
    Response response = await dio.get(path);
    BaseModel<Map<String, dynamic>> baseModel = BaseModel.fromjson(response.data);
    print('..getCollectCourseBean..' + baseModel.data.toString());
    CourseCollectList courseList = null;
    if (baseModel.code == Constant.ERROR_SUCCESS) {

      courseList = CourseCollectList.fromJson(baseModel.data);
//          baseModel.data.map((json) => CourseItem.fromJson(json)).toList();
    }
    return courseList;
  }
}
