import common from '@ohos.app.ability.common'
import {Header} from "../components/Header"
import Want from '@ohos.app.ability.Want'

@Entry
@Component
struct DocumentListPage {
  private index:number = 1
  @State docs: number[] = []

  private context = getContext(this) as common.UIAbilityContext

  build() {
    Column({space:10}){
        Header({title:"文档列表"})
        Divider()
        Button("新建列表")
          .onClick(()=>{
            this.docs.push(this.index)
            //跳转到文档编辑的页面

            //跳转的目的地want
            let want:Want = {
              deviceId:"", //为空代表当前设备
              bundleName:"com.example.hm",
              moduleName:"entry",
              abilityName:"DocumentAbility",
              parameters:{
                instanceKey: "idx_" + this.index++
              }
            }
            //跳转
            this.context.startAbility(want)
          })

        ForEach(
          this.docs,id =>{
          Row({space:10}){
            Image($r("app.media.files_doc")).width(20)
            Text(`文档${id}`).fontSize(18)
              .onClick(()=>{
                //跳转到文档编辑的页面

                //跳转的目的地want
                let want:Want = {
                  deviceId:"", //为空代表当前设备
                  bundleName:"com.example.hm",
                  moduleName:"entry",
                  abilityName:"DocumentAbility",
                  parameters:{
                    instanceKey: "idx_" + id
                  }
                }
                //跳转
                this.context.startAbility(want)
              })
          }
        }
        )
      }
    .width("100%")
    .height('100%')
  }
}