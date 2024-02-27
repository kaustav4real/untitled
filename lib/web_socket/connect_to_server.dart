import 'package:web_socket_channel/web_socket_channel.dart';

connectSocketToServer(){
  try{
  final channel = WebSocketChannel.connect(Uri.parse('wss://your-websocket-server.com'));
  channel.stream.listen((message) {
    // ... handle messages
  });

  }catch(error)
  {
    print('Connection failed $error');
  }



}