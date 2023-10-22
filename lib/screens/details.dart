import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../api_provider.dart';
import '../models/model.dart';

class DetailsScreen extends StatefulWidget {
  final Product data;

  const DetailsScreen(this.data, {Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<DataModel> fetchData() async {
    DataModel? data = await ApiProvider().getResponse();
    if (data == null) {
      throw Exception('No data received');
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 185, 235),
        title: const Text(
          'Details of Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DataModel>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<DataModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.products != null) {
            return SingleChildScrollView(child: detailsItem(context, widget.data));
          } else {
            return const Center(child: Text('no data'));
          }
        },
      ),
    );
  }
}

Widget detailsItem(context, Product data) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            data.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 20,
          ),
          Image(
            image: NetworkImage('${data.images![0]}'),
          ),
          const SizedBox(
            height: 10,
          ),
          RatingBar.builder(
            itemBuilder: (context,_)=> const Icon(Icons.star,color: Colors.amber,),
            onRatingUpdate: (rating){}
            ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data.description!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data.category!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 25,
          ),
          MaterialButton(
            onPressed: () {},
            color: const Color.fromARGB(255, 36, 185, 235),
            textColor: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Text('${data.price} \$'),
          ),
        ],
      ),
    );
