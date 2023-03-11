import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:overlay_proj3/build_your_customized_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<Color>colors=[Colors.yellow[200]!,Colors.green[200]!,Colors.deepOrange[200]!,Colors.deepPurple,Colors.blueGrey];
  late final BuildContext _context;
   
  
  OverlayEntry?_overlayEntry;
  bool _overlayIsVisible=false;

  final GlobalKey _tragetWidgetKey=GlobalKey();
  final LayerLink _layerLink=LayerLink();
  
  Widget _getTargetWidget(){
    return CompositedTransformTarget(//To Create the target widget
      link: _layerLink,
      child: _designYourCutomizedTargetWidget(),
    );
  }

  void _showOverlay(){
    //Same as the previous
    OverlayState overlayState=Overlay.of(_context);
    RenderBox renderBox=_tragetWidgetKey.currentContext!.findRenderObject() as RenderBox;
    Offset offsetOfTargerWidget=renderBox.localToGlobal(Offset.zero);
    Size sizeOfTargerWidget=renderBox.size;

    _overlayEntry=OverlayEntry(
      builder: (context)=>CompositedTransformFollower(  //New Widget==>to follow the traget widget
        link: _layerLink,
        showWhenUnlinked: false,
        offset: _getYourOffset(sizeOfTargerWidget), //Imp Note==>offset is from target target not screen
        child:const BuildYourCustomizedWidget(),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  Offset _getYourOffset(Size sizeOfTargerWidget) => Offset(0,sizeOfTargerWidget.height-2);


  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(221, 41, 39, 39),
      appBar: _getAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(!_overlayIsVisible){
            _showOverlay();
          }else{
            _overlayEntry!.remove();
          }
          _overlayIsVisible=!_overlayIsVisible;
        },
      ),
      body: SafeArea(
        child: _getBodyWidget(),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title:const Text("Overlay Proj3",style: TextStyle(fontSize: 22),),
      systemOverlayStyle:const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }
  
  Widget _getBodyWidget(){
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        for(int i=0;i<2*colors.length;i++)
          _getItemDesign(i),          
      ],
    );
  }

  Widget _getItemDesign(int index){
    if(index==2){
      return _getTargetWidget();
    }
    return _getNormalContainerWidget(index);
  }

  

  Container _designYourCutomizedTargetWidget() {
    return Container(
      key: _tragetWidgetKey,
      height: 150,
      margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(20),
      ),
      child:const Center(child:Text("Target widget",style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),)),
    );
  }


  Container _getNormalContainerWidget(int index){
    return Container(
      height: 150,
      margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors[index>=colors.length?index-colors.length:index],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child:index==2?const Text("Target Widget ") :const FlutterLogo(size: 60,),
        ),
    );
  }

  

}