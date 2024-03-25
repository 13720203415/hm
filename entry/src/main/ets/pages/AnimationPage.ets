import router from '@ohos.router'

@Entry
@Component
struct AnimationPage{

  @State src: Resource = $r("app.media.fish")
  @State fishX: number = 200
  @State fishY: number = 180
  @State angle:number = 0
  @State isBegin:boolean = false

  build(){
    Row(){
      Stack(){
        Button("返回")
          .position({x:1,y:0})
          .backgroundColor("#20101010")
          .onClick(() =>{
            router.back()
          })

        if(!this.isBegin) {
          Button("开始游戏")
            .onClick(()=>{
              this.isBegin = true
            })
        } else {
          Image(this.src)
            .position({
              x:this.fishX -20,
              y:this.fishY -20
            })
            .rotate({angle:this.angle,centerX:"50%",centerY:"50%"})
            .width(40)
            .height(40)
          .animation({
            duration:500
          })
        }
        //操作按钮
        Row(){
          Button("←").backgroundColor("#20101010")
          .onClick(()=>{
            this.fishX -=20
            this.src = $r("app.media.fish_rev")
          })
          Column({space:40}){
            Button("↑").backgroundColor("#20101010")
            .onClick(()=>{
              this.fishY -=20
            })
            Button("↓").backgroundColor("#20101010")
            .onClick(()=>{
              this.fishY +=20
            })
          }
          Button("→").backgroundColor("#20101010")
          .onClick(()=>{
            this.fishX +=20
            this.src = $r("app.media.fish")
          })
        }
        .height(240)
        .width(240)
        .justifyContent(FlexAlign.Center)
        .position({x:0,y:120})
      }
      .width("100%")
      .height("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundImage($r("app.media.sea"))
    .backgroundImageSize({height: '105%', width: '100%'})
  }
}