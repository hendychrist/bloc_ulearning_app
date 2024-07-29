import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/pay_web_view/bloc/payview_events.dart';
import 'package:ulearning_app/pages/course/pay_web_view/bloc/payview_states.dart';

class PayWebViewBlocs extends Bloc<PayWebViewEvent, PayWebViewState>{
  PayWebViewBlocs(): super( PayWebViewState()){
    on<TriggerWebView>(_triggerWebViewHandler);
  }

  void _triggerWebViewHandler(TriggerWebView event, Emitter<PayWebViewState> emit){
    emit(state.copyWith(url: event.url));
  }
}