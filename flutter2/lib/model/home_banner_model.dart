 class HomeBannerItem{
   String target;
   int id;
   String title;
   String shortTitle;
   String image;
   String url;//指定链接
   int rid;
   String text;
   int hide;
   int subject;
   int type;
   int paperId;
   int areaId;
   int width;
   int height;
   String content;
  // 自己添加字段，添加点击来源，用于神策向前来源
   String from;

   HomeBannerItem.fromJson(Map<String, dynamic> json){
      target = json['target'];
      if (json.containsKey('params')) {
         Map<String, dynamic> params = json['params'];
         id = params['id'];
         title = params['title'];
         shortTitle = params['shortTitle'];
         image = params['image'];
         url = params['url'];
         rid = params['rid'];
         text = params['text'];
         hide = params['hide'];
         subject = params['subjecet'];
         type = params['type'];
         paperId = params['paperId'];
         areaId = params['areaId'];
         width = params['width'];
         height = params['height'];
         content = params['content'];
      }
   }
}