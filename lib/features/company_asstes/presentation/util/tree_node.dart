enum NodeType { location, component, asset }

enum Sensorstatus { alert, operating, empty }

class TreeNode {
  final String title;
  final NodeType icon;
  final List<TreeNode> children;
  final Sensorstatus? sensorstatus;
  bool isExpanded;

  TreeNode({
    required this.title,
    required this.icon,
    this.sensorstatus = Sensorstatus.empty,
    this.children = const [],
    this.isExpanded = false,
  });
}
