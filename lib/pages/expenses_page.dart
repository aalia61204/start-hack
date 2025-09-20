import 'package:ai_finance_manager/data/api.dart';
import 'package:ai_finance_manager/pages/ai_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/themes.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {


  Map<String, double> dataMap = {
    "R": 5,
    "F": 3,
    "C": 2,
    "V": 2,
  };

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    Apis().fetchBankData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorColor: primaryClr,
                labelColor: primaryClr,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "Daily",
                  ),
                  Tab(
                    text: "Weekly",
                  ),
                  Tab(
                    text: "Monthly",
                  ),
                  Tab(
                    text: "Yearly",
                  ),
                ] 
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPieChart(),
                    _buildPieChart(),
                    _buildPieChart(),
                    _buildPieChart(),
                  ] 
                )
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white70,
          child: Icon(Icons.chat, color: primaryClr,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AiChatPage(),));
          }
        ),
      ),
    );
  }


  _buildPieChart()  {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 30.sp,
          chartRadius: MediaQuery.of(context).size.width / 2.8,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          centerText: "\$ 200",
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: lighttitlestyle
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 2,
                shadowColor: Colors.grey.shade100,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: primaryClr.withAlpha(150),
                    child: Icon(Icons.g_mobiledata, color: Colors.white, size: 22.sp,),
                  ),
                  title: Text("Groceries"),
                  subtitle: Text("REWE"),
                ),
              );
            }, 
          )
        )
      ],
    );
  }
}