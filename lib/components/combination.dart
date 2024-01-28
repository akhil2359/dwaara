import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Combination extends StatefulWidget {
  const Combination(
      {Key? key, required this.combination, required this.context})
      : super(key: key);

  final List<List<String>> combination;
  final BuildContext context;

  @override
  _CombinationState createState() => _CombinationState();
}

class _CombinationState extends State<Combination> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 20),
      child: Column(
        children: [
          Text(
            widget.combination.length.toString() + ' outfit combinations found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Row(
            children: [
              const Spacer(),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${_currentPage + 1}/${widget.combination.length}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                      width: 44.0), 
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.combination.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(right: 26),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: widget.combination[index][0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: widget.combination[index][1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: widget.combination[index][2],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: widget.combination[index][3],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
