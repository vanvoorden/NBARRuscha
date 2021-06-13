//
//  NBARRuschaPicker.swift
//  NBARRuscha
//
//  Copyright © 2021 North Bronson Software
//
//  This Item is protected by copyright and/or related rights. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use. In addition, no permission is required from the rights-holder(s) for scholarly, educational, or non-commercial uses. For other uses, you need to obtain permission from the rights-holder(s).
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Combine
import CoreLocation
import SwiftUI

private let NBARRuschaPickerArray = [
  NBARRuschaPickerSectionDataModel(
    title: "Hollywood Blvd",
    id: UUID(),
    rows: [
      NBARRuschaPickerRowDataModel(
        title: "Hollywood Blvd 1973",
        subtitle: "4,293 digitized items",
        id: "a93883f1-ae71-491b-a795-7f7d436c217a"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Hollywood Blvd 2010",
        subtitle: "7,643 digitized items",
        id: "9a717363-ade5-4cc8-8c7e-eb34a5871b15"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Hollywood Blvd 2010",
        subtitle: "3,838 digitized items",
        id: "10c19903-e59a-461e-a5d9-35dc21206521"
      ),
    ]
  ),
  NBARRuschaPickerSectionDataModel(
    title: "Sunset Blvd",
    id: UUID(),
    rows: [
      //      NBARRuschaPickerRowDataModel(
      //        title: "Sunset Blvd 1965",
      //        subtitle: "788 digitized items",
      //        id: "64ec82f4-d641-4ee7-9b44-449e402f782c"
      //      ),
      //      NBARRuschaPickerRowDataModel(
      //        title: "Sunset Blvd 1966",
      //        subtitle: "1,029 digitized items",
      //        id: "cb948d98-91c6-4f07-bb9d-72ea9c10279d"
      //      ),
      //      //  NO LOCATION DATA. :(
      //      NBARRuschaPickerRowDataModel(
      //        title: "Sunset Blvd 1966",
      //        subtitle: "6,540 digitized items",
      //        id: "ae3bc7ed-5cf3-405f-9de9-7f4224513b99"
      //      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 1973",
        subtitle: "7,271 digitized items",
        id: "b4a4882d-9f8d-4359-9234-6b236b2340e3"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 1974",
        subtitle: "8,218 digitized items",
        id: "f1b1fff9-310f-4afc-b157-5d3d6a22a6a6"
      ),
      //      NBARRuschaPickerRowDataModel(
      //        title: "Sunset Blvd 1976",
      //        subtitle: "1,787 digitized items",
      //        id: "ea08b3ad-916c-431b-8d0e-6bd3abf1b484"
      //      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 1985",
        subtitle: "6,317 digitized items",
        id: "d4583048-9fa7-4622-9cad-25b610c940ee"
      ),
      //      //  IMAGES ARE POINTING 180 DEGREES THE WRONG WAY. :(
      //      NBARRuschaPickerRowDataModel(
      //        title: "Sunset Blvd 1990",
      //        subtitle: "6,023 digitized items",
      //        id: "ccb54cf9-9e19-4f2f-9a57-cdc41e2145d3"
      //      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 1995",
        subtitle: "7,692 digitized items",
        id: "616681dd-ee9e-4ad3-b634-54b7f0ec09a2"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 1997",
        subtitle: "8,221 digitized items",
        id: "83b90c40-d00f-4cc3-9a80-0fcf5f6665d4"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 1998",
        subtitle: "4,321 digitized items",
        id: "997413b5-3550-4feb-b7ac-24499bb8182f"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 2007",
        subtitle: "7,643 digitized items",
        id: "25924e1e-be29-4c9f-9192-3cb0fd11ab26"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Sunset Blvd 2007",
        subtitle: "7,893 digitized items",
        id: "07b69de7-f404-4402-ac5a-3ca805ab366a"
      ),
    ]
  ),
  NBARRuschaPickerSectionDataModel(
    title: "Santa Monica Blvd",
    id: UUID(),
    rows: [
      NBARRuschaPickerRowDataModel(
        title: "Santa Monica Blvd 1974",
        subtitle: "4,959 digitized items",
        id: "085c6ebc-fce9-40d8-88e3-c9e0626b11ce"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Santa Monica Blvd 2007",
        subtitle: "4,525 digitized items",
        id: "e72ea5a5-241a-4ae0-a290-551755b87fae"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Santa Monica Blvd 2007",
        subtitle: "4,558 digitized items",
        id: "7846f644-f7a7-4189-895d-bc020d5d26d3"
      ),
    ]
  ),
  NBARRuschaPickerSectionDataModel(
    title: "Melrose Ave",
    id: UUID(),
    rows: [
      NBARRuschaPickerRowDataModel(
        title: "Melrose Ave 1975",
        subtitle: "3,725 digitized items",
        id: "3944f7e5-c0a1-42ea-b8c4-8c0626daca16"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Melrose Ave 2007",
        subtitle: "2,600 digitized items",
        id: "1e66719b-9283-4fe5-9e2f-b15fa34e930d"
      ),
      NBARRuschaPickerRowDataModel(
        title: "Melrose Ave 2007",
        subtitle: "2,272 digitized items",
        id: "94721c03-d8fd-4c90-8155-07e99abaee58"
      ),
    ]),
]

private let NBARRuschaPickerDictionary = ["ea08b3ad-916c-431b-8d0e-6bd3abf1b484": ["title": "Sunset Blvd 1976", "subtitle": "1,787 digitized items"], "07b69de7-f404-4402-ac5a-3ca805ab366a": ["title": "Sunset Blvd 2007", "subtitle": "7,893 digitized items"], "cb948d98-91c6-4f07-bb9d-72ea9c10279d": ["subtitle": "1,029 digitized items", "title": "Sunset Blvd 1966"], "b4a4882d-9f8d-4359-9234-6b236b2340e3": ["subtitle": "7,271 digitized items", "title": "Sunset Blvd 1973"], "10c19903-e59a-461e-a5d9-35dc21206521": ["subtitle": "3,838 digitized items", "title": "Hollywood Blvd 2010"], "3944f7e5-c0a1-42ea-b8c4-8c0626daca16": ["title": "Melrose Ave 1975", "subtitle": "3,725 digitized items"], "616681dd-ee9e-4ad3-b634-54b7f0ec09a2": ["subtitle": "7,692 digitized items", "title": "Sunset Blvd 1995"], "a93883f1-ae71-491b-a795-7f7d436c217a": ["title": "Hollywood Blvd 1973", "subtitle": "4,293 digitized items"], "9a717363-ade5-4cc8-8c7e-eb34a5871b15": ["subtitle": "7,643 digitized items", "title": "Hollywood Blvd 2010"], "d4583048-9fa7-4622-9cad-25b610c940ee": ["title": "Sunset Blvd 1985", "subtitle": "6,317 digitized items"], "94721c03-d8fd-4c90-8155-07e99abaee58": ["title": "Melrose Ave 2007", "subtitle": "2,272 digitized items"], "7846f644-f7a7-4189-895d-bc020d5d26d3": ["subtitle": "4,558 digitized items", "title": "Santa Monica Blvd 2007"], "997413b5-3550-4feb-b7ac-24499bb8182f": ["subtitle": "4,321 digitized items", "title": "Sunset Blvd 1998"], "1e66719b-9283-4fe5-9e2f-b15fa34e930d": ["title": "Melrose Ave 2007", "subtitle": "2,600 digitized items"], "25924e1e-be29-4c9f-9192-3cb0fd11ab26": ["subtitle": "7,643 digitized items", "title": "Sunset Blvd 2007"], "64ec82f4-d641-4ee7-9b44-449e402f782c": ["title": "Sunset Blvd 1965", "subtitle": "788 digitized items"], "085c6ebc-fce9-40d8-88e3-c9e0626b11ce": ["title": "Santa Monica Blvd 1974", "subtitle": "4,959 digitized items"], "ccb54cf9-9e19-4f2f-9a57-cdc41e2145d3": ["title": "Sunset Blvd 1990", "subtitle": "6,023 digitized items"], "ae3bc7ed-5cf3-405f-9de9-7f4224513b99": ["subtitle": "6,540 digitized items", "title": "Sunset Blvd 1966"], "83b90c40-d00f-4cc3-9a80-0fcf5f6665d4": ["subtitle": "8,221 digitized items", "title": "Sunset Blvd 1997"], "f1b1fff9-310f-4afc-b157-5d3d6a22a6a6": ["title": "Sunset Blvd 1974", "subtitle": "8,218 digitized items"], "e72ea5a5-241a-4ae0-a290-551755b87fae": ["subtitle": "4,525 digitized items", "title": "Santa Monica Blvd 2007"]]

private struct NBARRuschaPickerRowDataModel : Identifiable {
  //  MARK: -
  let title: String
  let subtitle: String
  let id: String
}

//  MARK: -

private struct NBARRuschaPickerSectionDataModel : Identifiable {
  //  MARK: -
  let title: String
  let id: UUID
  let rows: Array<NBARRuschaPickerRowDataModel>
}

//  MARK: -

private struct NBARRuschaPickerRow : View {
  //  MARK: -
  private let model: NBARRuschaPickerRowDataModel
  
  private var downloading: Bool
  private var progress: Double
  
  var body: some View {
    VStack(
      alignment: .leading,
      spacing: 4.0
    ) {
      Text(
        self.model.title
      ).font(
        .headline
      ).foregroundColor(
        .primary
      )
      ZStack(
        alignment: .leading
      ) {
        Text(
          self.model.subtitle
        ).font(
          .subheadline
        ).foregroundColor(
          .secondary
        ).opacity(
          self.downloading ? 0.0 : 1.0
        )
        ProgressView(
          value: self.progress
        ).opacity(
          self.downloading ? 1.0 : 0.0
        )
      }
    }.padding(
      .vertical,
      8.0
    )
  }
  
  //  MARK: -
  
  init(model: NBARRuschaPickerRowDataModel, downloading: Bool, progress: Double) {
    self.model = model
    self.downloading = downloading
    self.progress = progress
  }
}

//  MARK: -

private struct NBARRuschaPickerAboutRow : View {
  //  MARK: -
  private let text: String
  
  var body: some View {
    ZStack(
      alignment: .leading
    ) {
      Color(.systemBackground)
      HStack {
        Text(self.text)
        Spacer()
        Image(systemName: "safari")
      }.foregroundColor(
        .accentColor
      )
    }.padding(
      .vertical,
      8.0
    )
  }
  
  //  MARK: -
  
  init(text: String) {
    self.text = text
  }
}

//  MARK: -

private struct NBARRuschaPickerAboutSheet : View {
  //  MARK: -
  @Binding private var url: URL?
  @Binding private var isSheetPresented: Bool
  
  var body: some View {
    if let url = self.url {
      NBARRuschaWebView(url: url)
    } else {
      Color(
        .systemBackground
      ).onTapGesture {
        self.isSheetPresented.toggle()
      }
    }
  }
  
  //  MARK: -
  
  init(url: Binding<URL?>, isSheetPresented: Binding<Bool>) {
    self._url = url
    self._isSheetPresented = isSheetPresented
  }
}

//  MARK: -

private struct NBARRuschaPickerThanksRow : View {
  //  MARK: -
  private let text: String
  
  var body: some View {
    HStack {
      Spacer()
      Text(self.text)
      Spacer()
    }.padding(
      .vertical,
      8.0
    )
  }
  
  //  MARK: -
  
  init(text: String) {
    self.text = text
  }
}

//  MARK: -

struct NBARRuschaPickerResult {
  //  MARK: -
  let id: UUID
  let altitude: CLLocationDistance?
  let coordinate: CLLocationCoordinate2D
  let course: CLLocationDirection
  let image: String
  let pixelHeight: Int?
  let pixelWidth: Int?
}

//  MARK: -

struct NBARRuschaPicker : View {
  //  MARK: -
  private let didFinishPicking: (String?, Array<NBARRuschaPickerResult>) -> Void
  
  @StateObject private var model = NBARRuschaPickerDataModel.shared
  
  @State private var selection: String?
  
  @State private var didAdd = false
  @State private var didDismiss = false
  @State private var isSheetPresented = false
  @State private var url: URL?
  
  @Environment(\.scenePhase) private var scenePhase
  
  var body: some View {
    NavigationView {
      List(
        selection: self.$selection
      ) {
        ForEach(
          NBARRuschaPickerArray
        ) { section in
          Section(
            header: Text(section.title)
          ) {
            ForEach(
              section.rows
            ) { row in
              NBARRuschaPickerRow(
                model: row,
                downloading: self.model.downloadingDictionary[row.id, default: false],
                progress: self.model.progressDictionary[row.id, default: 0.0]
              )
            }
          }
          
        }
        Section(
          header: Text("About")
        ) {
          NBARRuschaPickerAboutRow(
            text: "Ed Ruscha"
          ).onTapGesture {
            self.url = URL(string: "https://edruscha.com/")
            self.isSheetPresented.toggle()
          }
          NBARRuschaPickerAboutRow(
            text: "Yo Yo! It's Getty!"
          ).onTapGesture {
            self.url = URL(string: "https://www.getty.edu/research/")
            self.isSheetPresented.toggle()
          }
          NBARRuschaPickerAboutRow(
            text: "North Bronson Software"
          ).onTapGesture {
            self.url = URL(string: "https://www.github.com/vanvoorden/")
            self.isSheetPresented.toggle()
          }
          NBARRuschaPickerThanksRow(
            text: "Thanks"
          )
        }
      }.environment(\.editMode, .constant(.active)
      ).navigationTitle(
        "Ruscha AR 0.2"
      ).sheet(
        isPresented: self.$isSheetPresented
      ) {
        NBARRuschaPickerAboutSheet(
          url: self.$url,
          isSheetPresented: self.$isSheetPresented
        )
      }.toolbar {
        ToolbarItem(
          placement: .cancellationAction
        ) {
          Button(
            "Cancel",
            action: {
              self.didDismiss = true
              self.didFinishPicking(nil, [])
            }
          )
        }
        ToolbarItem(
          placement: .confirmationAction
        ) {
          Button(
            "Add",
            action: {
              if let selection = self.selection {
                self.didAdd = true
                self.model.request(for: selection) { results, error in
                  if self.isSheetPresented == false {
                    if self.didDismiss == false {
                      self.didDismiss = true
                      let title = NBARRuschaPickerDictionary[selection]?["title"]
                      self.didFinishPicking(title, results)
                    }
                  } else {
                    self.didAdd = false
                  }
                }
              }
            }
          ).disabled(
            self.selection == nil || self.didAdd == true || self.model.downloadingDictionary.count != 0
          )
        }
      }
    }.navigationViewStyle(
      StackNavigationViewStyle()
    ).onChange(
      of: self.scenePhase
    ) { scenePhase in
      //  TODO: LOCAL NOTIFICATION WHEN DOWNLOAD COMPLETES
    }
  }
  
  //  MARK: -
  
  init(didFinishPicking: @escaping (String?, Array<NBARRuschaPickerResult>) -> Void) {
    self.didFinishPicking = didFinishPicking
  }
}

//  MARK: -

private func ParseJSON(_ json: Any?, completionHandler: @escaping (Array<NBARRuschaPickerResult>) -> Void) {
  DispatchQueue.global().async {
    var results = Array<NBARRuschaPickerResult>()
    if let array = (json as? Array<Dictionary<String, Any>>),
       array.count != 0 {
      for dictionary in array {
        if let bearing = dictionary["bearing"] as? Double,
           let image = dictionary["manifest_id"] as? String,
           let latitude = dictionary["latitude"] as? Double,
           let longitude = dictionary["longitude"] as? Double {
          let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
          if CLLocationCoordinate2DIsValid(coordinate) {
            var course = (bearing - 90.0)
            if course < 0.0 {
              course += 360.0
            }
            if 359.9 < course {
              course = 359.9
            }
            let result = NBARRuschaPickerResult(id: UUID(), altitude: nil, coordinate: coordinate, course: course, image: image, pixelHeight: nil, pixelWidth: nil)
            results.append(result)
          }
        }
      }
    }
    completionHandler(results)
  }
}

private func ReadLocalJSON(_ name: String, completionHandler: @escaping (Any?, Error?) -> Void) {
  DispatchQueue.global().async {
    do {
      let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      let jsonDirectory = documentDirectory.appendingPathComponent("JSON", isDirectory: true)
      let url = jsonDirectory.appendingPathComponent(name).appendingPathExtension("json")
      let data = try Data(contentsOf: url)
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      completionHandler(json, nil)
    } catch {
      completionHandler(nil, error)
    }
  }
}

private func WriteLocalJSON(_ name: String, json: Any, completionHandler: @escaping (Bool, Error?) -> Void) {
  DispatchQueue.global().async {
    do {
      let data = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .withoutEscapingSlashes])
      let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      let jsonDirectory = documentDirectory.appendingPathComponent("JSON", isDirectory: true)
      try FileManager.default.createDirectory(at: jsonDirectory, withIntermediateDirectories: true, attributes: nil)
      let url = jsonDirectory.appendingPathComponent(name).appendingPathExtension("json")
      try data.write(to: url, options: [.atomic])
      completionHandler(true, nil)
    } catch {
      completionHandler(false, error)
    }
  }
}

//  MARK: -

private final class NBARRuschaPickerDataModel : ObservableObject {
  //  MARK: -
  static let shared = NBARRuschaPickerDataModel()
  
  @Published var downloadingDictionary = Dictionary<String, Bool>()
  @Published var progressDictionary = Dictionary<String, Double>()
  
  private var publishersDictionary = Dictionary<String, AnyCancellable>()
  private var requestsDictionary = Dictionary<String, NBARRuschaPickerDataModelJSONRequest>()
  
  //  MARK: -
  
  func request(for manifest: String, resultHandler: @escaping (Array<NBARRuschaPickerResult>, Dictionary<AnyHashable, Any>?) -> Void) {
    ReadLocalJSON(manifest) { [weak self] result, error in
      if let error = error {
        if let error = error as NSError? {
          if error.domain != NSCocoaErrorDomain || error.code != CocoaError.Code.fileReadNoSuchFile.rawValue {
            print(error)
          }
        } else {
          print(error)
        }
        
        DispatchQueue.main.async {
          if let self = self {
            if self.requestsDictionary[manifest] == nil {
              let request = NBARRuschaPickerDataModelJSONRequest(manifest)
              self.requestsDictionary[manifest] = request
              self.downloadingDictionary[manifest] = true
              self.publishersDictionary[manifest] = request.$progress.sink() { [weak self] progress in
                self?.progressDictionary[manifest] = progress
              }
              request.request { result, error in
                if let result = result {
                  WriteLocalJSON(manifest, json: result) { success, error in
                    if let error = error {
                      print(error)
                    }
                  }
                }
                
                ParseJSON(result) { [weak self] results in
                  DispatchQueue.main.async {
                    self?.requestsDictionary[manifest] = nil
                    self?.downloadingDictionary[manifest] = nil
                    self?.publishersDictionary[manifest] = nil
                    self?.progressDictionary[manifest] = nil
                    resultHandler(results, nil)
                  }
                }
              }
            }
          }
        }
      } else {
        ParseJSON(result) { results in
          DispatchQueue.main.async {
            resultHandler(results, nil)
          }
        }
      }
    }
  }
}

//  MARK: -

private final class NBARRuschaPickerDataModelJSONRequest : ObservableObject {
  //  MARK: -
  private let manifest: String
  
  @Published var progress = 0.0
  
  private var array = Array<URLSessionDataTask>()
  private var backgroundTask: UIBackgroundTaskIdentifier?
  private var didCancel = false
  private var didRequest = false
  
  private let queue: DispatchQueue
  
  //  MARK: -
  
  init(_ manifest: String) {
    self.manifest = manifest
    self.queue = DispatchQueue(label: manifest)
  }
  
  func cancel() {
    self.queue.async {
      if self.didRequest {
        self.didCancel = true
        for task in self.array {
          task.cancel()
        }
        self.endBackgroundTask()
      }
    }
  }
  
  func request(resultHandler: @escaping (Any?, Dictionary<AnyHashable, Any>?) -> Void) {
    self.queue.async {
      if self.didRequest == false {
        self.didRequest = true
        self.beginBackgroundTask()
        //  TODO: MOTIVATION AND TARGET_GENERATOR
        //  motivation=https://data.getty.edu/local/thesaurus/motivations/iiif_ap_manifest_of
        //  target_generator=https://data.getty.edu/local/thesaurus/generators/arches
        let string = "https://services.getty.edu/id-management/links/page/1?body_id=https://media.getty.edu/iiif/manifest/" + self.manifest
        let task = URLSession.shared.jsonTask(with: string) { [weak self] result, response, error in
          if let error = error {
            if let response = response {
              print(response)
            }
            print(error)
            resultHandler(nil, nil)
            self?.endBackgroundTask()
          } else {
            if let items = (((result as? NSDictionary)?.object(forKey: "items")) as? NSArray),
               items.count != 0,
               let target = (((((items.object(at: 0) as? NSDictionary)?.object(forKey: "target")) as? NSDictionary)?.object(forKey: "id")) as? String) {
              self?.queue.async {
                if self?.didCancel == false {
                  let semaphore = DispatchSemaphore(value: 0)
                  var count = 0
                  var bodyIDs = Array<String>()
                  //  TODO: MOTIVATION AND BODY_GENERATOR
                  //  motivation=https://data.getty.edu/local/thesaurus/motivations/part_of
                  //  body_generator=https://data.getty.edu/local/thesaurus/generators/rwo
                  var next: String? = "https://services.getty.edu/id-management/links/page/1?target_id=" + target
                  while let string = next {
                    //  TODO: CHECK CANCEL BOOL ON EVERY ITERATION
                    let task = URLSession.shared.jsonTask(with: string) { result, response, error in
                      if let error = error {
                        if let response = response {
                          print(response)
                        }
                        print(error)
                      } else {
                        if let items = (((result as? NSDictionary)?.object(forKey: "items")) as? NSArray) {
                          for item in items {
                            if let bodyID = (((((item as? NSDictionary)?.object(forKey: "body")) as? NSDictionary)?.object(forKey: "id")) as? String) {
                              bodyIDs.append(bodyID)
                            }
                          }
                        }
                        next = (((result as? NSDictionary)?.object(forKey: "next")) as? String)
                      }
                      semaphore.signal()
                    }
                    
                    if let task = task {
                      task.resume()
                      self?.array.append(task)
                      semaphore.wait()
                    }
                  }
                  
                  self?.queue.async {
                    if self?.didCancel == false {
                      var json = Array<Dictionary<String, Any>>()
                      
                      for bodyID in bodyIDs {
                        //  TODO: CHECK CANCEL BOOL ON EVERY ITERATION
                        let task = URLSession.shared.jsonTask(with: bodyID) { [weak self] result, response, error in
                          if let error = error {
                            if let response = response {
                              print(response)
                            }
                            print(error)
                          } else {
                            if let referredToBy = ((((result as? NSDictionary)?.object(forKey: "produced_by")) as? NSDictionary)?.object(forKey: "referred_to_by") as? NSArray),
                               referredToBy.count != 0,
                               let dimension = ((referredToBy.object(at: 0) as? NSDictionary)?.object(forKey: "dimension") as? NSArray),
                               dimension.count != 0,
                               let bearing = ((dimension.object(at: 0) as? NSDictionary)?.object(forKey: "value") as? Double),
                               let tookPlaceAt = ((((result as? NSDictionary)?.object(forKey: "produced_by")) as? NSDictionary)?.object(forKey: "took_place_at") as? NSArray),
                               tookPlaceAt.count != 0,
                               let viewpoint = ((tookPlaceAt.object(at: 0) as? NSDictionary)?.object(forKey: "defined_by") as? String) {
                              let substring = viewpoint.filter { character in
                                switch (character) {
                                case "P":
                                  return false
                                case "O":
                                  return false
                                case "I":
                                  return false
                                case "N":
                                  return false
                                case "T":
                                  return false
                                case "(":
                                  return false
                                case ")":
                                  return false
                                default:
                                  return true
                                }
                              }
                              let components = substring.components(separatedBy: " ")
                              if components.count == 2 {
                                if let latitude = Double(components[1]),
                                   let longitude = Double(components[0]),
                                   let subjectOf = (((result as? NSDictionary)?.object(forKey: "subject_of")) as? NSArray) {
                                  var manifestIDs = Array<String>()
                                  for result in subjectOf {
                                    if let manifestID = ((result as? NSDictionary)?.object(forKey: "id")) as? String,
                                       let conformsTo = (((result as? NSDictionary)?.object(forKey: "conforms_to")) as? NSArray) {
                                      for result in conformsTo {
                                        if let id = (((result as? NSDictionary)?.object(forKey: "id")) as? String) {
                                          if id == "http://iiif.io/api/presentation" {
                                            manifestIDs.append(manifestID)
                                          }
                                        }
                                      }
                                    }
                                  }
                                  if manifestIDs.count != 0 {
                                    json.append([
                                      "bearing": bearing,
                                      "latitude": latitude,
                                      "longitude": longitude,
                                      "manifest_id": manifestIDs[0],
                                    ])
                                    
                                    if json.count % 100 == 0 {
                                      let progress = Double(json.count) / Double(bodyIDs.count)
                                      DispatchQueue.main.async {
                                        self?.progress = progress
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                          semaphore.signal()
                        }
                        
                        if let task = task {
                          task.resume()
                          self?.array.append(task)
                          count += 1
                          if count == URLSession.shared.configuration.httpMaximumConnectionsPerHost {
                            semaphore.wait()
                            count -= 1
                          }
                        }
                      }
                      
                      while count != 0 {
                        semaphore.wait()
                        count -= 1
                      }
                      
                      resultHandler(json, nil)
                      self?.endBackgroundTask()
                    }
                  }
                }
              }
            } else {
              resultHandler(nil, nil)
              self?.endBackgroundTask()
            }
          }
        }
        
        if let task = task {
          task.resume()
          self.array.append(task)
        }
      }
    }
  }
}

//  MARK: -

private extension NBARRuschaPickerDataModelJSONRequest {
  //  MARK: -
  private func beginBackgroundTask() {
    self.backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
      if let backgroundTask = self?.backgroundTask {
        UIApplication.shared.endBackgroundTask(backgroundTask)
      }
    }
  }
  
  private func endBackgroundTask() {
    if let backgroundTask = self.backgroundTask {
      UIApplication.shared.endBackgroundTask(backgroundTask)
    }
  }
}

// MARK: -

struct NBARRuschaPickerPreviews: PreviewProvider {
  // MARK: -
  static var previews: some View {
    NBARRuschaPicker(
      didFinishPicking: { title, manifest in
        
      }
    )
  }
}
