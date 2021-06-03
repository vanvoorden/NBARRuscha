# Ruscha AR 0.1

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
