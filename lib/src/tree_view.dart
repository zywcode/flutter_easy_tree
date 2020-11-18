import 'package:flutter/material.dart';

import 'tree_node.dart';

class TreeView extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  final String selectedNode;
  final double offsetLeft;
  final Function onIcon;
  final Function onNodeTap;

  const TreeView({
    @required this.data,
    @required this.selectedNode,
    this.offsetLeft = 24.0,
    this.onIcon,
    this.onNodeTap,
  }) : assert(data != null);

  List<TreeNode> _geneTreeNodes(List list) {
    List treeNodes = <TreeNode>[];

    for (int i = 0; i < list.length; i++) {
      final Map<String, dynamic> item = list[i];
      final id = item['id'] ?? '';
      final label = item['label'] ?? '';
      final expanded = item['expanded'] ?? false;
      final selected = this.selectedNode == id ?? false;
      final children = item['children'] as List;

      treeNodes.add(TreeNode(
        id: id,
        label: label,
        expanded: expanded,
        offsetLeft: offsetLeft,
        onIcon: onIcon,
        onNodeTap: onNodeTap,
        selected: selected,
        children: _geneTreeNodes(children),
      ));
    }

    return treeNodes;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(data.length, (int index) {
        final Map<String, dynamic> item = data[index];
        final id = item['id'] ?? '';
        final label = item['label'] ?? '';
        final expanded = item['expanded'] ?? false;
        final selected = this.selectedNode == id ?? false;
        final children = item['children'] as List;

        return TreeNode(
          id: id,
          label: label,
          expanded: expanded,
          selected: selected,
          offsetLeft: offsetLeft,
          onIcon: onIcon,
          onNodeTap: onNodeTap,
          children: _geneTreeNodes(children),
        );
      }),
    );
  }
}
