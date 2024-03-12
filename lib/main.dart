import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/TransactionItem.dart';
import 'package:flutter_application_2/providers/TransactionProvider.dart';
import 'package:flutter_application_2/screens/FormEditScreen.dart';
import 'package:sembast/sembast.dart';
import 'screens/FormScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TransactionProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'My Account',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'บัญชีของฉัน'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                },
                icon: Text(
                  "+",
                  style: TextStyle(fontSize: 30.0),
                ))
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, child) {
            provider.ininAlldata();
            int count = provider.transactions.length;
            if (count > 0) {
              List<TransactionItem> data = provider.getTransaction();
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text("${data[index].amount}"),
                      ),
                      title: Text(data[index].title),
                      subtitle: Text(data[index].date.toString()),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            provider.deleteData(data[index]);
                          }),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FormEditScreen(data: data[index]);
                        }));
                      },
                    ),
                    elevation: 10,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "No Data.",
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
          },
        )

        //
        );
  }
}
