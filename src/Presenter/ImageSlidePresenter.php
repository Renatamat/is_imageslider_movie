<?php

declare(strict_types=1);

namespace Oksydan\IsImageslider\Presenter;

class ImageSlidePresenter
{
    /**
     * @var string
     */
    private $imagesUri;

    /**
     * @var string
     */
    private $imagesDir;

    /**
     * @var \Context
     */
    private $context;

    public function __construct(
        string $imagesUri,
        string $imagesDir,
        \Context $context
    ) {
        $this->imagesUri = $imagesUri;
        $this->imagesDir = $imagesDir;
        $this->context = $context;
    }

    public function present($slide): array
    {
        $slide['image_desktop_url'] = $this->getImageUrl($slide['image']);
        $slide['image_tablet_url'] = $this->getImageUrl($slide['imageTablet']);
        $slide['image_mobile_url'] = $this->getImageUrl($slide['imageMobile']);

        $slide['sizes_desktop'] = $this->getImageSizes($slide['image']);
        $slide['sizes_tablet'] = $this->getImageSizes($slide['imageTablet']);
        $slide['sizes_mobile'] = $this->getImageSizes($slide['imageMobile']);

        return $slide;
    }

    private function getImageUrl($slideImage): string
    {
        return $this->context->link->getMediaLink($this->imagesUri . $slideImage);
    }

    private function getImageSizes($slideImage): array
    {
        $imageFullPath = $this->imagesDir . $slideImage;
        $sizes = [];

        if (file_exists($imageFullPath)) {
            $sizes = getimagesize($imageFullPath);
        }

        return $sizes;
    }
}
