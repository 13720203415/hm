export var id:number = 1
@Observed
export class Task{
  //任务名称
  name:string = `任务${id++}`
  //任务状态是否完成
  isFinished:boolean= false
}

export class StatInfo{
  totalTask: number = 0
  finishedTask : number = 0
}

import {TaskStatistics} from "../components/TaskStatistics"
import {TaskList} from "../components/TaskList"
import {Header} from "../components/Header"

@Entry
@Component
struct APage {
  // //总任务数
  // @State totalTask: number = 0
  // //已完成任务数
  // @State finishedTask : number = 0

  // @State stat: StatInfo = new StatInfo()

  @Provide stat: StatInfo = new StatInfo()

  build(){
    Column({space:10}) {
      Header({title:"任务进度"})
        .margin({bottom:20})

      //任务进度卡片
      // TaskStatistics({finishedTask:this.finishedTask,totalTask:this.totalTask})
      // TaskStatistics({finishedTask:$finishedTask,totalTask:$totalTask})

      // TaskStatistics({finishedTask:this.stat.finishedTask,totalTask:this.stat.totalTask})
      TaskStatistics()
      //任务列表
      //   TaskList({stat:$stat})
      //     .layoutWeight(1)
      TaskList()
        .layoutWeight(1)

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f2f3")
  }
}