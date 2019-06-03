class BaseModel<T>{
  final int code;
  final String message;
  final T data;
  const BaseModel({this.code, this.message, this.data});

  BaseModel.fromjson(Map<String, dynamic> json)
    : code = json['code'],
      message = json['message'],
      data = json['data'];
}