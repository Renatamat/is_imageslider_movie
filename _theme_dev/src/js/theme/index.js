document.addEventListener('DOMContentLoaded', async () => {
  const sliderEl = document.querySelector('#homeSlider');
  const bulletsWrap = document.getElementById('customPagination');
  const pauseBtn = document.getElementById('pauseBtn');
  const prevBtn       = document.getElementById('homeSliderPrev');
  const nextBtn       = document.getElementById('homeSliderNext');

  // exit if slider is not found
  if (!sliderEl || !bulletsWrap || !pauseBtn) return;

  const pauseIcon = pauseBtn.querySelector('.icon-pause');
  const playIcon = pauseBtn.querySelector('.icon-play');

  const autoplayTime = parseInt(sliderEl.dataset.autoplay, 10) || 5000;
  let raf;
  let isPaused = false;
  let startTime = null;
  let savedProgress = 0;

  const wrapper = new prestashop.SwiperSlider('#homeSlider', {
    loop: false,
    speed: 700,
    autoplay: {
      delay: autoplayTime,
      disableOnInteraction: false,
      pauseOnMouseEnter: false,
    },
    on: {
      init(sw) {
        buildBullets(sw);
        updateBullets(sw.realIndex);
        attachArrows(sw); 
        updateArrows(sw);
        runProgress(sw);
      },
      slideChange(sw) {
        savedProgress = 0;
        updateBullets(sw.realIndex);
        updateArrows(sw);
        if (!isPaused) {
          runProgress(sw);
        }
      }
    }
  });

  await wrapper.initSwiper();
  const swiper = wrapper.SwiperInstance;
  if (!swiper) return;

  pauseBtn.addEventListener('click', () => {
    if (!swiper.autoplay) return;

    if (isPaused) {
      isPaused = false;
      playIcon?.classList.add('d-none');
      pauseIcon?.classList.remove('d-none');

      if (swiper.autoplay.running) {
        swiper.autoplay.resume();
      } else {
        swiper.autoplay.start();
      }

      runProgress(swiper, savedProgress);
    } else {
      isPaused = true;
      swiper.autoplay.stop();
      cancelAnimationFrame(raf);
      playIcon?.classList.remove('d-none');
      pauseIcon?.classList.add('d-none');
    }
  });

  function buildBullets(sw) {
    if (!bulletsWrap) return;
    bulletsWrap.innerHTML = '';
    const slidesCount = sw.slides.length;

    for (let i = 0; i < slidesCount; i++) {
      const b = document.createElement('div');
      b.className = 'slider-pagination-bullet';
      b.addEventListener('click', () => {
        savedProgress = 0;
        sw.slideTo(i);

        if (isPaused) {
          swiper.autoplay.stop();
          cancelAnimationFrame(raf);
          setBulletProgress(i, 0);
        }
      });
      bulletsWrap.appendChild(b);
    }
  }

  function updateBullets(activeIndex) {
    document.querySelectorAll('.slider-pagination-bullet').forEach((b, i) => {
      b.classList.toggle('active', i === activeIndex);
      b.style.setProperty('--progress', '-100%');
    });
  }

  function setBulletProgress(index, progress) {
    const bullets = document.querySelectorAll('.slider-pagination-bullet');
    const active = bullets[index];
    if (!active) return; 
    active.style.setProperty('--progress', `${-100 + progress * 100}%`);
  }

  function runProgress(sw, fromProgress = 0) {
    cancelAnimationFrame(raf);
    const index = sw.realIndex;
    const duration = autoplayTime * (1 - fromProgress);
    startTime = performance.now();

    function tick(now) {
      if (isPaused) return;

      const elapsed = now - startTime;
      const progress = Math.min(fromProgress + elapsed / autoplayTime, 1);
      savedProgress = progress; 
      setBulletProgress(index, progress);

      if (progress < 1) {
        raf = requestAnimationFrame(tick);
      }
    }

    raf = requestAnimationFrame(tick);
  }
  function attachArrows(sw) {
    if (prevBtn) {
      prevBtn.addEventListener('click', () => {
        savedProgress = 0;
        sw.slidePrev();
        if (isPaused) {
          swiper.autoplay.stop();
          cancelAnimationFrame(raf);
          setBulletProgress(sw.realIndex, 0);
        }
      });
    }
    if (nextBtn) {
      nextBtn.addEventListener('click', () => {
        savedProgress = 0;
        sw.slideNext();
        if (isPaused) {
          swiper.autoplay.stop();
          cancelAnimationFrame(raf);
          setBulletProgress(sw.realIndex, 0);
        }
      });
    }
  }
  function updateArrows(sw) {
    // Jeżeli masz loop:false, dezaktywuj strzałki na brzegach
    const isLoop = !!sw.params.loop;
    if (isLoop) {
      prevBtn?.removeAttribute('disabled');
      nextBtn?.removeAttribute('disabled');
      return;
    }
    if (prevBtn) prevBtn.toggleAttribute('disabled', sw.isBeginning === true);
    if (nextBtn) nextBtn.toggleAttribute('disabled', sw.isEnd === true);
  }
});
