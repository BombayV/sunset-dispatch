const doc = document
const before = doc.getElementById('before')
const after = doc.getElementById('after')

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
    console.log('b')
    currentSlide++
    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
    }
    if (currentSlide > slides.length) {
      currentSlide = 1
    }
    slides[currentSlide - 1].style.display = "block";
    slides[currentSlide - 1].style.animation = "fadeIn 1.5s linear";
    doc.getElementById('num-slides').textContent = `${currentSlide} /${slides.length}`
});
  
before.addEventListener("click", () => {
    console.log('a')
    currentSlide--
    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
    }
    if (currentSlide < 1) {
      currentSlide = slides.length
    }
    slides[currentSlide - 1].style.display = "block";
    slides[currentSlide - 1].style.animation = "fadeIn 1.5s linear";
    doc.getElementById('num-slides').textContent = `${currentSlide} /${slides.length}`
});