import 'package:fluro/fluro.dart';
import 'package:pokelist/page/detail.dart';
import './main.dart';

class Routes {
  static Router router;
  static String homepage = '/';
  static String detailpage = '/detail';

  static void configureRoutes(Router router) {
    router.define(homepage, handler: Handler(handlerFunc: (context, params) => MyApp()));
    router.define(detailpage, handler: Handler(handlerFunc: (context, params) {
      var id = params['id']?.first;//取出传参
      return DetailPage(id);
    }));
    Routes.router = router;
  }
}