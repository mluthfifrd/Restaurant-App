import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/add_review_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class RestaurantDetailAddReview extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailAddReview({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailAddReview> createState() =>
      _RestaurantDetailAddReviewState();
}

class _RestaurantDetailAddReviewState extends State<RestaurantDetailAddReview> {
  final TextEditingController _inputName = TextEditingController();

  final TextEditingController _inputReview = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddReviewProvider>(
      create: (_) => AddReviewProvider(
          apiService: ApiService(),
          restaurantId: widget.restaurantId,
          name: _inputName.text,
          review: _inputReview.text),
      child: Consumer<AddReviewProvider>(builder: (context, state, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Review",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _inputName,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan Nama';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _inputReview,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Review',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.only(
                          right: 15.0, left: 15.0, bottom: 20.0),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan Pesan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          state.addReview(widget.restaurantId, _inputName.text,
                              _inputReview.text);
                          _inputName.clear();
                          _inputReview.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('Berhasil Menambahkan Review'),
                              // backgroundColor: Colors.blue.shade900,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'Tutup',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailPage(
                                  restaurantId: widget.restaurantId),
                            ),
                          ).then((value) => setState(() {}));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                          ));
                        }
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: Text(
                          'Tambah Review',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
