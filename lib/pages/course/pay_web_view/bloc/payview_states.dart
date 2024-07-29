class PayWebViewState{
  final String url;

  PayWebViewState({this.url = "",});

  PayWebViewState copyWith({required String? url,}) {
    return PayWebViewState(
      url: url ?? this.url,
    );
  }
}