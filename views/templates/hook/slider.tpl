{*
 * 2007-2020 PrestaShop.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{* --- slider.tpl (custom) --- *}
{if !empty($homeslider.slides)}
  {assign var='autoplayTime' value=$homeslider.speed|default:5000}

  <section class="slider-home">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-12">
          <div class="slider-container position-relative">

            <!-- Slider -->
            <div id="homeSlider" class="swiper slider-wrapper" data-autoplay="{$autoplayTime|intval}">
              <div class="swiper-wrapper" id="slidesRoot">
                {images_block}
                  {foreach from=$homeslider.slides item=slide name=hs}
                    <div class="swiper-slide slider-slide">
                      <div class="bg-img">
                        <picture>
                          <source media="(min-width: 993px)" srcset="{$slide.image_desktop_url}">
                          <source media="(min-width: 576px)" srcset="{$slide.image_tablet_url}">
                          <img
                            src="{$slide.image_mobile_url}"
                            alt="{$slide.title|escape:'html':'UTF-8'}"
                            {if !empty($slide.sizes_desktop)}
                              width="{$slide.sizes_desktop.0}" height="{$slide.sizes_desktop.1}"
                            {/if}
                            {if !$smarty.foreach.hs.first}loading="lazy"{/if}
                          >
                        </picture>
                      </div>
                      <div class="container me-auto position-relative h-100">
                        <div class="content-slider"
                             data-button-src="{$slide.url|escape:'html':'UTF-8'}">
                          {if $slide.title || $slide.description}
                       
                          {/if}
                        </div>
                      </div>                        
                        <a href="{$slide.url|default:'#'|escape:'html':'UTF-8'}" id="sliderMainBtn" class="c-btn c-btn-l c-btn-fill --yellow position-absolute">
                            <span class="p-l fw-bolder">{$slide.legend|default:'Sprawdź'|escape:'html':'UTF-8'}</span>
                        </a>
                    </div>
                  {/foreach}
                {/images_block}
              </div>
            </div>

            <!-- Progress pills -->
            <div class="slider-pagination-container mt-3">
              <div class="slider-pagination-wrapper d-flex gap-8 gap-md-12 gap-xl-16 align-items-center">
                <button type="button" id="homeSliderPrev" class="slider-arrow-btn c-white fs-24 p-8 p-md-12 p-xl-16" aria-label="Poprzedni slajd">
                    <i class="icon-chevron-left" aria-hidden="true"></i>
                </button>
                <div class="slider-pagination" id="customPagination"></div>
                <div class="status-stop" id="pauseBtn" style="right:16px;bottom:16px;">
{*                  <svg class="icon-pause" width="24" height="24" viewBox="0 0 24 24">*}
                    <g opacity="1">
                      <path d="M6 18.4V5.6C6 5.26863 6.26863 5 6.6 5H9.4C9.73137 5 10 5.26863 10 5.6V18.4C10 18.7314 9.73137 19 9.4 19H6.6C6.26863 19 6 18.7314 6 18.4Z" fill="white" stroke="white" stroke-width="1.5"/>
                      <path d="M14 18.4V5.6C14 5.26863 14.2686 5 14.6 5H17.4C17.7314 5 18 5.26863 18 5.6V18.4C18 18.7314 17.7314 19 17.4 19H14.6C14.2686 19 14 18.7314 14 18.4Z" fill="white" stroke="white" stroke-width="1.5"/>
                    </g>
                  </svg>
                  {*<svg class="icon-play d-none" width="24" height="24" viewBox="0 0 24 24">
                    <g opacity="1">
                      <path d="M7 5.6C7 5.14286 7.52891 4.89922 7.9 5.15L18 12L7.9 18.85C7.52891 19.1008 7 18.8571 7 18.4V5.6Z" fill="white" stroke="white" stroke-width="1.5"/>
                    </g>
                  </svg>*}
                </div>
                <button type="button" id="homeSliderNext" class="slider-arrow-btn c-white  fs-24 " aria-label="Następny slajd">
                  <i class="icon-chevron-right" aria-hidden="true"></i>
                </button>
              </div>
           
            </div>
            <!-- /Progress pills -->

          </div>
        </div>
      </div>
    </div>
  </section>
{/if}
