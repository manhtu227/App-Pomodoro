import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../providers/Tasks.dart';
import 'package:provider/provider.dart';

class optionTask extends StatelessWidget {
  const optionTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Tasks"),
          Card(
            color: Colors.white.withOpacity(0.1),
            child: PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Text('Clear finish task'),
                  value: 'Option 1',
                  onTap: () => {
                    Provider.of<Tasks>(context, listen: false).clearFinishTask()
                  },
                ),
                PopupMenuItem(
                  child: Text('Clear all task'),
                  value: 'Option 2',
                  onTap: () => {
                    Provider.of<Tasks>(context, listen: false).clearAllTask()
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
