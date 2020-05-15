import 'package:Poster/core/models/author.dart';
import 'package:Poster/core/models/post.dart';
import 'package:Poster/views/single_post.dart/screen_single_post_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSinglePost extends StatelessWidget {
  ScreenSinglePost(this.post);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Provider<ScreenSinglePostVModel>(
      create: (context) => ScreenSinglePostVModel(),
      child: Builder(builder: (context) {
        var vModel = Provider.of<ScreenSinglePostVModel>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Post #${post.id.toString()}'),
          ),
          backgroundColor: Colors.grey[400],
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                        child: Text(
                          post.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(post.body),
                      ),
                      Divider(),
                      FutureBuilder<Author>(
                        future: vModel.getAuthor(post.userId),
                        builder: (BuildContext context, AsyncSnapshot<Author> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Center(child: CircularProgressIndicator());
                          if (!snapshot.hasData) return SizedBox.shrink();
                          return Wrap(
                            children: <Widget>[
                              Text('Author: ${snapshot.data.name} (${snapshot.data.username})'),
                              Text('email: ${snapshot.data.email}'),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
