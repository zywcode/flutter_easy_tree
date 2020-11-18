import 'package:flutter/material.dart';

class TreeNode extends StatefulWidget {
  final String id;
  final int level;
  final bool expanded;
  final bool icon;
  final String selectedNode;
  final double offsetLeft;
  final List<Widget> children;

  final String label;

  final Function onIcon;
  final Function onNodeTap;

  const TreeNode({
    this.id = '',
    this.level = 0,
    this.expanded = false,
    this.icon = false,
    this.selectedNode = '',
    this.offsetLeft = 24.0,
    this.children = const [],
    this.label = 'Title',
    this.onIcon,
    this.onNodeTap,
  });

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isSelected = false;
  Widget _icon;

  initState() {
    _isExpanded = widget.expanded;
    _isSelected = widget.selectedNode == widget.id;
    _icon =
        widget.onIcon != null && widget.onIcon is Function && widget.id != null
            ? widget.onIcon(widget.id)
            : SizedBox.shrink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final level = widget.level;
    final children = widget.children;
    final offsetLeft = widget.offsetLeft;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: children != null && children.length > 0,
                child: Center(
                  child: GestureDetector(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(_isExpanded
                              ? Icons.arrow_drop_down
                              : Icons.arrow_right),
                          iconSize: 24,
                          onPressed: null,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }),
                ),
              ),
//              SizedBox(width: 6.0),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                    if (widget.onNodeTap != null &&
                        widget.onNodeTap is Function) {
                      widget.onNodeTap();
                    }
                  },
                  child: Row(
                    children: [
                      _icon,
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(widget.label,
                            style: TextStyle(
                                color: _isSelected ? Colors.blue : Colors.grey,
                                fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: children.length > 0 && _isExpanded,
          child: Padding(
            padding: EdgeInsets.only(left: level + 1 * offsetLeft),
            child: Column(
              children: widget.children,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ],
    );
  }
}
