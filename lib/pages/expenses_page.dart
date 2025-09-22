import 'package:ai_finance_manager/data/api.dart';
import 'package:ai_finance_manager/model/bank_model.dart';
import 'package:ai_finance_manager/pages/chat_page.dart';
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

  Map<String, double> dataMap = {};

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  List<BankModel> bankdata = [];
  List<String?> cateories = [];
  var rawbankdata=[];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    getBankdata();
  }

  getBankdata() async {
    try {
      loading = true;
      setState(() {});
      List data = await Apis().fetchBankData();
      rawbankdata = data;
      bankdata = data.map((e) => BankModel.fromJson(e)).toList();
      _processBankData();
    } finally {
      loading = false;
      setState(() {});
    }
  }

  void _processBankData() {
    cateories = bankdata.map((e) => e.cATEGORY).where((c) => c != null).toSet().toList().cast<String>();
    final newMap = <String, double>{};
    double totalExpenses = 0;

    for (var item in bankdata) {
      if (item.cATEGORY != null) {
        // Assuming 'aMOUNT' is the property holding the transaction value in BankModel.
        // Please change 'item.aMOUNT' if your property is named differently.
        final amount = item.aMOUNT ?? 0.0;
        newMap.update(item.cATEGORY!, (value) => value + amount, ifAbsent: () => amount);
        totalExpenses += amount;
      }
    }
    dataMap = newMap;
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
                    text: "All",
                  ),
                  Tab(
                    text: "Daily",
                  ),
                  Tab(
                    text: "Weekly",
                  ),
                  Tab(
                    text: "Monthly",
                  ),
                ] 
              ),
              Expanded(
                child: loading ? Center(child: CircularProgressIndicator(),) : 
                TabBarView(
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
          child: Icon(Icons.smart_toy_outlined, color: primaryClr,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(transactionData: rawbankdata.toString(),),));
          }
        ),
      ),
    );
  }


_buildPieChart() {
  return Column(
    children: [
      SizedBox(
        height: 25,
      ),
      PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 20.sp,
        chartRadius: MediaQuery.of(context).size.width / 2.3,
        // Use a professional, muted color palette
        colorList: [
          Color(0xFF42A5F5), // Lighter Blue
          Color(0xFF66BB6A), // Lighter Green
          Color(0xFFFFA726), // Lighter Orange
          Color(0xFFEF5350), // Lighter Red
          Color(0xFFAB47BC), // Lighter Purple
          Color(0xFF26C6DA), // Lighter Cyan
        ],
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 25.sp,
        centerText: "\$ ${dataMap.values.fold<double>(0.0, (prev, e) => prev + e).toStringAsFixed(2)}",
        centerTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: false,
          showChartValues: false, // Removed for a cleaner look
          showChartValuesInPercentage: false, // Removed for a cleaner look
          showChartValuesOutside: false,
          decimalPlaces: 0,
        ),
      ),
      SizedBox(
        height: 25,
      ),
      Expanded(
        child: ListView.builder(
          itemCount: bankdata.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.sp,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [colorList[index % colorList.length].withOpacity(0.8), colorList[index % colorList.length]],
                        center: Alignment.topLeft,
                        radius: 1.5,
                      ),
                    ),
                    child: Icon(Icons.g_mobiledata, color: Colors.white, size: 22.sp),
                  ),
                ),
                title: Text(bankdata[index].tEXTCREDITOR.toString(), style: lighttitlestyle.copyWith(fontSize: 15.sp),),
                subtitle: Text(bankdata[index].cATEGORY.toString(), style: lighttitlestyle.copyWith(fontSize: 14.sp, color: Colors.grey),),
                trailing: Text("CHF ${bankdata[index].aMOUNT}", style: lighttitlestyle.copyWith(fontSize: 14.sp, color: Colors.red),),
              ),
            );
          },
        ),
      )
    ],
  );
}
}