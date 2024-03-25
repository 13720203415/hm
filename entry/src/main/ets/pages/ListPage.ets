class Item {
  name:string
  image:ResourceStr
  price:number
  discount: number

  constructor(name:string,image : ResourceStr, price:number,discount: number = 0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }
}

import {Header} from "../components/Header"

//全局自定义构造函数
// @Builder function  ItemCard(item: Item) {
//   Row({space:10}){
//     Image(item.image)
//       .width(100)
//     Column({space:4}){
//       Text(item.name)
//         .fontSize(20)
//         .fontWeight(FontWeight.Bold)
//
//       if(item.discount) {
//         Text("原价：¥" + item.price)
//           .fontSize(14)
//           .fontColor("#CCC")
//           .decoration({type:TextDecorationType.LineThrough})
//
//         Text("折扣价：¥" + (item.price - item.discount))
//           .fontSize(18)
//           .fontColor("#F36")
//         Text("补贴：¥" + item.discount)
//           .fontSize(18)
//           .fontColor("#F36")
//       } else {
//         Text("¥" + item.price)
//           .fontSize(18)
//           .fontColor("#F36")
//       }
//     }
//     .height("100%")
//     .alignItems(HorizontalAlign.Start)
//   }
//   .width("100%")
//   .backgroundColor("#fff")
//   .borderRadius(20)
//   .height(120)
//   .padding(10)
// }

//全局样式
// @Styles function commonColumn() {
//   .width("100%")
//   .height("100%")
//   .backgroundColor("#efefef")
//   .padding(20)
// }

//全局特定样式
@Extend(Text) function priceText() {
  .fontSize(18)
  .fontColor("#F36")
}

@Entry
@Component
struct ListPage {
  private items : Array<Item> = [
    new Item("华为mate60",$r("app.media.icon"),6000,500),
    new Item("华为mate60",$r("app.media.icon"),6001),
    new Item("华为mate60",$r("app.media.icon"),6002,400),
    new Item("华为mate60",$r("app.media.icon"),6003),
    new Item("华为mate60",$r("app.media.icon"),6004),
    new Item("华为mate60",$r("app.media.icon"),6005),
    new Item("华为mate60",$r("app.media.icon"),6006),
    new Item("华为mate60",$r("app.media.icon"),6007)
  ]

  //局部样式
  @Styles commonColumn() {
    .width("100%")
    .height("100%")
    .backgroundColor("#efefef")
    .padding(20)
  }

  build(){
    Column({space:8}){
      Header({title:"商品列表"})
        .margin({bottom:20})

      List({space:8}) {
        ForEach(
          this.items,
          (item:Item) =>{
            ListItem(){
              this.ItemCard(item)
            }
          }
        )
      }
      .width("100%")
      .layoutWeight(1) //权重
    }
    .commonColumn()

  }

  //局部自定义构造函数
  @Builder ItemCard(item: Item) {
    Row({space:10}){
      Image(item.image)
        .width(100)
      Column({space:4}){
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        if(item.discount) {
          Text("原价：¥" + item.price)
            .fontSize(14)
            .fontColor("#CCC")
            .decoration({type:TextDecorationType.LineThrough})

          Text("折扣价：¥" + (item.price - item.discount))
            .priceText()
          Text("补贴：¥" + item.discount)
            .priceText()
        } else {
          Text("¥" + item.price)
            .priceText()
        }
      }
      .height("100%")
      .alignItems(HorizontalAlign.Start)
    }
    .width("100%")
    .backgroundColor("#fff")
    .borderRadius(20)
    .height(120)
    .padding(10)
  }
}

// @Entry
// @Component
// struct Index {
// @State message: string = "hello"
// @State imageWidth: number = 30

// build() {
// Column() {
//   Row(){
//     Text(this.message)
//       .fontSize(50)
//       .fontWeight(FontWeight.Bold)
//       .onClick(() =>{
//         this.message = "hhhhh"
//       })
//   }
//   .width('100%')
//   .justifyContent(FlexAlign.Center)
//
//   Row(){
//     // Image("https://copyright.bdstatic.com/vcg/creative/cc9c744cf9f7c864889c563cbdeddce6.jpg@h_1280")
//     //   .width(250)
//     Image($r("app.media.icon"))
//       .width(this.imageWidth)
//       .interpolation(ImageInterpolation.High)
//   }
//   .width('100%')
//   .height(400)
//   .justifyContent(FlexAlign.Center)
//
//   Row(){
//     Text('图片宽度')
//       .fontSize(20)
//
//     TextInput({placeholder:"请输入图片宽度",text:this.imageWidth.toFixed(0)})
//       .width(250)
//       .backgroundColor("#36D")
//         // .type(InputType.Password)
//       .onChange(value=>{
//         console.log(value)
//         this.imageWidth = parseInt(value)
//       })
//   }
//   .width('100%')
//   .padding({left:20,right:20})
//   .justifyContent(FlexAlign.SpaceBetween)
//
//   Row(){
//     Button('放大')
//       .width(80)
//       .fontSize(20)
//       .onClick(() =>{
//         this.imageWidth = this.imageWidth <=300? this.imageWidth + 10 : this.imageWidth
//       })
//
//     Button("缩小")
//       .width(80)
//       .fontSize(20)
//       .onClick(() =>{
//         this.imageWidth = this.imageWidth >=10? this.imageWidth - 10 : this.imageWidth
//       })
//   }
//   .width('100%')
//   .margin({top:15,bottom:15})
//   .justifyContent(FlexAlign.SpaceEvenly)
//
//   Slider({
//     min:100,
//     max:200,
//     value:this.imageWidth,
//     step:10
//   })
//     .width("90%")
//     .trackThickness(10)
//     .showTips(true)
//     .blockColor('#36d')
//     .onChange(value =>{
//       this.imageWidth = value
//     })
// }
// .width('100%')
// .height('100%')
//   }
// }