import 'package:flutter/material.dart';

class MissionTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final List<VoidCallback>? onRowTap;

  const MissionTable({
    super.key,
    required this.headers,
    required this.rows,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(theme.colorScheme.surfaceVariant.withOpacity(0.3)),
        dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.hovered)) return theme.colorScheme.surfaceVariant.withOpacity(0.1);
           return null;
        }),
        columns: headers.map((h) => DataColumn(
          label: Text(h, style: const TextStyle(fontWeight: FontWeight.bold)),
        )).toList(),
        rows: List.generate(rows.length, (index) {
          return DataRow(
            onSelectChanged: onRowTap != null ? (_) => onRowTap![index]() : null,
            cells: rows[index].map((cell) => DataCell(cell)).toList(),
          );
        }),
      ),
    );
  }
}
