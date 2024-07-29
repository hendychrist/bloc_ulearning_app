import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/common_widget.dart';
import 'package:ulearning_app/pages/course/pay_web_view/bloc/payview_blocs.dart';
import 'package:ulearning_app/pages/course/pay_web_view/bloc/payview_events.dart';
import 'package:ulearning_app/pages/course/pay_web_view/bloc/payview_states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWebView extends StatefulWidget {
  const PayWebView({super.key});

  @override
  State<PayWebView> createState() => _PayWebViewState();
}

class _PayWebViewState extends State<PayWebView> {
  late final webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    print('----------my url is ${args['url']}');

    context.read<PayWebViewBlocs>().add(TriggerWebView(url:args['url']));
    
    webViewController = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..addJavaScriptChannel(
                    'Pay', 
                    onMessageReceived: (JavaScriptMessage message){
                      print('WebView -> onMessageReceived : ${message.message}');
                      Navigator.of(context).pop(message.message);
                    },
                    
                  )
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onHttpError: (HttpResponseError error) {},
                    onWebResourceError: (WebResourceError error) {},
                    onNavigationRequest: (NavigationRequest request) {
                      if (request.url.startsWith(args["url"])) {
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(args["url"]));

  }

  @override
  void dispose() {
    webViewController.clearCache();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3714 496353 98431 12/25

    return BlocBuilder<PayWebViewBlocs, PayWebViewState>(
      builder: (context, state) {

        return Scaffold(
                  appBar: buildAppBar('Payment Page'),
                  body: WebViewWidget(controller: webViewController)
                );
      }
    );
  }
}