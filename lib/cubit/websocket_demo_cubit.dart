import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

part 'websocket_demo_state.dart';

class WebsocketDemoCubit extends Cubit<WebsocketDemoState> {
  late IOWebSocketChannel channel;
  final List<String> messages = [];

  WebsocketDemoCubit() : super(WebsocketDemoInitial());

  void connectWebSocket() {
    emit(WebsocketDemoConnecting());
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
        emit(WebsocketDemoConnected(messages: []));
        channel.stream.listen((message) {
          print("message----> $message");
          messages.add(message);
          emit(WebsocketDemoConnected(messages: messages));
        });
      },
    );
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }
}
