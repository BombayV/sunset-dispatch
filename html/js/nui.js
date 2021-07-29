const doc = document;
const before = doc.getElementById('before');
const after = doc.getElementById('after');
const loc = doc.getElementById('location');

const preview = doc.getElementById('preview')

const slideNum = doc.getElementById('num-slides')
const timeNum = doc.getElementById('num-time')


function openTab(target, className, settings) {
    let i, tabcontent;
    let id = doc.getElementById(target)
    tabcontent = doc.getElementsByClassName(className);
    if (settings) {
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.opacity = '0';
        }
        id.style.opacity = '1';
    } else {
        if (id.style.opacity == '1') {
            id.style.opacity = '0';
        } else {
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.opacity = '0';
            }
            id.style.opacity = '1';
        }
    }
}

const sel = doc.getElementById('dp-select');
sel.addEventListener('change', function(e) {
    switch (sel.value) {
        case 'dispatch':
            console.log(sel.value)
            openTab('dispatch', 'dp-tabs')
        break;

        case 'officers':
            console.log(sel.value)
            openTab('officers', 'dp-tabs')
        break;
    }
}, false);

let currentSlide = 0;
let i;

const slides = doc.getElementsByClassName("container-slides");

after.addEventListener("click", () => {
    if (slides.length > 0) {
        currentSlide++
        if (preview.style.display != 'none') {
            preview.style.display = 'none'
        }
        for (i = 0; i < slides.length; i++) {
          slides[i].style.opacity = "0";  
        }
        if (currentSlide > slides.length) {
          currentSlide = 1
        }
        slides[currentSlide - 1].style.opacity = "1";
        slideNum.textContent = `${currentSlide} /${slides.length}`
        timeNum.textContent =  slides[currentSlide - 1].getAttribute('data-time');
    }
});
  
before.addEventListener("click", () => {
    if (slides.length > 0) {
        currentSlide--
        if (preview.style.display != 'none') {
            preview.style.display = 'none'
        }
        for (i = 0; i < slides.length; i++) {
          slides[i].style.opacity = "0";  
        }
        if (currentSlide < 1) {
          currentSlide = slides.length
        }
        slides[currentSlide - 1].style.opacity = "1";
        slideNum.textContent = `${currentSlide} /${slides.length}`
        timeNum.textContent =  slides[currentSlide - 1].getAttribute('data-time');
    }
});