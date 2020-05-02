# MyExtensions
This Library is for help ios development with a extension collections, some of collections are:

* [Array+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Array%2BExtension.swift)
* [Character+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Character%2BExtension.swift)
* [Collection+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Collection%2BExtension.swift)
* [Data+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Data%2BExtension.swift)
* [Date+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Date%2BExtension.swift)
* [Encodable+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Encodable%2BExtension.swift)
* [Int+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/Int%2BExtension.swift)
* [JSONEncoder+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/JSONEncoder%2BExtension.swift)
* [NSTextAttachment+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/NSTextAttachment%2BExtension.swift)
* [String+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/String%2BExtension.swift)
* [UIDevice+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/UIDevice%2BExtension.swift)
* [UIImage+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/UIImage%2BExtension.swift)
* [UIStackView+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/UIStackView%2BExtension.swift)
* [UITextField+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/UITextField%2BExtension.swift)
* [UIView+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/UIView%2BExtension.swift)
* [UIViewController+Extension](https://github.com/AdrianoSong/iOS-MyExtensions/blob/master/Sources/MyExtensions/UIViewController%2BExtension.swift)

# Instalation

## Swift Package Manager
In the section "Enter Package Repository URL" paste the root repo URL [https://github.com/AdrianoSong/iOS-MyExtensions](AdrianoSong/iOS-MyExtenions)

# How to use
Once installed, add the import dependency on AppDelegate.swift file, like this:
```swift
import MyExtensions
```
Done! You can use extensions for all over your project don't need to import it again, Here is a example:
```swift
//.localized() from Strings+Extension.swift
let myLocalizedString = "my.string.key".localized()
```
### Todos

- Create Carthage dependency manager
- Create and Publish pod (for Cocoapods dependency manager)

License
----

MIT
