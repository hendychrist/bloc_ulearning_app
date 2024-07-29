abstract class PayWebViewEvent{
  const PayWebViewEvent();
}

// inside add(TriggerWebView(url))
class TriggerWebView extends PayWebViewEvent{
  final String url;
  const TriggerWebView({required this.url});
}