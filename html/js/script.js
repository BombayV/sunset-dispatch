const mainCont = doc.getElementById('main-container')

window.addEventListener('message', (e) => {
    switch (e.data.action) {
        case 'open':
            wrapper.style.display = 'flex';
            break;

        case 'insertData':
            insertNewSlide(e.data.type, e.data.text, e.data.model, e.data.primary, e.data.coordsX, e.data.coordsY, e.data.title)
            break;
    }
})

// Keys setup
doc.onkeyup = event => {
    if (event.key == 'Escape') {
        wrapper.style.display = 'none';
        fetchNUI('close', 'cb');
    }
}

// Slide function
function insertNewSlide(type, message, model, primary, x, y, title) {
    const cont = doc.createElement('div');
    const text = doc.createElement('span');
    let time = new Date().toLocaleTimeString();

    text.textContent = message;
    cont.classList.add('container-slides');
    text.classList.add('slide-text');

    cont.setAttribute('data-title', `Call Id: ${title}`);
    cont.setAttribute('data-time', time);
    cont.setAttribute('data-x', x);
    cont.setAttribute('data-y', y);
    if (type == "veh") {
        let color = 'El vehiculo era de color ' + primary;
        if (primary == undefined) {
            color = 'No se puedo encontrar el color'
        }
        const vehText = doc.createElement('span')
        const img = doc.createElement('img');
        let vehicle = model.toUpperCase()
        vehText.classList.add('slide-text');
        img.classList.add('slide-img');

        vehText.textContent = color;
        img.src = `https://bombayv.github.io/images.github.io/img/${vehicle}.webp`;
        img.alt = "No hay fotos del vehiculo";
        cont.appendChild(text);
        cont.appendChild(vehText);
        cont.appendChild(img);
        mainCont.appendChild(cont);
    }
    if (type != 'veh') {
        cont.appendChild(text);
    }
    mainCont.appendChild(cont);
    for (i = 0; i < slides.length; i++) {
        slideNum.textContent = `${currentSlide} /${slides.length}`
        if (currentSlide == 0 || slides.length == 1) {
            slideChanger('after')
        }
    }
}
