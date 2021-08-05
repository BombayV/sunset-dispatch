const doc = document;
const before = doc.getElementById('before');
const after = doc.getElementById('after');
const loc = doc.getElementById('location');
const del = doc.getElementById('delete');

const preview = doc.getElementById('preview');
const sel = doc.getElementById('dp-select');

const slideNum = doc.getElementById('num-slides');
const timeNum = doc.getElementById('num-time');
const titleNum = doc.getElementById('num-title');

const slides = doc.getElementsByClassName('container-slides');
const wrapper = doc.getElementById('wrapper');

// Select
let currentSlide = 0;

sel.addEventListener('change', function(e) {
    switch (sel.value) {
        case 'dispatch':
            openTab('dispatch', 'dp-tabs');
        break;

        case 'officers':
            openTab('officers', 'dp-tabs');
        break;
    }
}, false);

// Arrows for dispatch
after.addEventListener('click', () => slideChanger('after'));
  
before.addEventListener('click', () => slideChanger('before'));

loc.addEventListener('click', () => setCoords());

del.addEventListener('click', () => slideChanger('delete'));

// Functions
const fetchNUI = async (cbname, data) => {
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data)
    };
    const resp = await fetch(`https://sunset-dispatch/${cbname}`, options);
    return await resp.json();
}

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

// Selector for tabs
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

// Slides function
function slideChanger(type) {
    if (slides.length > 0) {
        if (type == 'after') {
            currentSlide++
            if (currentSlide > slides.length) {
                currentSlide = 1;
            }
        } else if (type == 'delete') {
            if (slides.length == 1) {
                slides[currentSlide - 1].remove();
                slideNum.textContent = `0 /${slides.length}`;
                preview.style.display = 'flex';
            } else if (slides.length > 1) {
                if (currentSlide != 1) {
                    currentSlide--
                    slides[currentSlide].remove();
                } else {
                    slides[currentSlide - 1].remove();
                }
                slides[currentSlide - 1].style.opacity = "1";
                slideNum.textContent = `${currentSlide} /${slides.length}`;
            }
            return
        } else {
            currentSlide--
            if (currentSlide < 1) {
                currentSlide = slides.length;
            }
        }
        if (preview.style.display != 'none') {
            preview.style.display = 'none';
        }
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.opacity = "0";  
        }
        slides[currentSlide - 1].style.opacity = "1";
        slideNum.textContent = `${currentSlide} /${slides.length}`;
        timeNum.textContent =  slides[currentSlide - 1].getAttribute('data-time');
        titleNum.textContent = slides[currentSlide - 1].getAttribute('data-title');
    }
}