# Ruscha AR 0.4

Browse the streets of Los Angeles on an Augmented Reality historical walking tour. Explore Hollywood through the photos of Ed Ruscha. The Getty Research Institute digitized and geo-tagged almost 100,000 photos we can draw in live 3D.

## Requirements

This project requires Xcode 12.5 or later. The following device requirements apply:

* ARKit
* arm64
* GPS
* A12 Bionic and Later Chips
* Location Services
* iOS 14.0 or later

## Known Issues

* Launching the app, loading photos in AR, backgrounding the app for a long period of time, and activating the app back to the foreground can cause the previously loaded photos to disappear. Reloading the photos from the photo picker should place them back in AR space correctly.

## Release Notes
### 0.4
Update SDK to 0.2.

### 0.3
* `NBARNetwork` replaces the previous networking logic.

### 0.2
* `NBARRuschaPickerResult` replaces the JSON returned by `NBARRuschaPicker`.

### 0.1
* Initial Release

## Acknowledgements
* [https://www.getty.edu/research/collections/collection/100001](https://www.getty.edu/research/collections/collection/100001)  
  Edward Ruscha photographs of Sunset Boulevard and Hollywood Boulevard, 1965-2010, Getty Research Institute, Research Library, Accession no. 2012.M.1.  
  [http://hdl.handle.net/10020/cifa2012m1](http://hdl.handle.net/10020/cifa2012m1)

* [https://www.getty.edu/research/collections/collection/100071](https://www.getty.edu/research/collections/collection/100071)  
  Edward Ruscha Photographs of Los Angeles Streets, 1974-2010, Getty Research Institute, Research Library, Accession no. 2012.M.2.  
  [http://hdl.handle.net/10020/cifa2012m2](http://hdl.handle.net/10020/cifa2012m2)

## License
Ruscha AR

Copyright © 2021 North Bronson Software

This Item is protected by copyright and/or related rights. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use. In addition, no permission is required from the rights-holder(s) for scholarly, educational, or non-commercial uses. For other uses, you need to obtain permission from the rights-holder(s).

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
