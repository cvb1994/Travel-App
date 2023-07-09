import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PeopleSelectPage extends StatefulWidget{
  VoidCallback onCancel;
  VoidCallback onSave;
  TextEditingController adultController;
  TextEditingController childController;
  PeopleSelectPage({super.key, required this.onCancel, required this.onSave, required this.adultController, required this.childController});

  @override
  State<PeopleSelectPage> createState() => _PeopleSelectPageState();
}

class _PeopleSelectPageState extends State<PeopleSelectPage>{
  int adults = 0;
  int child = 0;

  @override
  void initState(){
    try {
      adults = int.parse(widget.adultController.text);
      child = int.parse(widget.childController.text);
      super.initState();
    } on Exception {}
    
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(149, 211, 209, 209),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: BorderDirectional(bottom: BorderSide(color: Color.fromARGB(255, 196, 193, 193), width: 0.6))
                    ),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
                        const Text("People")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  //height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Text("Adult", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                      Text("Above 13 year old", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)
                                    ]),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            if(adults > 0){
                                              setState(() {
                                                adults--;
                                                widget.adultController.text = adults.toString();
                                              });
                                            }
                                            
                                          },
                                          child: Icon(Icons.remove_circle_outline, size: 30,),
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Expanded(child: Center(child: Text(adults.toString(), style: TextStyle(fontSize: 17)))),
                                      const SizedBox(width: 5,),
                                      SizedBox(
                                        width: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              adults++;
                                              widget.adultController.text = adults.toString();

                                            });
                                          },
                                          child: Icon(Icons.add_circle_outline, size: 30),
                                        )
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          //Child part
                          SizedBox(
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Text("Children", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                      Text("Below 13 year old", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)
                                    ]),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            if(child > 0){
                                              setState(() {
                                                child--;
                                                widget.childController.text = child.toString();
                                              });
                                            }
                                            
                                          },
                                          child: Icon(Icons.remove_circle_outline, size: 30,),
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Expanded(child: Center(child: Text(child.toString(), style: const TextStyle(fontSize: 17)))),
                                      const SizedBox(width: 5,),
                                      SizedBox(
                                        width: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              child++;
                                              widget.childController.text = child.toString();
                                            });
                                          },
                                          child: const Icon(Icons.add_circle_outline, size: 30),
                                        )
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: BorderDirectional(top: BorderSide(color: Color.fromARGB(255, 196, 193, 193), width: 0.6))
                    ),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10), 
                          child: GestureDetector(
                            onTap: widget.onSave,
                            child: SizedBox(
                              width: 80,
                              height: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber
                                ),
                                child: const Center(child: Text("Save"),),
                              ),
                            ),
                          ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        )
        
      ],
    );
  }
}
