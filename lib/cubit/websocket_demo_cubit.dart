import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

part 'websocket_demo_state.dart';

// websocket_demo_cubit.dart

class WebsocketDemoCubit extends Cubit<WebsocketDemoState> {
  late IOWebSocketChannel btcChannel;
  late IOWebSocketChannel ethChannel;
  late IOWebSocketChannel dogeChannel;

  WebsocketDemoCubit() : super(WebsocketDemoInitial());

  void connectWebSocket() {
    emit(WebsocketDemoConnecting());

    // Connect to BTC, ETH, and DOGE WebSocket streams
    btcChannel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/btcusdt@trade');
    ethChannel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/ethusdt@trade');
    dogeChannel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/dogeusdt@trade');

    // Listen for BTC price updates
    btcChannel.stream.listen((btcMessage) {
      final btcData = jsonDecode(btcMessage);
      final btcPrice = btcData['p'];

      // Listen for ETH price updates
      ethChannel.stream.listen((ethMessage) {
        final ethData = jsonDecode(ethMessage);
        final ethPrice = ethData['p'];

        // Listen for DOGE price updates
        dogeChannel.stream.listen((dogeMessage) {
          final dogeData = jsonDecode(dogeMessage);
          final dogePrice = dogeData['p'];

          emit(WebsocketDemoConnected(
            btcPrice: btcPrice,
            ethPrice: ethPrice,
            dogePrice: dogePrice,
            messages: [],
          ));
        });
      });
    });
  }

  void disconnectWebSocket() {
    btcChannel.sink.close();
    ethChannel.sink.close();
    dogeChannel.sink.close();
  }

  void sendMessage(String message) {}
}
