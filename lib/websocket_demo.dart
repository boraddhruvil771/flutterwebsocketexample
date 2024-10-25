import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/websocket_demo_cubit.dart';

class WebSocketDemo extends StatefulWidget {
  WebSocketDemo({super.key});

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WebsocketDemoCubit>().connectWebSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebSocket Demo"),
        centerTitle: true,
      ),
      body: BlocBuilder<WebsocketDemoCubit, WebsocketDemoState>(
        builder: (context, state) {
          if (state is WebsocketDemoConnecting) {
            return Center(
              child: Column(
                children: [
                  Text(context.read<WebsocketDemoCubit>().state.toString()),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          }
          if (state is WebsocketDemoConnected) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var item = state.messages[index];
                        return Container(
                          color: Colors.blueAccent,
                          child: ListTile(
                            title: Text(item),
                          ),
                        );
                      },
                      itemCount: state.messages.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                                labelText: 'Send a message'),
                            onSubmitted: (message) {
                              if (message.isNotEmpty) {
                                context
                                    .read<WebsocketDemoCubit>()
                                    .sendMessage(message);
                                _controller.clear();
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            final message = _controller.text;
                            if (message.isNotEmpty) {
                              context
                                  .read<WebsocketDemoCubit>()
                                  .sendMessage(message);
                              _controller.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.read<WebsocketDemoCubit>().state.toString()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                              labelText: 'Send a message'),
                          onSubmitted: (message) {
                            if (message.isNotEmpty) {
                              context
                                  .read<WebsocketDemoCubit>()
                                  .sendMessage(message);
                              _controller.clear();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final message = _controller.text;
                          if (message.isNotEmpty) {
                            context
                                .read<WebsocketDemoCubit>()
                                .sendMessage(message);
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
