# BeSmart Video Slider

PrestaShop 8.2 ready video slider module built for Swiper. Each slide supports dedicated desktop/mobile MP4 files, multilingual labels/URLs, autoplay on active slide, and responsive source swapping.

## Features
- Desktop and mobile MP4 per slide (only one loaded at a time)
- Multilingual button label and URL
- Autoplay/loop/muted/playsinline handled in JS for active slide only
- Drag & drop ordering in back office controller `AdminBesmartVideoSlider`
- Database storage in `ps_besmartvideoslider_slides` and `ps_besmartvideoslider_slides_lang`
- Swiper compatible markup rendered in `displayHome`

## Installation
1. Copy the `besmartvideoslider` folder into your PrestaShop `modules/` directory.
2. Install the module from the back office.
3. Manage slides via **Modules > Module Manager > Configure** which links to the dedicated admin controller.

Uploaded videos are stored in `modules/besmartvideoslider/videos/`.
