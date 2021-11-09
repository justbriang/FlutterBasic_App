import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutterbasic/core/bloc/response_bloc/response_bloc.dart';
import 'package:flutterbasic/screens/response/widgets/list_item_tile.dart';
import 'package:flutterbasic/screens/response/widgets/loading_progress_indicator.dart';

import 'package:flutterbasic/utils.dart';
import 'package:shimmer/shimmer.dart';

class ResponsePage extends StatefulWidget {
  static const name = 'ResponsePage';
  ResponsePage({Key? key}) : super(key: key);

  @override
  _ResponsePageState createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  ResponseBloc _responseBloc = ResponseBloc();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child:Text(
          'Response',
          style: TextStyle(color: Colors.blue),
        ),),
     
      ),
      body: BlocProvider(
          create: (context) {
            return _responseBloc;
          },
          child: BlocConsumer(
            bloc: _responseBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ResponseInitial) {
            _responseBloc.add(FetchResponses());
                return Center(
                  child: Column(
                    children: List<Widget>.generate(
                        5,
                        (index) => Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: _loadingJobsShimmer(context),
                            )),
                  ),
                );
              }
              if (state is ResponseError) {
                // return Center(
                //   child: Text(state.message!),
                // );
              }
              if (state is ResponseLoaded) {
                if (state.response!.isEmpty) {
                  return Center(
                    child: Text('No response received. Yet!'),
                  );
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: index >= state.response!.length
                              ? LoadingProgressIndicator()
                              : ListItemTile(response: state.response![index]),
                        ),
                      ),
                    );
                  },
                  itemCount: state.hasReachedMax!
                      ? state.response!.length
                      : state.response!.length + 1,
                  controller: _scrollController,
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                );
              }
            },
          )),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _loadingJobsShimmer(BuildContext context) => Shimmer.fromColors(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 20,
              decoration: BoxDecoration(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 20,
              decoration: BoxDecoration(color: Colors.grey),
            ),
          ),
        ],
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!);

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _responseBloc.add(FetchResponses());
    }
  }
}
