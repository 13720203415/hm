import {Task} from "../pages/APage"
import {id} from "../pages/APage"
import {StatInfo} from "../pages/APage"
import {TaskItem} from "../components/TaskItem"
@Component
export struct TaskList{
  @State task: Task[] = []
  // @Link totalTask: number
  // @Link finishedTask: number
  // @Link stat: StatInfo

  @Consume stat: StatInfo

  build(){
    Column(){
      //新增任务按钮
      Button("新增任务")
        .width(200)
        .onClick(()=>{
          console.log("ids:" + id)
          this.task.push(new Task())
          this.handleTaskChange()
        })
      .margin(10)

      //任务列表
      List({space:10}){
        ForEach(
          this.task,
          (item:Task,index) =>{
            ListItem(){
              TaskItem({item:item,onTaskChange:this.handleTaskChange.bind(this)})
              // Row(){
              //   if(item.isFinished) {
              //     Text(item.name)
              //       .fontSize(20)
              //       .finishedTask()
              //   } else {
              //     Text(item.name)
              //       .fontSize(20)
              //   }
              //
              //   Checkbox()
              //     .select(item.isFinished)
              //     .onChange(val =>{
              //         item.isFinished = val;
              //         this.handleTaskChange()
              //     })
              // }
              // .card()
              // .justifyContent(FlexAlign.SpaceBetween)
            }
            .swipeAction({end:this.deleteButton(index)})
          }
        )
      }
      .width("100%")
      .alignListItem(ListItemAlign.Center)
    }
  }


  handleTaskChange() {
    this.stat.finishedTask = this.task.filter(it => {
      return it.isFinished
    }).length
    this.stat.totalTask = this.task.length
  }

  @Builder deleteButton(index:number) {
    Button(){
      Image($r("app.media.delete"))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .backgroundColor(Color.Red)
    .type(ButtonType.Circle)
    .margin(5)
    .onClick(() =>{
      this.task.splice(index,1)
      // this.finishedTask = this.task.filter(it => it.isFinished).length
      // this.totalTask = this.task.length
      this.handleTaskChange()
    })
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

@Extend(Text) function finishedTask() {
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor("#b1b2b1")
}
