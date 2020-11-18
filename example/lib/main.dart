import 'package:flutter/material.dart';
import 'package:flutter_easy_tree/flutter_easy_tree.dart';

import 'tree_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Tree')),
        body: TreeView(
          offsetLeft: 30,
          data: treeData,
          onIcon: (String id) {
            print('id: ${id}');
            return SizedBox.shrink();
//            return IconButton(
//              icon: Icon(Icons.star_border),
//              iconSize: 24,
//            );
          },
          onNodeTap: () {
            print('node');
          }
        ),

        // body: TreeNode(
        //   title: Text('This is a title!'),
        //   children: [
        //     TreeNode(
        //       title: Text('This is a title!'),
        //       children: <Widget>[
        //         TreeNode(title: Text('This is a title!')),
        //         TreeNode(
        //           title: Text('This is a title!'),
        //           children: <Widget>[
        //             TreeNode(title: Text('This is a title!')),
        //             TreeNode(title: Text('This is a title!')),
        //             TreeNode(title: Text('This is a title!')),
        //           ],
        //         ),
        //         TreeNode(title: Text('This is a title!')),
        //         TreeNode(title: Text('This is a title!')),
        //         TreeNode(
        //           title: Text('This is a title!'),
        //           children: <Widget>[
        //             TreeNode(title: Text('This is a title!')),
        //             TreeNode(title: Text('This is a title!')),
        //             TreeNode(title: Text('This is a title!')),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
