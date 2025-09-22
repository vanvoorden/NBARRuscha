//
//  Copyright © 2021 North Bronson Software
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import NBARKit
import SwiftUI

@main
struct NBARRuschaApp : App {
  @StateObject private var model = NBARRuschaDataModel()
  
  var body: some Scene {
    WindowGroup {
      NBARRuschaContentView(
        model: self.model
      )
    }
  }
}

extension Bundle {
  var navigationTitle: String {
    return ((self.infoDictionary?["CFBundleDisplayName"] as? String ?? "") + " " + (self.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))
  }
}

private struct NBARRuschaLaunchView : View {
  var body: some View {
    ScrollView {
      HStack {
        VStack(
          alignment: .leading
        ) {
          Text("Tap the Photo icon to begin your AR experience.\n")
          Text("The app will download the locations of the photos you requested.\n")
          Text("The app needs to determine your location before placing your photos in AR. You will be asked to enable Location Services. Enabling Wi-Fi can help the app determine a more accurate location.\n")
          Text("The app will activate your camera when your photos are ready. You should already be standing on the street where you are planning to view your photos.\n")
          Text("The app will use your surroundings to help place your photos. You can slowly sweep your device around and point your device at nearby buildings. Please remain patient while your device collects accurate location data. Pointing your device to the ground can slow the process down. Keep your camera pointed up and try to scan for the shapes of the buildings you see on the street.\n")
          Text("The app will place your photos in AR when your device has determined an accurate location. You can adjust settings for height and altitude to help match the architecture of the historical photos with what you see in the present day. You can also adjust the transparency of the photos to see exactly how things have changed since those photos were taken.\n")
          Text("Tap the camera view to hide your photo settings. Tap again to hide your app navigation bar. Tap again to see your photo settings and your app navigation bar.\n")
          Text("Most photos are best viewed from across the street. If you are standing on the South Side of Sunset Blvd, point your camera to the North Side. If you are standing on the North Side of Hollywood Blvd, point your camera to the South Side.\n")
          Text("Thanks.\n")
        }
        Spacer()
      }.padding()
    }
  }
}

struct NBARRuschaContentView : View {
  @ObservedObject private var model: NBARRuschaDataModel
  
  @State private var isEditing = true
  @State private var isNavigationBarHidden = false
  @State private var isSheetPresented = false
  
  @State private var title = ""
  
  var body: some View {
    NavigationView {
      Group {
        if self.model.anchors.count == 0 {
          NBARRuschaLaunchView(
          ).navigationTitle(
            Bundle.main.navigationTitle
          ).onTapGesture {
            self.isSheetPresented.toggle()
          }
        } else {
          NBARPhotosView(
            model: self.model,
            isEditing: self.isEditing
          ).edgesIgnoringSafeArea(
            .all
          ).navigationBarTitleDisplayMode(
            .inline
          ).navigationTitle(
            self.title
          ).onTapGesture {
            if self.isNavigationBarHidden {
              self.isNavigationBarHidden.toggle()
              self.isEditing.toggle()
            } else {
              if self.isEditing {
                self.isEditing.toggle()
              } else {
                self.isNavigationBarHidden.toggle()
              }
            }
          }
        }
      }.navigationBarHidden(
        self.isNavigationBarHidden
      ).sheet(
        isPresented: self.$isSheetPresented
      ) {
        NBARRuschaPicker(
          didFinishPicking: { title, results in
            self.title = title ?? ""
            self.model.parseResults(results)
            self.isSheetPresented.toggle()
          }
        )
      }.statusBar(
        hidden: self.isNavigationBarHidden
      ).toolbar {
        ToolbarItem(
          placement: .navigationBarLeading
        ) {
          Button(
            action: {
              self.isEditing.toggle()
            }
          ) {
            Label("Info", systemImage: "info.circle")
          }.disabled(
            self.model.anchors.count == 0
          )
        }
        ToolbarItem(
          placement: .navigationBarTrailing
        ) {
          Button(
            action: {
              self.isSheetPresented.toggle()
            }
          ) {
            Label("Photo", systemImage: "photo")
          }
        }
      }
    }.navigationViewStyle(
      StackNavigationViewStyle()
    )
  }
  
  init(model: NBARRuschaDataModel) {
    self.model = model
  }
}

struct NBARRuschaContentViewPreviews : PreviewProvider {
  static var previews: some View {
    NBARRuschaContentView(
      model: NBARRuschaDataModel()
    )
  }
}
