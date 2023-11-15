import 'package:flutter/material.dart';
import 'package:frontend/wait_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter De',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MywaitBody(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_mjpeg/flutter_mjpeg.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final isRunning = useState(true);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Demo Home Page'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: Mjpeg(
//                 isLive: isRunning.value,
//                 error: (context, error, stack) {
//                   print(error);
//                   print(stack);
//                   return Text(error.toString(),
//                       style: TextStyle(color: Colors.red));
//                 },
//                 stream:
//                     'http://127.0.0.1:5000/video', //'http://192.168.1.37:8081',
//               ),
//             ),
//           ),
//           Row(
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   isRunning.value = !isRunning.value;
//                 },
//                 child: Text('Toggle'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Scaffold(
//                             appBar: AppBar(),
//                           )));
//                 },
//                 child: Text('Push new route'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
