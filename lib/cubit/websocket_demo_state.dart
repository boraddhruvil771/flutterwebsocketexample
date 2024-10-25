part of 'websocket_demo_cubit.dart';

@immutable
sealed class WebsocketDemoState {}

final class WebsocketDemoInitial extends WebsocketDemoState {}

final class WebsocketDemoConnecting extends WebsocketDemoState {}

final class WebsocketDemoConnected extends WebsocketDemoState {
  final String btcPrice;
  final String ethPrice;
  final String dogePrice;
  final List<String> messages;

  WebsocketDemoConnected({
    required this.btcPrice,
    required this.ethPrice,
    required this.dogePrice,
    required this.messages,
  });
}
