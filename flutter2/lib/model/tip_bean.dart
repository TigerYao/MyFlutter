class TipNewBean {
  int category; // 考试类型
  int subject; // 科目
  var match; // 当前模考大赛id
  var small; // 当前小模考id

  var matchReadFlag; // 模考大赛是否已读标记   0、未读 1、已读
  var smallReadFlag;

  TipNewBean.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        subject = json['subject'],
        match = json['match'],
        small = json['smal'],
        matchReadFlag = json['matchReadFlag'],
        smallReadFlag = json['smallReadFlag'];
}
