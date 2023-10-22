import 'package:flutter/material.dart';
import '../api_provider.dart';
import '../models/model.dart';
import 'details.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<DataModel>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.products != null) {
              return ListView.separated(
                itemBuilder: (context, index) =>
                    productItem(context, snapshot.data!.products![index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: snapshot.data!.products!.length,
              );
            } else {
              return const Center(child: Text('no data'));
            }
          },
        ),
      ),
    );
  }
}

Widget divider() => Container(
      width: double.infinity,
      height: 2,
      color: const Color.fromARGB(255, 225, 224, 224),
    );



bool toggle = true;
  favor() {
  toggle = !toggle;
}

Widget productItem(context, Product product) => Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   DetailsScreen( product),)
            );
          },
          child: Card(
            borderOnForeground: true,
            elevation: 20.0,
            color: Color.fromARGB(255, 190, 204, 205),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('${product.images![0]}'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              product.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              product.category!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${product.price} \$',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                      ),
                      child: IconButton(
                          onPressed: favor,
                          icon:  Icon(Icons.favorite_border_outlined)
                          ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        divider(),
      ],
    );

