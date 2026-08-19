import ElementaryUI
import JavaScriptEventLoop

@main
struct App {
  static func main() {
    JavaScriptEventLoop.installGlobalExecutor()
    let app = Application(ContentView())
    app.mount(in: .body)
  }
}
