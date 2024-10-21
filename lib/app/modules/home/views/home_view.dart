import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ValueNotifier<GraphQLClient> client;

  const HomeView(
    this.client, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('HomeView'),
            centerTitle: true,
          ),
          body: Query(
              options: QueryOptions(
                document: gql(controller.readCharacters),
                variables: {'page': 1},
                fetchPolicy:
                    FetchPolicy.networkOnly, // Disable caching for fresh data
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Center(
                    child: Text(result.exception.toString()),
                  );
                }
                if (result.isLoading && controller.characters.isEmpty) {
                  // Show initial loader if loading for the first time
                  return const Center(child: CircularProgressIndicator());
                }
                final pageInfo = result.data?['characters']['info'];
                final nextPage = pageInfo?['next'];
                final List<dynamic> characters =
                    result.data?['characters']['results'] ?? [];
                if (characters.isNotEmpty && controller.characters.isEmpty) {
                  controller.characters.addAll(characters);
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!result.isLoading &&
                        nextPage != null&&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      fetchMore?.call(FetchMoreOptions(
                          variables: {'page': nextPage},
                          updateQuery: (previousData, fetchMoresData) {
                            controller.characters.addAll(
                                fetchMoresData?['characters']['results']);
                            // final List<dynamic> updatedCharacters =[
                            //   ...previousData?['characters']['results'] as List<dynamic>,
                            //   ...fetchMoresData?['characters']['results'] as List<dynamic>,
                            // ];
                            // fetchMoresData?['characters']['results'] = updatedCharacters;
                            // fetchMoresData?['characters']['info'] = fetchMoresData['characters']['info'];

                            return fetchMoresData;
                          }));
                    }
                    return true;
                  },
                  child: ListView.builder(
                      itemCount: controller.characters.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.characters.length) {
                          // Show loader at the bottom during pagination
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final character = controller.characters[index];
                        return ListTile(
                          leading: Image.network(character['image']),
                          title: Text(character['name']),
                          trailing: Text(character['id']),
                          subtitle: Text('Status: ${character['status']}'),
                        );
                      }),
                );
              })),
    );
  }
}
