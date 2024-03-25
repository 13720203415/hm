import router from '@ohos.router'
@Component
export struct Header{
  private title:string
  @State params :any = router.getParams()
  build(){
    Row(){
      Image($r("app.media.back"))
        .width(30)
      .onClick(() => {
        router.showAlertBeforeBackPage({
          message:"确认返回吗？"
        })
        router.back()
      })
      if(this.params && this.title) {
        Text(this.params.id + "." + this.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      Image($r("app.media.refresh"))
        .width(30)
    }
    .width("100%")
    .height(30)
  }
}