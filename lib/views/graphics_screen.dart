import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation/components/common/app_loader.dart';
import 'package:quotation/components/common/header.dart';
import 'package:quotation/components/common/titled_separator.dart';
import 'package:quotation/components/graphic/graphic.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/utils/colors.dart';
import 'package:quotation/view_model/graphics_view_model.dart';

class GraphicsScreen extends StatefulWidget {
  const GraphicsScreen({super.key});

  @override
  State<GraphicsScreen> createState() => _GraphicsScreenState();
}

class _GraphicsScreenState extends State<GraphicsScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<GraphicsViewModel>().fetchQuotations());
  }

  Future<void> _refresh() async {
    await context.read<GraphicsViewModel>().fetchQuotations();
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<GraphicsViewModel>();
    final exchangeRepository = ExchangeRepository(api: ExchangeApi());
    final quotationService = QuotationService(exchangeRepository: exchangeRepository);

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
            children: [
              Header(),
              const TitledSeparator(title: "Graphics"),
              viewModel.isLoading ?
                AppLoader() : Column(
                  children: [
                    GraphicComponent(dataList: viewModel.quotationUSD, title: "Dollar [USD]", isValuating: viewModel.quotationUSD[0]["isCurrencyValuating"], service: quotationService,),
                    GraphicComponent(dataList: viewModel.quotationEUR, title: "Euro [EUR]", isValuating: viewModel.quotationEUR[0]["isCurrencyValuating"], service: quotationService),
                    GraphicComponent(dataList: viewModel.quotationBTC, title: "Bitcoin [BTC]", isValuating: viewModel.quotationBTC[0]["isCurrencyValuating"], service: quotationService),
                  ],
                ),
        ]
        )
      ),
    );
  }
}
