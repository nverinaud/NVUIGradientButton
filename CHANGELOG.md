# Changelog

## Release 1.6.1

* FIX: layout update when device orientation changed (thanks to [Yassir Barchi](https://github.com/yacir))
* UPDATE: the sample app is more beautiful :P

## Release 1.6.0

* FIX: make things work in Xcode 5 and iOS 7
* UPDATE: the buttons are flat by default on iOS 7

## Release 1.5.0

* NEW: a nice glossy effect may be set using the `glossy` property
* NEW: UIAppearance is now supported, `gradientEnabled` and `glossy` are now `NSInteger` but should be used as `BOOL`

## Release 1.4.0

* NEW: it is now possible to use attributed text (thanks to [Dean Moore](https://github.com/moored))

## Release 1.3.0

* NEW: it is now possible to specify a left accessory image (for normal & highlighted state)
* NEW: ARC is conditionnaly supported

## Release 1.2.1

* FIX: fix a crash happening when a change of the style occured

## Release 1.2

* UPDATE: the style property is now a readwrite property

## Release 1.1.1

* FIX: issues [#1](https://github.com/nverinaud/NVUIGradientButton/issues/1) & [#2](https://github.com/nverinaud/NVUIGradientButton/issues/2)
* FIX: use the border width property
* ENHANCEMENT: add a padding for the title label
* ENHANCEMENT: do not limit the label to one line by default
* NEW: it is now possible to specify a right accessory image (for normal & highlighted state)

## Release 1.1.0

* NEW: add style to make configuration easier for common needs

## Release 1.0.0

* Initial Version