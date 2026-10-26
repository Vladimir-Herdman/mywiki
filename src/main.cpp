#include <iostream>
#include <string>
#include <thread>
#include "webview/webview.h" // IWYU pragma: keep
#include "httplib/httplib.h"


int main() {
    httplib::Server svr;

    if (!svr.set_mount_point("/", "./html") && !svr.set_mount_point("/", "src/html")) {
        std::cout << "html dir doesn't exist" << std::endl;
        return 1;
    }

    const int port = svr.bind_to_any_port("127.0.0.1");
    std::cout << "Listening on port " << port << "..." << std::endl;
    std::thread server([&] { svr.listen_after_bind(); });

    webview::webview w(false, nullptr);
    w.set_title("Basic Example");
    w.set_size(480, 320, WEBVIEW_HINT_NONE);
    w.navigate("http://localhost:" + std::to_string(port));
    w.run();

    svr.stop();
    server.join();

    return 0;
}
