import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quotation/components/buttons/currency_button.dart';
import 'package:quotation/components/common/app_loader.dart';
import 'package:quotation/components/forms/text_input.dart';
import 'package:quotation/components/modals/custom_modal.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/utils/bid_formatters.dart';
import 'package:quotation/utils/colors.dart';
import 'package:quotation/utils/currencies.dart';

class CustomQuotation extends StatefulWidget {
  CustomQuotation({super.key, required this.selectedCurrencyFrom, required this.selectedCurrencyTo, required QuotationService service}) : _service = service;

  late QuotationService _service;
  final String selectedCurrencyFrom;
  final String selectedCurrencyTo;

  @override
  State<CustomQuotation> createState() => _CustomQuotationState();
}

class _CustomQuotationState extends State<CustomQuotation> {

  final _amountController = TextEditingController();

  late String selectedCurrencyFrom;
  late String selectedCurrencyTo;

  dynamic result;

  bool isLoading = false;
  late bool isCurrencyValuating;
  String? bidValue;

  @override
  void initState() {
    super.initState();
    selectedCurrencyFrom = widget.selectedCurrencyFrom;
    selectedCurrencyTo = widget.selectedCurrencyTo;
  }

  Future<void> fetchQuotation(ExchangeRepository repository) async {

    setState(() {
      isLoading = true;
    });

    result =  await widget._service.getQuotation(selectedCurrencyFrom, selectedCurrencyTo);

    setState(() {
      print(result);
      bidValue = "${result["codein"]} ${formatToTwoDecimalPlaces(result["bid"])}";
      isCurrencyValuating = result["isCurrencyValuating"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 10.0),
        child: Container(
          width: double.infinity,
          height: 290.0,
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
                    "Search",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: primaryTextColor,
                    ),
                  ),
                ),
              ),
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
                padding: const EdgeInsets.only(left: 34.0, right: 34.0, top: 2.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Amount (optional):",
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                    ),
                    TextInputCustom(
                        inputKey: _amountController,
                        errorMsg: "error getting amount",
                        textHint: "amount",
                        borderRadius: 8,
                        sensitive: false,
                        isNumber: true,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 34.0, top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bid value:",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ),
              Center(
                child: isLoading
                    ? const AppLoader()
                    : bidValue != null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bidValue!,
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color:  isCurrencyValuating ? upTextColor : downTextColor,
                      ),
                    ),
                    Icon(
                      isCurrencyValuating
                          ? Icons.keyboard_double_arrow_up
                          : Icons.keyboard_double_arrow_down,
                      color: isCurrencyValuating ? upTextColor : downTextColor,
                      size: 40.0,
                    ),
                  ],
                )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
