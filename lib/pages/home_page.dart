import 'package:sql_test/db/db_provider.dart';
import 'package:sql_test/db/employee_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:sql_test/models/question_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late List<QuestionModel> questions;
  bool isLoading = false;
  int i = 10;

  // @override
  // void initState() {
  //   refreshQuestions();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   DBProvider.db.close();
  //   super.dispose();
  // }

  // Future refreshQuestions() async {
  //   setState(() => isLoading = true);

  //   questions = await DBProvider.db.getAllQuestion();
  //   await Future.delayed(const Duration(seconds: 2));

  //   setState(() => isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api to sqlite'),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.settings_input_antenna),
              onPressed: () async {
                //  refreshQuestions;
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.minimize),
              onPressed: () async {
                await _decData();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.usb_rounded),
              onPressed: () async {
                await _test();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
      //: _questionList(),
    );
  }

  _test() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllQuestion2();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllQuestion();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });
    await DBProvider.db.deleteAllQuestion();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _decData() async {
    setState(() {
      isLoading = true;
    });
    i--;
    await DBProvider.db.deleteOneQuestion(i);

    // wait for 1 second to simulate loading of data
    //await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllQuestion(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          print('-----------no-Data');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('--------has data');
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              //final question =
              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: const TextStyle(fontSize: 20.0),
                ),
                title: Text("question: ${snapshot.data[index].question}  "),
                subtitle: Text('date: ${snapshot.data[index].creationTime}'),
              );
            },
          );
        }
      },
    );
  }

  // _questionList() {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: questions.length,
  //     itemBuilder: (context, index) {
  //       final question = questions[index];
  //       return Container(
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(bottom: 5),
  //         color: Colors.green,
  //         child: Column(children: [
  //           Text(question.faqId.toString()),
  //           Text(question.question),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           Text(question.creationTime),
  //         ]),
  //       );
  //     },
  //   );
  // }
}
