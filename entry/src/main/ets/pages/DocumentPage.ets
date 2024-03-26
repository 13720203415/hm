import common from '@ohos.app.ability.common'
import {Header} from "../components/Header"
import Want from '@ohos.app.ability.Want'

@Entry
@Component
struct DocumentPage {
  @State editTitle : boolean = true
  @State title:string ="标题"
  @State content: string =""

  private context = getContext(this) as common.UIAbilityContext

  build() {
    Row(){
      Column({space:10}){
        Row({space:10}) {
          Image($r("app.media.back")).width(40)
            .onClick(()=>{
              //跳转的目的地want
              let want:Want = {
                deviceId:"", //为空代表当前设备
                bundleName:"com.example.hm",
                moduleName:"entry",
                abilityName:"EntryAbility"
              }
              //跳转
              this.context.startAbility(want)
            })

          if (!this.editTitle) {
            Text(this.title)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .onClick(() => this.editTitle = true)
          } else {
            TextInput({
              placeholder: '请输入标题',
              text: this.title
            })
              .layoutWeight(1)
              .onChange(val => this.title = val)
            Button('确定')
              .onClick(() => this.editTitle = false)
          }
        }
        .width('100%')

        Divider()
        TextArea({
          placeholder: '请输入文档内容',
          text: this.content
        })
          .layoutWeight(1)
          .onChange(val => this.content = val)
      }
      .width("100%")
      .height('100%')
    }
    .padding(10)
    .width('100%')
    .height('100%')
  }
}