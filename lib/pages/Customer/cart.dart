import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/order_item.dart';
import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: CartList.list.length,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(2, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          CartList.list[index].title,
                          style: const TextStyle(
                              fontFamily: 'ubuntu-bold', fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rs ${CartList.list[index].basePrice.toString()}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        const Text('Add Ons',
                            style: TextStyle(
                                fontFamily: 'ubuntu-bold', fontSize: 15)),
                        const SizedBox(height: 5),
                        ...CartList.list[index].addOns.keys
                            .map((e) => Text(
                                'Rs ${CartList.list[index].addOns[e]}    $e'))
                            .toList(),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Sub Total: Rs ${CartList.list[index].subTotal}',
                            style: const TextStyle(fontFamily: 'ubuntu-bold'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          height: 20,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  CartList.list[index].quantity--;
                                });
                                if (CartList.list[index].quantity == 0) {
                                  CartList.list.removeAt(index);
                                }
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: CartList.list[index].quantity != 0
                                      ? appGreen
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${CartList.list[index].quantity}',
                              style: const TextStyle(
                                  fontSize: 20, fontFamily: 'ubuntu-bold'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  CartList.list[index].quantity++;
                                });
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: appGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text('Total Rs ${CartList.list[index].totalPrice}',
                                style: const TextStyle(
                                    fontFamily: 'ubuntu-bold', fontSize: 20)),
                          ],
                        )
                      ],
                    ),
                  );
                })),
          ),
        ),
        CartList.list.isEmpty
            ? const SizedBox()
            : ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'ubuntu-bold', color: appGreen),
                )),
        const SizedBox(height: 10),
      ],
    );
  }
}
