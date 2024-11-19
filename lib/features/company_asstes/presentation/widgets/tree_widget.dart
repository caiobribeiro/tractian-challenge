import 'package:flutter/material.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/util/tree_node.dart';

class TreeWidget extends StatefulWidget {
  final List<TreeNode> treeData;

  const TreeWidget({super.key, required this.treeData});

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.treeData.length,
      itemBuilder: (context, index) {
        return _buildNode(widget.treeData[index]);
      },
    );
  }

  Widget _buildNode(TreeNode node, {int depth = 0}) {
    Widget titleWidget = Container(
      color: node.isExpanded ? Colors.green[100] : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          _getIcon(node.icon) ?? Container(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(node.title),
          ),
          _getSensorIcon(node.sensorstatus) ?? Container(),
        ],
      ),
    );

    if (node.children.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: depth * 5),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: titleWidget,
            initiallyExpanded: node.isExpanded,
            onExpansionChanged: (isExpanded) {
              setState(() {
                node.isExpanded = isExpanded;
              });
            },
            tilePadding: const EdgeInsets.only(left: 5, right: 16),
            children: node.children
                .map((child) => _buildNode(child, depth: depth + 1))
                .toList(),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: depth * 5),
        child: ListTile(
          title: titleWidget,
        ),
      );
    }
  }

  Widget? _getIcon(NodeType? nodeType) {
    switch (nodeType) {
      case NodeType.location:
        return Image.asset('assets/location_icon.png', scale: 1.4);
      case NodeType.component:
        return Image.asset('assets/component_icon.png', scale: 1.4);
      case NodeType.asset:
        return Image.asset('assets/asset_icon.png', scale: 1.4);
      default:
        return null;
    }
  }

  Widget? _getSensorIcon(Sensorstatus? sensorStatus) {
    switch (sensorStatus) {
      case Sensorstatus.alert:
        return Image.asset('assets/sensor_alert.png', scale: 1.2);
      case Sensorstatus.operating:
        return Image.asset('assets/sensor_operating.png', scale: 1.2);
      default:
        return null;
    }
  }
}
