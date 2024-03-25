import {StatInfo} from "../pages/APage"
@Component
export struct TaskStatistics {
  // @Prop finishedTask : number
  // @Prop totalTask : number

  // @Link finishedTask : number
  // @Link totalTask : number

  @Consume stat: StatInfo
  build(){
    //任务进度卡片
    Row(){
      Text("任务进度: ")
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack(){
        Progress({
          value:this.stat.finishedTask,
          total:this.stat.totalTask,
          type:ProgressType.Ring
        })
          .width(100)
        Row(){
          Text(this.stat.finishedTask.toString())
            .fontSize(24)
            .fontColor("#36d")
          Text("/" + this.stat.totalTask)
            .fontSize(24)
        }
      }
    }
    .card()
    .margin({top:20,bottom:10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

//统一的卡片样式
@Styles function card() {
  .width("95%")
  .padding(20)
  .backgroundColor("#fff")
  .borderRadius(15)
  .shadow({radius:6,color:"#1f000000",offsetX:2,offsetY:4})
}