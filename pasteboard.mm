#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#include <napi.h>

Napi::Buffer<uint8_t> Get(const Napi::CallbackInfo &info) {
  std::vector<uint8> data;

  // 字符串类型
  // TODO: PNG
  NSData *pasteboard_data = [NSPasteboard.generalPasteboard dataForType:NSPasteboardTypeString];

  // NSData -> uint8t
  const uint8_t *bytes = (uint8_t *)[pasteboard_data bytes];

  // 使用bytes 填充 data
  data.assign(bytes, bytes + [pasteboard_data length]);

  // 转换成 Node Buffer
  return Napi::Buffer<uint8_t>::Copy(info.Env(), &data[0], data.size());
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
  exports.Set(Napi::String::New(env, "Get"), Napi::Function::New(env, Get));
  return exports;
}

NODE_API_MODULE(notch, Init)
