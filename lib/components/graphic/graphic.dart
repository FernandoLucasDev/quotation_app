import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/components/buttons/currency_button.dart';
import 'package:quotation/components/buttons/select_button.dart';
import 'package:quotation/components/graphic/graphic_skeleton.dart';
import 'package:quotation/components/modals/custom_modal.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repository.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/utils/bid_formatters.dart';
import 'package:quotation/utils/colors.dart';
import 'package:quotation/utils/currencies.dart';

class GraphicComponent extends StatefulWidget {
  GraphicComponent({super.key, required this.isCustomData, required this.dataList, required this.title, required this.isValuating, required QuotationService service}) : _service = service;

  late final QuotationService _service;

  List<Object> dataList;
  String title;
  Map<String, bool> isValuating;
  bool isCustomData;

  @override
  State<GraphicComponent> createState() => _GraphicComponentState();
}

class _GraphicComponentState extends State<GraphicComponent> {

  int selectedDays = 5;
  bool isLoading = false;
  bool showGraphic = false;
  late bool isCurrencyValuating;
  String? bidValue;
  String selectedCurrencyFrom = "USD";
  String selectedCurrencyTo = "BRL";

  dynamic result;

  Future<void> fetchQuotation(ExchangeRepository repository) async {

    setState(() {
      isLoading = true;
    });

    result =  await widget._service.getQuotationInsidePeriod(selectedCurrencyFrom, selectedCurrencyTo);

    setState(() {
      isCurrencyValuating = result[0]["isCurrencyValuating"][selectedDays.toString()];
      widget.dataList = result;
      isLoading = false;
      showGraphic = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: widget.isCustomData ? 460.0 : 400,
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
            if(widget.isCustomData)
              Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 34.0, top: 10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From:",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: secondaryTextColor,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      CurrencyButton(
                        currency: selectedCurrencyFrom,
                        onPressed: () {
                          CustomModal.show(
                            context: context,
                            content: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setStateModal) {
                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: currenciesDataMap.entries.map((entry) {
                                      return RadioListTile<String>(
                                        activeColor: btnBackgroundColor,
                                        title: Text(
                                          entry.value,
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: primaryTextColor,
                                          ),
                                        ),
                                        value: entry.key,
                                        groupValue: selectedCurrencyFrom,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCurrencyFrom = value!;
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To:",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: secondaryTextColor,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      CurrencyButton(
                        currency: selectedCurrencyTo,
                        onPressed: () {
                          CustomModal.show(
                            context: context,
                            content: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setStateModal) {
                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: currenciesDataMap.entries.map((entry) {
                                      return RadioListTile<String>(
                                        activeColor: btnBackgroundColor,
                                        title: Text(
                                          entry.value,
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: primaryTextColor,
                                          ),
                                        ),
                                        value: entry.key,
                                        groupValue: selectedCurrencyTo,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCurrencyTo = value!;
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      height: 34.0,
                      decoration: BoxDecoration(
                        color: isLoading ? secondaryContainerColor : btnBackgroundColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.search, color: primaryTextColor),
                          onPressed: () => fetchQuotation(ExchangeRepository(api: ExchangeApi())),
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
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
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        '30 dias',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      value: 30,
                                      groupValue: selectedDays,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDays = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        '45 dias',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      value: 45,
                                      groupValue: selectedDays,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDays = value!;
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
            // if((widget.isCustomData ?? false)  && (!widget.isCustomData ?? ))
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 34.0, right: 34.0, bottom: 12.0),
                child: GraphicSkeleton(
                  dataForChart: widget.dataList,
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
