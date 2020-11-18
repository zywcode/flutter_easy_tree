import 'package:flutter/material.dart';

class TreeNode extends StatefulWidget {
  final String id;
  final int level;
  final bool expanded;
  final bool icon;
  final bool selected;
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
    this.selected = false,
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
  Widget _icon;

  initState() {
    _isExpanded = widget.expanded;
    _icon =
        widget.onIcon != null && widget.onIcon is Function && widget.id != null && widget.id.indexOf('v_') == 0
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: children != null && children.length > 0,
                child: Center(
                  child: GestureDetector(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(_isExpanded
                              ? Icons.arrow_drop_down
                              : Icons.arrow_right, color: Colors.white,),
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
                        widget.onNodeTap is Function && widget.children.length == 0 && widget.id.indexOf('v_') == 0) {
                      widget.onNodeTap(widget.id ?? '');
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 6, right: 2), child: _icon,),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                          child: Text(widget.label,
                              style: TextStyle(
                                  color: widget.selected ? Colors.blue : Colors.grey,
                                  height: 1.5,
                                  fontSize: 16)),
                        ),
                      ),
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
