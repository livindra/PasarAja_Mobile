import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pasaraja_mobile/config/widgets/loading_indicator.dart';
import 'package:pasaraja_mobile/config/widgets/merchant_sub_appbar.dart';
import 'package:pasaraja_mobile/config/widgets/page_error_message.dart';
import 'package:pasaraja_mobile/config/widgets/something_wrong.dart';
import 'package:pasaraja_mobile/core/constants/constants.dart';
import 'package:pasaraja_mobile/core/sources/provider_state.dart';
import 'package:pasaraja_mobile/module/merchant/providers/product/recommended_provider.dart';
import 'package:provider/provider.dart';

class RecommendedPage extends StatefulWidget {
  const RecommendedPage({super.key});

  @override
  State<RecommendedPage> createState() => RecommendedPageState();
}

class RecommendedPageState extends State<RecommendedPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchData();
    });
    super.initState();
  }

  Future<void> _fetchData() async {
    try {
      await Provider.of<RecommendedProvider>(
        context,
        listen: false,
      ).fetchData();
    } catch (ex) {
      Fluttertoast.showToast(msg: PasarAjaConstant.unknownError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: merchantSubAppbar('Produk Direkomendasikan'),
      body: RefreshIndicator(
        onRefresh: () async {
          await PasarAjaConstant.onRefreshDelay;
          _fetchData();
        },
        child: Consumer<RecommendedProvider>(
          builder: (context, value, child) {
            // on loading
            if (value.state is OnLoadingState) {
              return const LoadingIndicator();
            }

            if (value.state is OnFailureState) {
              return PageErrorMessage(
                onFailureState: value.state as OnFailureState,
              );
            }

            if (value.state is OnSuccessState) {
              return const Center(
                child: Text("success"),
              );
            }

            return const SomethingWrong();
          },
        ),
      ),
    );
  }
}
