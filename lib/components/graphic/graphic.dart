import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/components/buttons/currency_button.dart';
import 'package:quotation/components/buttons/select_button.dart';
import 'package:quotation/components/graphic/graphic_skeleton.dart';
import 'package:quotation/components/modals/custom_modal.dart';
import 'package:quotation/utils/colors.dart';

class GraphicComponent extends StatefulWidget {
  GraphicComponent({super.key, this.dataList, required this.title, required this.isValuating});
  final dataList;
  String title;
  Map<String, bool> isValuating;

  @override
  State<GraphicComponent> createState() => _GraphicComponentState();
}

class _GraphicComponentState extends State<GraphicComponent> {

  int selectedDays = 5;

  List<Map<String, dynamic>> dataMap = [
    {
      "code": "USD",
      "codein": "BRL",
      "name": "Dólar Americano/Real Brasileiro",
      "high": "6.088",
      "low": "5.9935",
      "varBid": "0.021",
      "pctChange": "0.35",
      "bid": "6.0704",
      "ask": "6.0714",
      "timestamp": "1737147538",
      "create_date": "2025-01-17 17:58:58"
    },
    {
      "high": "6.0545",
      "low": "6.0504",
      "varBid": "0.0005",
      "pctChange": "0.01",
      "bid": "6.0499",
      "ask": "6.0508",
      "timestamp": "1737064803"
    },
    {
      "high": "6.0131",
      "low": "6.0085",
      "varBid": "0.0033",
      "pctChange": "0.05",
      "bid": "6.0126",
      "ask": "6.0136",
      "timestamp": "1736978404"
    },
    {
      "high": "6.056",
      "low": "6.0515",
      "varBid": "0.0001",
      "pctChange": "0",
      "bid": "6.0559",
      "ask": "6.0561",
      "timestamp": "1736892004"
    },
    {
      "high": "6.2094",
      "low": "6.08",
      "varBid": "-0.0277",
      "pctChange": "-0.45",
      "bid": "6.095",
      "ask": "6.098",
      "timestamp": "1736801954"
    },
    {
      "high": "6.1242",
      "low": "6.1242",
      "varBid": "0",
      "pctChange": "0",
      "bid": "6.1059",
      "ask": "6.1424",
      "timestamp": "1736726324"
    },
    {
      "high": "6.1218",
      "low": "6.0322",
      "varBid": "0.0527",
      "pctChange": "0.87",
      "bid": "6.0884",
      "ask": "6.0914",
      "timestamp": "1736546369"
    },
    {
      "high": "6.1218",
      "low": "6.0322",
      "varBid": "0.0719",
      "pctChange": "1.19",
      "bid": "6.1014",
      "ask": "6.1167",
      "timestamp": "1736546313"
    },
    {
      "high": "6.0432",
      "low": "6.0322",
      "varBid": "-0.0006",
      "pctChange": "-0.01",
      "bid": "6.0351",
      "ask": "6.0381",
      "timestamp": "1736467144"
    },
    {
      "high": "6.1106",
      "low": "6.1039",
      "varBid": "0.0001",
      "pctChange": "0",
      "bid": "6.1041",
      "ask": "6.1071",
      "timestamp": "1736380780"
    },
    {
      "high": "6.1056",
      "low": "6.0993",
      "varBid": "0.0014",
      "pctChange": "0.02",
      "bid": "6.1009",
      "ask": "6.1039",
      "timestamp": "1736294361"
    },
    {
      "high": "6.1521",
      "low": "6.1156",
      "varBid": "0.0004",
      "pctChange": "0.01",
      "bid": "6.1152",
      "ask": "6.1159",
      "timestamp": "1736200804"
    },
    {
      "high": "6.2012",
      "low": "6.1357",
      "varBid": "0.0276",
      "pctChange": "0.49",
      "bid": "6.178",
      "ask": "6.181",
      "timestamp": "1735948798"
    },
    {
      "high": "6.2023",
      "low": "6.1367",
      "varBid": "0.0273",
      "pctChange": "0.44",
      "bid": "6.178",
      "ask": "6.181",
      "timestamp": "1735941517"
    },
    {
      "high": "6.1551",
      "low": "6.1509",
      "varBid": "0.0003",
      "pctChange": "0",
      "bid": "6.151",
      "ask": "6.154",
      "timestamp": "1735862348"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: 350.0,
        decoration: BoxDecoration(
          color: containerBackground,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 34.0, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: primaryTextColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34.0, right: 34.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 45.0,
                  child: SelectButton(
                    days: selectedDays,
                    onPressed: () {
                      CustomModal.show(
                        context: context,
                        content: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setStateModal) {
                            return SingleChildScrollView(
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                Column(
                                  children: [
                                    RadioListTile(
                                      title: Text(
                                        '5 dias',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      value: 5,
                                      groupValue: selectedDays,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDays = value!;
                                          print(selectedDays);
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        '10 dias',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      value: 10,
                                      groupValue: selectedDays,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDays = value!;
                                          print(selectedDays);
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        '15 dias',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      value: 15,
                                      groupValue: selectedDays,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDays = value!;
                                          print(selectedDays);
                                        });
                                      },
                                    ),
                                  ],
                                )
                              ]),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 34.0, right: 34.0, bottom: 12.0),
                child: GraphicSkeleton(
                  dataTest: widget.dataList,
                  daysForChart: selectedDays,
                  isCurrencyValuation: widget.isValuating,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
