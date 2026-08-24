import ElementaryUI
import JavaScriptEventLoop

@main
struct App {
  static func main() {
    JavaScriptEventLoop.installGlobalExecutor()

    Application(ContentView())
      .mount(in: .body)
  }
}
