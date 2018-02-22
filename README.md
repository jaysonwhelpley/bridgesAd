# Rails Image Compositing for Custom WeChat Ad

The client is a university ministry that needs a WeChat ad created with a new QR code. As WeChat QR codes expire every 7 days, he needed to be able to recreate them that often.

I was able to put together a script in ImageMagick, that I could run from my terminal, but I was unwilling to run it for him every week. The client wasn't savvy enough to run it himself in Terminal, so I created a rails project using CarrierWave and MiniMagick to upload two images:

* a Base image (located at /public/uploads/base/image/1/BaseImage.jpg)

* a WeChat QR Code image (example located at /public/uploads/code/image/1/qr_edited.png )

The user can upload a new QR Code image each week (or more or less often). The MiniMagick script crops the QR image own, rotates it, shrinks it and places it in the proper location on the PostIt on the bottom right, along with a darken filter.

Since most of these images are single-use. The app will delete old Code images when new ones are uploaded.
