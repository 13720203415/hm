import router from '@ohos.router'
class RouterInfo {
  url:string
  title:string

  constructor(url:string,title:string) {
    this.url = url
    this.title = title
  }
}

const  routers: RouterInfo[] = [
  new RouterInfo("pages/APage","任务进度页面"),
  new RouterInfo("pages/ListPage","商品列表页面"),
  new RouterInfo("pages/AnimationPage","小鱼动画"),
  new RouterInfo("pages/DocumentListPage","文档列表")
]

@Entry
@Component
struct Index {
  @State message:string = "页面列表"
  build(){
    Column(){
      Text(this.message)
        .fontSize(50)
        .width("100%")
        .height(80)
        .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)

      List({space:10}){
        ForEach(
          routers,
          (r,index) =>{
            ListItem(){
              this.RouterItem(r,index+1)
            }
          }
        )
      }
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
      .width("100%")
    }
    .width("100%")
    .height("100%")
  }

  @Builder RouterItem(r:RouterInfo,index:number) {
    Row(){
      Text(index + ".")
        .fontSize(20)
        .fontColor(Color.White)
      Blank()
      Text(r.title)
        .fontSize(20)
        .fontColor(Color.White)
    }
    .width("90%")
    .padding(15)
    .backgroundColor("#38f")
    .borderRadius(20)
    .shadow({radius:6,color:"#4f000000",offsetX:4,offsetY:2})
    .onClick(()=>{
      router.pushUrl({
        url:r.url,
        params:{
          id:index
        }
      },
        router.RouterMode.Single,
        err=>{
          if(err) {
            console.log(`路由失败,errcode:${err.code},errorMessage:${err.message}`)
          }
        })
    })
  }
}