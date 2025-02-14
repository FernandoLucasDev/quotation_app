import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation/components/common/app_loader.dart';
import 'package:quotation/components/common/header.dart';
import 'package:quotation/components/cards/currency_card.dart';
import 'package:quotation/components/cards/custom_quotation.dart';
import 'package:quotation/components/common/titled_separator.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/utils/bid_formatters.dart';
import 'package:quotation/utils/colors.dart';
import 'package:quotation/view_model/quotation_view_model.dart';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<QuotationViewModel>().fetchQuotations());
  }

  Future<void> _refresh() async {
    await context.read<QuotationViewModel>().fetchQuotations();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuotationViewModel>();
    final exchangeRepository = ExchangeRepository(api: ExchangeApi());
    final quotationService = QuotationService(exchangeRepository: exchangeRepository);

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Header(),
            const TitledSeparator(title: "Quotations"),
            if (viewModel.isLoading)
              const AppLoader()
            else if (viewModel.quotationUSD != null &&
                viewModel.quotationEUR != null &&
                viewModel.quotationBTC != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomQuotation(
                    selectedCurrencyFrom: "USD",
                    selectedCurrencyTo: "BRL",
                    service: quotationService,
                  ),
                  CurrencyCard(
                    currency: "US Dollar [USD]",
                    bid: formatToTwoDecimalPlaces(viewModel.quotationUSD['bid']),
                    max: formatToTwoDecimalPlaces(viewModel.quotationUSD['high']),
                    min: formatToTwoDecimalPlaces(viewModel.quotationUSD['low']),
                    isValuating: viewModel.quotationUSD['isCurrencyValuating'],
                  ),
                  CurrencyCard(
                    currency: "Euro [EUR]",
                    bid: formatToTwoDecimalPlaces(viewModel.quotationEUR['bid']),
                    max: formatToTwoDecimalPlaces(viewModel.quotationEUR['high']),
                    min: formatToTwoDecimalPlaces(viewModel.quotationEUR['low']),
                    isValuating: viewModel.quotationEUR['isCurrencyValuating'],
                  ),
                  CurrencyCard(
                    currency: "Bitcoin [BTC]",
                    bid: formatBitcoinValue(viewModel.quotationBTC['bid']),
                    max: formatBitcoinValue(viewModel.quotationBTC['high']),
                    min: formatBitcoinValue(viewModel.quotationBTC['low']),
                    isValuating: viewModel.quotationBTC['isCurrencyValuating'],
                  ),
                ],
              )
            else
              const Text(
                'No data at the moment',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
