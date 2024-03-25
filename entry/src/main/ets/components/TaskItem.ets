import { Task } from '../pages/APage'
@Component
export struct TaskItem{
  @ObjectLink item:Task
  //定义一个要传递的函数的名字
  onTaskChange: ()=> void

  build(){
    Row(){
      if(this.item.isFinished) {
        Text(this.item.name)
          .fontSize(20)
          .finishedTask()
      } else {
        Text(this.item.name)
          .fontSize(20)
      }

      Checkbox()
        .select(this.item.isFinished)
        .onChange(val =>{
          this.item.isFinished = val;
          //在需要使用的地方调用就可以
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
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