import 'package:Poster/constants/router_paths.dart';
import 'package:Poster/services/router.dart';
import 'package:Poster/views/posts/screen_posts_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Provider(
          create: (_) => ScreenPostsVModel(),
          child: Builder(builder: (context) {
            var vModel = Provider.of<ScreenPostsVModel>(context);
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  expandedHeight: 140.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("RECENT POSTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 0),
                                blurRadius: 8,
                              ),
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 0),
                                blurRadius: 4,
                              ),
                            ],
                          )),
                      background: FittedBox(
                          fit: BoxFit.cover, child: Image.asset('assets/background.png'))),
                ),
              ],
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: vModel.initCompleted,
                      initialData: false,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        if (vModel.cache.length == 0) return Center(child: Text('НЕТ ЗАПИСЕЙ'));
                        return ListView.builder(
                          itemCount: vModel.cache.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => Router.sailor.navigate(RouterPaths.singlePost,
                                params: {'post': vModel.cache[index]}),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(vModel.cache[index].id.toString()),
                                        ),
                                        Expanded(
                                          child: Text(
                                            vModel.cache[index].title,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        Icon(Icons.chevron_right),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
