import 'package:flutter/material.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/util/tree_node.dart';

class TreeWidget extends StatefulWidget {
  final List<TreeNode> treeData;

  const TreeWidget({super.key, required this.treeData});

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  late List<TreeNode> filteredTreeData;
  late List<TreeNode> completeTreeData;
  bool showAlertOnly = false;
  bool showOperatingOnly = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTreeData = widget.treeData;
    completeTreeData = widget.treeData;
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredTreeData = completeTreeData;
      } else {
        filteredTreeData =
            _filterTreeBySearch(completeTreeData, searchController.text);
      }
    });
  }

  List<TreeNode> _filterTreeBySearch(List<TreeNode> nodes, String searchQuery) {
    List<TreeNode> filteredNodes = [];

    for (var node in nodes) {
      List<TreeNode> filteredChildren =
          _filterTreeBySearch(node.children, searchQuery);

      if (node.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          filteredChildren.isNotEmpty) {
        filteredNodes.add(TreeNode(
          title: node.title,
          icon: node.icon,
          sensorstatus: node.sensorstatus,
          children: filteredChildren,
        ));
      }
    }

    return filteredNodes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Buscar Ativo ou Local',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    filteredTreeData = completeTreeData;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: showOperatingOnly
                      ? const Color(0xFF2188FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: showAlertOnly ? Colors.transparent : Colors.grey),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      color: showOperatingOnly ? Colors.white : Colors.black,
                    ),
                    Switch(
                      value: showOperatingOnly,
                      onChanged: (value) {
                        setState(() {
                          showOperatingOnly = value;
                          if (showOperatingOnly) {
                            filteredTreeData = _filterTree(
                                widget.treeData, Sensorstatus.operating);
                            showAlertOnly = false;
                          } else {
                            filteredTreeData = widget.treeData;
                          }
                        });
                      },
                    ),
                    Text(
                      'Sensor de Energia',
                      style: TextStyle(
                        color: showOperatingOnly ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  color: showAlertOnly
                      ? const Color(0xFF2188FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: showAlertOnly ? Colors.transparent : Colors.grey),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: showAlertOnly ? Colors.white : Colors.black,
                    ),
                    Switch(
                      value: showAlertOnly,
                      onChanged: (value) {
                        setState(() {
                          showAlertOnly = value;
                          if (showAlertOnly) {
                            filteredTreeData = _filterTree(
                                widget.treeData, Sensorstatus.alert);
                            showOperatingOnly = false;
                          } else {
                            filteredTreeData = widget.treeData;
                          }
                        });
                      },
                    ),
                    Text(
                      'Crítico',
                      style: TextStyle(
                        color: showAlertOnly ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredTreeData.length,
            itemBuilder: (context, index) {
              return _buildNode(filteredTreeData[index]);
            },
          ),
        ),
      ],
    );
  }

  List<TreeNode> _filterTree(List<TreeNode> nodes, Sensorstatus status) {
    List<TreeNode> filteredNodes = [];

    for (var node in nodes) {
      List<TreeNode> filteredChildren = _filterTree(node.children, status);

      if (node.sensorstatus == status || filteredChildren.isNotEmpty) {
        filteredNodes.add(TreeNode(
          title: node.title,
          icon: node.icon,
          sensorstatus: node.sensorstatus,
          children: filteredChildren,
        ));
      }
    }

    return filteredNodes;
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
