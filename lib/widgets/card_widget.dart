import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/images/test_img.jpeg', fit: BoxFit.cover,)),
            const Column(
              children: [
                SizedBox(height: 8,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Card Title',
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                SizedBox(height: 4,),
                Text('Card description.', style: TextStyle(color: Colors.grey, fontSize: 11),),
                SizedBox(height: 8,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}