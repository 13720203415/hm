import router from '@ohos.router'
import { Event } from '@ohos.worker'
import curves from '@ohos.curves'

@Entry
@Component
struct AnimationPage{

  @State src: Resource = $r("app.media.fish")
  @State fishX: number = 200
  @State fishY: number = 180
  @State angle:number = 0
  @State isBegin:boolean = false

  //大小圆半径
  private maxRadius : number = 100
  private minRadius : number = 20

  //中心位置
  private centerX: number = 120
  private centerY: number = 120

  //摇杆小圆位置
  @State positionX : number = this.centerX
  @State positionY : number = this.centerY

  //正余弦
  sin : number = 0
  cos : number = 0

  //小鱼移动速度
  speed: number = 5
  //任务id
  taskId: number = -1

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
              animateTo(
                {duration:1000},
                ()=>{
                this.isBegin = true
                }
              )
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
            .transition({
              type:TransitionType.Insert,
              opacity:0,
              translate:{x:-250}
            })
        }
        //操作按钮
        Row(){
          // Button("←").backgroundColor("#20101010")
          // .onClick(()=>{
          //   this.fishX -=20
          //   this.src = $r("app.media.fish_rev")
          // })
          // Column({space:40}){
          //   Button("↑").backgroundColor("#20101010")
          //   .onClick(()=>{
          //     this.fishY -=20
          //   })
          //   Button("↓").backgroundColor("#20101010")
          //   .onClick(()=>{
          //     this.fishY +=20
          //   })
          // }
          // Button("→").backgroundColor("#20101010")
          // .onClick(()=>{
          //   this.fishX +=20
          //   this.src = $r("app.media.fish")
          // })
            Circle({ width:this.maxRadius*2,height:this.maxRadius*2, })
              .fill("#20101010")
              .position({x:this.centerX-this.maxRadius,y:this.centerY-this.maxRadius})

            Circle({ width:this.minRadius*2,height:this.minRadius*2, })
              .fill("#403A3A3A")
              .position({x:this.positionX-this.minRadius,y:this.positionY-this.minRadius})
        }
        .height(240)
        .width(240)
        .justifyContent(FlexAlign.Center)
        .position({x:0,y:120})
        .onTouch(this.handleTouchEvent.bind(this))
      }
      .width("100%")
      .height("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundImage($r("app.media.sea"))
    .backgroundImageSize({height: '105%', width: '100%'})
  }


  handleTouchEvent(event:TouchEvent) {
    switch (event.type) {
      case TouchType.Up:
        clearInterval(this.taskId)
        animateTo(
          {curve:curves.springMotion()},
          ()=>{
              this.positionX = this.centerX
              this.positionY = this.centerY
              this.angle = 0
          }
        )
         break
      case TouchType.Down:
        this.taskId = setInterval(()=>{
            this.fishX += this.speed * this.cos
            this.fishY += this.speed * this.sin
          },40)
        break
      case TouchType.Move:
      //获取手指位置坐标
        let x = event.touches[0].x
        let y = event.touches[0].y
      //计算手指与中心点的坐标差值
        let vx = x - this.centerX
        let vy = y - this.centerY
      //计算手指与中心点连线夹角，单位是弧度
        let angle = Math.atan2(vy,vx)
      //计算手指与中心点距离
        let distance = this.getDistance(vx,vy)
        this.sin = Math.sin(angle)
        this.cos = Math.cos(angle)
        if(Math.abs(angle *2) <= Math.PI) {
          this.src = $r("app.media.fish")
        } else {
          this.src = $r("app.media.fish_rev")
          angle = angle<0?angle + Math.PI : angle - Math.PI
        }
        console.log(`angle:${angle}`)
        this.angle = angle *180/Math.PI
        console.log(`this.angle:${this.angle}`)
        animateTo(
          {curve:curves.responsiveSpringMotion()},
          ()=>{
            //计算小球的位置
            this.positionX =this.centerX + distance * this.cos
            this.positionY = this.centerY + distance * this.sin
          }
        )
        break
    }
  }

  getDistance(x:number,y:number) {
    let d = Math.sqrt(x*x + y*y)
    return Math.min(d,this.maxRadius)
  }
}