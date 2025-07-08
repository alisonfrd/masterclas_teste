import 'dart:io';

import 'package:leitor_lcov/line_report.dart';

void main(List<String> args) {
  final result = coverage('./coverage/lcov.info');
}

String coverage(String lcovPath) {
  final file = File(lcovPath);
  final content = file.readAsLinesSync();
  final reports = contentToLineReport(content);
  final percent = calculatePercent(reports);
  return '$percent%';
}

int calculatePercent(List<LineReport> reports) {
  int totalLf = 0;
  int totalLh = 0;

  for (var report in reports) {
    totalLf += report.lineFound;
    totalLh += report.lineHit;
  }
  final percent = (totalLh / totalLf) * 100;
  return percent.round();
}

List<LineReport> contentToLineReport(List<String> content) {
  final reports = <LineReport>[];
  String sf = '';
  int lh = 0;
  int lf = 0;
  for (var item in content) {
    if (item.compareTo('end_of_record') == 0) {
      LineReport lineReport =
          LineReport(sourceFile: sf, lineFound: lf, lineHit: lh);
      reports.add(lineReport);
      continue;
    }
    var line = item.split(':');
    if (line[0].compareTo('SF') == 0) {
      sf = line[1];
    } else if (line[0].compareTo('LF') == 0) {
      lf = int.parse(line[1]);
    } else if (line[0].compareTo('LH') == 0) {
      lh = int.parse(line[1]);
    }
  }
  return reports;
}
