import 'package:Poster/core/models/post.dart';
import 'package:Poster/views/posts/screen_posts.dart';
import 'package:Poster/views/single_post.dart/screen_single_post.dart';
import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:Poster/constants/router_paths.dart';

class Router {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      defaultTransitions: [SailorTransition.fade_in],
      defaultTransitionCurve: Curves.linear,
      defaultTransitionDuration: Duration(milliseconds: 200),
    ),
  );

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(name: RouterPaths.posts, builder: (_, __, ___) => ScreenPosts()),
      SailorRoute(
        name: RouterPaths.singlePost,
        builder: (_, __, params) => ScreenSinglePost(params.param<Post>('post')),
        params: [SailorParam<Post>(name: 'post')],
      ),
    ]);
  }
}
