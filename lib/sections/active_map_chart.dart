import 'package:digi_calendar/widgets/bar_chart_with_title.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/active_time_bar_chart.dart';

class ActiveMapsCharts extends StatelessWidget {
  const ActiveMapsCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(
          child: ActiveTimeChartWithTitle(
              // title: "Expence",
              // amount: 5340,
              // barColor: Styles.defaultBlueColor,
              ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: BarChartWithTitle(),
        ),
      ],
    );
  }
}
