

# flutter_database

เนื้อหาการสอน Flutter + Database(Sembast)

# pubspec.yaml
ในส่วนของ pubspec.yaml เราจะเพิ่ม `package` ที่จะเป็นต้องใช้ในการทำงานของ sambast และอื่นๆที่จำเป็น โดยวิธีการเพิ่มจะมี 2 วิธี ดังนี้

**1. เพิ่มโดยกำหนด version โดยการเพิ่มแบบนี้จะเร็วที่สุดแต่จะไม่ได้ version ใหม่ที่สุด**

โดยอย่างแรกให้หาโค้ดที่เขียนว่า **dependencies** จากนั้นนำโด้ดด้านล่างใส่ไว้ข้างล่างของ `cupertino_icons: ^1.0.2(version อาจมีการเปลี่ยนแปลงตามการอัพเดต)`
> provider: ^6.1.1
> 
> sembast: ^3.6.0
> 
> path_provider: ^2.1.2
> 
> path: ^1.8.3

ดังภาพตัวอย่าง

![*หากทำสำเร็จจะได้ตาม*](https://github.com/MANON-T/flutter_database/blob/main/image/pubspec.png)

จากนั้นกด save ตัว VS Code จะทำการ get package ที่เราเพิ่มเข้าไปใน pubspec  โดยอัตโนมัติ

**2. เพิ่มโดยโหลด package โดยตรง วิธีนี้เป็นวิธีที่ค่อนข้างใช้เวลา แต่ก็แลกมากับการได้ version ที่ใหม่กว่า**

โดยการเปิด terminal ใน VS Code ขึ้นมาแล้วใช้คำสั่งต่อไปนี้
```shell
flutter pub add provider
```
```shell
dart pub add sembast
```
```shell
flutter pub add path_provider
```
```shell
dart pub add path
```
โดยการติดตั้ง package ตัวต่อไปจำเป็นต้องรอให้ package ตัวก่อนหน้าติดตั้งเสร็จก่อน และเมื่อใช้คำสั่งเหล่นนี้ ตัว package จะถูกเพิ่มไปยัง pubspace โดยอัตโนมัติ

# lib
**✨models -> TransactionItem.dart**
ในส่วนของโมเดลนั้นจะเป็นเหมือนแอตทริบิวต์ในฐานข้อมูลที่จะกำหนดว่าควรมีชื่อว่าอะไรและมีชนิดข้อมูลเป็นอะไรโดยจุดที่ต้องสนใจคือ

    late  int?  id;
	String  title;
	double  amount;
	String  date;

โค้ดด้านบนเป็นการกำหนดโมเดลอย่างที่กล่าวไว้ข้างต้นในที่นี้ถ้าให้เห็นภาพก็จะได้ข้อมูลประมาณนี้

|ชนิดข้อมูล| ชื่อแอตทริบิวต์ |
|--|--|
| int | id |
|String|👉 title|
|double|👉 amount|
|String|👉 date|

โดยชื่อแอตทริบิวต์ที่มี 👉 หมายถึงเป็นแอตทริบิวต์ที่สามารถแก้ใขได้ทั้งชนิดข้อมูลและชื่อ ส่วนที่ไม่มี 👉  **ก็อย่าไปแตะ**

    TransactionItem({this.id, required  this.title, required  this.amount, required  this.date});
 ต่อมาจะเป็นส่วนของ **constructor** ในส่วนนี้จะไม่พูดอะไรมากแค่จับคู่ทำตามแพทเทิร์นที่ว่า `required  this.ชื่อแอตทริบิวต์ที่สร้างไว้ข้างบน` ทำแบบนี้จนครบทุกอัน เว้นแต่ id ที่ต้องเขียนตามเป๊ะๆ และอย่าลืม **,** เมื่อเขียนแต่ละตัวเสร็จ

    Map<String,dynamic> toMap(){
		return{
		'id':  id,
		'title':  title,
		'amount':  amount,
		'date':  date
		};
	}

ตรงนี้คือการ Map หรือที่เรียกกันติดหูว่าเป็นข้อมูลแบบ Dictionary การเก็บข้อมูลจะเป็นแบบ key:value โดยจากโค้ดจะเป็นการจับคู่ key และ value โดยการตั้งชื่อให้เหมือนกันในส่วนนี้ก็แนะนำว่าควรเป็นแบบนี้เพื่อง่ายในการจัดการ

| ชื่อ | ความหมาย |
|--|--|
| key | ชื่อตัวแปรที่เรากำหนดเองสำหรับการเข้าถึง |
| value | ค่าของข้อมูลในที่นี้คือแอตทริบิวต์ที่ได้กำหนดไว้ตอนต้น |

**✨databases-> TransactionDB.dart**
ในไฟล์ TransactionDB.dart มีจุดที่ต้องแก้ไขหลายจุดโดยเริ่มจาก

    import  'dart:io';
	import  'package:ชื่อโฟลเดอร์โปรเจกต์ของคุณ/models/TransactionItem.dart';
	import  'package:path/path.dart';
	import  'package:path_provider/path_provider.dart';
	import  'package:sembast/sembast.dart';
	import  'package:sembast/sembast_io.dart';

ส่วนแรกคือส่าน **import** ในบรรทัดที่ 2 โดยส่วนนี้สามารถแก้ได้โดยเปลี่ยนพาร์ทเดิมที่มีอยู่เป็นพาร์ทของตัวเองโดยใส่แทนที่ **ชื่อโฟลเดอร์โปรเจกต์ของคุณ** แต่หากแก้แล้วยังแดงให้เขียน import นั้นขึ้นมาใหม่

    Future<int> insertData(TransactionItem  trans) async{
		var  db  =  await  this.openDatabase();
		var  store  =  intMapStoreFactory.store("expense");
		
		var  keyId  =  await  store.add(db, {
			👉"title":trans.title,
			👉"amount":trans.amount,
			👉"date"  :trans.date,
		});
		
		print("$keyId");
		db.close();
		return  keyId;

	}

ในส่วนของโค้ดที่มี 👉 เป็นส่วนที่สามารถแก้ไขได้ โดยการแก้ไขต้องอ้างอิงจากชื่อแอตทริบิวต์ที่สร้างไว้ใน **TransactionItem** 

    Future<List<TransactionItem>> loadAllData() async{
	    var  db  =  await  this.openDatabase();
	    var  store  =  intMapStoreFactory.store("expense");
    
	    var  snapshot  =  await  store.find(
		    db,
		    finder:  Finder(sortOrders: [SortOrder(Field.key,false)])
	    );
    
	    print(snapshot);

	    List<TransactionItem> transactions  = [];
	    for (var  item  in  snapshot) {
		    int  id  =  item.key;
		    👉String  title  =  item['title'].toString();
		    👉double  amount  =  double.parse(item['amount'].toString());
		    👉String  date  =  item['date'].toString();
			TransactionItem  trans  =  TransactionItem(id:id, 👉title:title, 👉amount:amount, 👉date:  date); 
		    transactions.add(trans);
		}
	    db.close();
	    return  transactions;
    }

เช่นเคยในส่วนที่มีเครื่องหมาย 👉 หมายถึงสามารถแก้ได้แต่ต้องเป็นการแก้ที่อิงข้อมูลมาจาก **TransactionItem** ในที่นี้

    👉String  title  =  item['title'].toString();
    👉double  amount  =  double.parse(item['amount'].toString());
    👉String  date  =  item['date'].toString();
    
เป็นการเปลี่ยนแปลงค่าชนิดข้อมูลเดิมให้กลายเป็น String โดยหากต้องการเปลี่ยนแบบอื่นอีกก็ใช้ ChatGPT ได้เลย 😂

    TransactionItem trans = TransactionItem(id:id, 👉title:title, 👉amount:amount, 👉date: date);
    
   และส่วนของ TransactionItem ก็จะเป็นการจับคู่ข้อมูลแบบที่ได้อธิบายไว้ข้างต้นเช่นกัน

**✨providers-> TransactionProvider.dart**

ในส่วของ TransactionProvider นั้นไม่มีอะไรให้ต้องแก้ไขมากมีแค่ส่วนของ **import** และการกำหนดชื่อ **datadase** เท่านั้น

    import  'package:flutter/foundation.dart';
	import  'package:ชื่อโฟลเดอร์โปรเจกต์ของคุณ/databases/TransactionDB.dart';
	import  'package:ชื่อโฟลเดอร์โปรเจกต์ของคุณ/models/TransactionItem.dart';
	import  'package:sembast/sembast.dart';

สำหรับการแก้ไขในส่วนของ import จะเป็นวิธีเดียวกับการแก้ไขในส่วนของ **databases-> TransactionDB.dart** สามารถใช้วิธีเดียวกันในการแก้ปัญหาได้

    String  dbName  =  "ชื่อฐานข้อมูล.db";

ในส่วนของการตั้งชื่อหากอิงจากโค้ดต้นฉบับจะอยู่บรรทัดที่ 7 ในส่วนนี้เราสามารถตั้งชื่อฐานข้อมูลได้อิสระ แต่แนะนำว่าไม่ควรตั้งชื่อที่ยากและซับซ้อนเกินไปหรือแม้กระทั่งการตั้งชื่อเป็นภาษาไทยก็ตาม โดยหากต้องการเปลี่ยนฐานข้อมูลก็สามารถเปลี่ยนได้ง่ายๆ โดยการแก้ไขชื่อเป็นอันจบ

**✨screens -> FormScreen.dart**
ในส่วนของ FormScreen หรือหน้าฟอร์มสำหรับการกรอกข้อมูลนั้นจะมีที่ต้องสังเกตอยู่พอสมควร

ซึ่งอย่างแรกคือ `part` ซึ่งสามารถดูวิธีแก้ได้ที่หัวข้อ **providers-> TransactionProvider.dart** หรือ **databases-> TransactionDB.dart**

    final  titleController  =  TextEditingController();
	final  amountController  =  TextEditingController();
	
ส่วนต่อมาคือส่วนการสร้าง Controller โดยในที่นี้สามารถเพิ่มหรือลดได้ตามความสะดวยโดยหากต้องการเพิ่มก็สามารถเขียนตามตัวอย่างนี้

    final  ชื่อของฟอร์ม  =  TextEditingController();
    
สำหรับการใช้งานหากอิงตามโค้ดจะอยู่บรรทัดที่ 42 - 57 โดยขอยกตัวอย่างเป็นของ "จำนวนเงิน" เนื่องจากมีรายละเอียดที่น่าจะเป็นประโยชน์

    TextFormField(
		decoration:  const  InputDecoration(label:  Text("👉จำนวนเงิน")),
		👉keyboardType:  TextInputType.number,
		validator: (value) {
			try{
				if(value!.isNotEmpty){
					if(double.parse(value) >=  0){
						return  null;
					}
				}throw();
			}catch(e){
				👉return  "กรุณาใส่จำนวนเงิน";
			}
		},
		👉controller:  amountController,
	)
สำหรับในส่วนของเครื่องหมาย 👉 หมายถึงเป็นจุดที่น่าสนใจเริ่มจาก
|ชื่อ| ความหมาย |
|--|--|
| จำนวนเงิน | หมายถึงข้อความที่แสดงบนหน้ากรอกข้อมูลที่บอกว่าควรกรอกอะไร |
||![enter image description here](https://github.com/MANON-T/flutter_database/blob/main/image/Formscreen.png)|
|keyboardType:  TextInputType.number|เป็นการกำหนดรูปแบบ keyboard สำหรับในฟอร์มนี้ให้เป็นคีบอร์ดแบบตัวเลข|
||![enter image description here](https://github.com/MANON-T/flutter_database/blob/main/image/Formscreen%20-%202.png)|
|return  "กรุณาใส่จำนวนเงิน"|เป็นการแสดงข้อความหากไม่กรอกข้อมูลแล้วกดส่ง|
|controller:  amountController|เป็นการกำหนดว่าจะใช้ Controller ตัวใหนในการรับข้อมูล ซึ่ง Controller นี้ก็คืออันเดียวกันกับที่สร้างไว้ข้างบน|


    TextButton(
		onPressed: (){
			if(formKey.currentState!.validate()){
	
				//สร้าง ข้อมูล สำหรับ provider
				👉TransactionItem  transaction  =  TransactionItem(title:  titleController.text, amount:  double.parse(amountController.text), date: (DateTime.now().toString()));
				print("${transaction.title}  ${transaction.amount}  ${transaction.date}");
				  
				//ส่งข้อมูลให้ provider
				var  provider  =  Provider.of<TransactionProvider>(context, listen:  false);
				provider.addTransaction(transaction);
				  
				Navigator.pop(context);
			}
		},
		👉child:  Text("เพิ่มข้อมูล", style:  TextStyle(color:  const  Color.fromARGB(255, 245, 10, 10)),),
	)

ต่อมาคือส่วนของปุ่มโดยก็จะเน่นที่ 👉 อีกตามเคย
สำหรับส่วนแรกจะเป็นการสร้าง ข้อมูล สำหรับ provider โดยจะอิงตาม models ว่ามีอะไรบ้าง และกำหนดข้อมูลลงไป

    TransactionItem transaction = TransactionItem(title: titleController.text, amount: double.parse(amountController.text), date: (DateTime.now().toString()));

โดยหาข้อมูลที่ต้องการเป็นข้อมูลที่มาจาก Controller ที่ได้สร้างไว้ ก็สามารถใช้ชื่อของ Controller เข้าไปใส่แทนข้อมูลได้เลย โดยจำเป็นที่จะต้องแปลงข้อมูลให้ตรงกับชนิที่ได้กำหนดไว้ใน models ด้วย

**✨screens -> FormEditScreen.dart**
เริ่มต้นเลยก็เป็นวงจรที่ทำมานานก็คือแก้ part ก่อน ตามวิธีที่ได้อธิบายไว้ข้างตน

สำหรับ **Controller** ไม่ได้แตกต่างจาก **FormScreen** มาก โดยจะมีแก้แค่ดึงข้อมูลมาแสดงที่ Controller และแก้ไข้จากการ add เป็น update

    void  initState() {
	// TODO: implement initState
	super.initState();
	👉titleController.text  =  widget.data.title.toString();
	👉amountController.text  =  widget.data.amount.toString();
	}
โดยตัวอย่างนี้คือการดึงข้อมูลมาแสดงใน Controller ซึ่งจุดที่สามารถแก้ไขได้คือจุดที่ทำเครื่องหมาย 👉 โดยถ้าสังเกตุ ตัว Controller จะเป็นชื่อเดียวกับของ
FormScreen และใช้ widget.data เพื่อดึงข้อมูลลจากค่าที่กำหนดไว้หลัง **.** และอย่าลืมเปลี่ยนเป็น String

    TransactionItem  transaction  =  TransactionItem(👉id:  widget.data.id, title:  titleController.text, amount:  double.parse(amountController.text), date:  DateTime.now().toIso8601String());

ในส่วนของ TransactionItem ก็จะมีความเหมือนกับ FormScreen เลยแต่ที่ต่างคือ มีการเพิ่ม id เข้ามาด้วย ในส่วนนี้แจ้งให้ทราบเฉยๆ แต่ส่วนที่ต้องแก้จริงๆ ก็จะเป๋นส่วนเดียวกับ FormScreen เลย

**✨main**
ในส่วนของ main เหตุผลที่เก็บไว้เป็นตัวสุดท้ายเพราะจำเป็นต้องมีไฟล์อื่นๆให้ครบก่อน main จึงจะสามารถเขียนไห้สมบูรณ์ได้

เริ่มมาก็เช่นเคยแก้ไข part ให้เรียบร้อยเสียก่อนส่วนวิธีเขียนไว้ในหัวข้อของ **databases** และ **providers** แล้ว

    title:  'My Account',
	theme:  ThemeData(
		colorScheme:  ColorScheme.fromSeed(seedColor:  Colors.👉deepPurple),
		useMaterial3:  true,
	),
	home:  const  MyHomePage(title:  '👉บัญชีของฉัน'),

เริ่มต้นด้วยอะไรง่ายๆอย่างแถบด้านบน โดยที่มีเครื่องหมาย 👉 คือจุดที่ควรให้ความสนใจ
|ชื่อ| ความหมาย |
|--|--|
| deepPurple | เป็นการกำหนดแถบด้านบนว่าจะให้เป็นสีอะไร |
||![enter image description here](https://github.com/MANON-T/flutter_database/blob/main/image/main.png)|
|title|เป็นการกำหนดไตเติ้ลที่แสดงในหน้าแอปว่าจะให้แสดงข้อความอะไร|

    appBar:  AppBar(
		backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
		title:  Text(widget.title),
		actions: [
			IconButton(
				onPressed: () {
					Navigator.push(context, MaterialPageRoute(builder: (context) {
						return  👉FormScreen();
					}));
				},
				icon:  Text(
					👉"+",
					style:  TextStyle(fontSize:  30.0),
				))
		],
	)
ในจุดที่มี 👉 นั้นเป็นจุดที่สามารถแก้ไขได้โดยในส่วนของ FormScreen() คือการ Navigator ไปยังหย้าดังกล่าวเมื่อปุ่มถูกกด และ "+" คือสัญลักษณ์หรือเคื่องหมายของปุ่ม

    return  Card(
		child:  ListTile(
			👉leading:  CircleAvatar(
				👉radius:  30,
				👉child:  Text("${data[index].amount}"),
			),
			👉title:  Text(data[index].title),
			👉subtitle:  Text(data[index].date.toString()),
			trailing:  IconButton(
				icon:  const  Icon(👉Icons.delete),
				onPressed: () {
					var  provider  =  Provider.of<TransactionProvider>(
						context,
						listen:  false);
					provider.deleteData(data[index]);
				}),
			onTap: () {
				Navigator.push(context,
						MaterialPageRoute(builder: (context) {
					return 👉FormEditScreen(data:  data[index]);
				}));
			},
		),
		elevation:  10,
		margin:  EdgeInsets.symmetric(vertical:  10, horizontal:  10),
	);

ในส่วนนี้จะเป็นโค้ดส่วนของการแสดงหลักโดยจุดที่มีเครื่องหมาย 👉 นั้นเป็นจุดที่สามารถปรับแก้ได้

![enter image description here](https://github.com/MANON-T/flutter_database/blob/main/image/main%20-%202.png)

|ชื่อ| ความหมาย |
|--|--|
| leading: CircleAvatar | เป็นการกำหนดให้มีวงกลมอยู่ข้างหน้า |
|radius|เป็นการกำหนดรัสมีของวงกลม|
|child:  Text("${data[index].amount}")|เป็นการกำหนดให้ข้อความที่อยู่ข้างในเป็น amount|
|title|เป็นการกำหนดให้แสดงข้อความตามที่กำหนด|
|subtitle|เป็นการกำหนดข้อความข้างใต้ส่วนของ title โดยจะมีขนาดเล็กกว่า|
|Icons.delete|เป็นการกำหนดให้ Icons ที่แสดงข้างหลังเป็นรูปถังขยะ|
|FormEditScreen(data:  data[index])|เป็นการกำหนดว่าหากคลิกแล้วจะไปยังหน้า FormEditScreen โดยจะทำการส่งข้อมูลทั้งหมดตาม index ที่กำหนดไว้ไปด้วย|
