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

doc.onkeyup = event => {
    if (event.key == 'Escape') {
        wrapper.style.display = 'none';
        fetchNUI('close', 'cb');
    }
}

function insertNewSlide(type, message, model, primary, x, y, title) {
    if (type == "veh") {
        let color = 'El vehiculo era de color ' + primary;
        if (primary == undefined) {
            color = 'No se puedo encontrar el color'
        }
        const cont = doc.createElement('div');
        const text = doc.createElement('span');
        const vehText = doc.createElement('span')
        const img = doc.createElement('img');
        let time = new Date().toLocaleTimeString();
        let vehicle = model.toUpperCase()
        cont.classList.add('container-slides');
        text.classList.add('slide-text');
        vehText.classList.add('slide-text');
        img.classList.add('slide-img');
        text.textContent = message.capitalize();
        vehText.textContent = color;
        img.src = `https://bombayv.github.io/images.github.io/img/${vehicle}.webp`;
        img.alt = "No hay fotos del vehiculo";
    
        cont.setAttribute('data-title', `Call Id: ${title}`)
        cont.setAttribute('data-time', time)
        cont.setAttribute('data-x', x)
        cont.setAttribute('data-y', y)
        cont.appendChild(text);
        cont.appendChild(vehText);
        cont.appendChild(img);
    
        mainCont.appendChild(cont);
        for (i = 0; i < slides.length; i++) {
            slideNum.textContent = `${currentSlide} /${slides.length}`
        }
    } else {
        const cont = doc.createElement('div');
        const text = doc.createElement('span');
        let time = new Date().toLocaleTimeString();
    
        cont.classList.add('container-slides');
        text.classList.add('slide-text');
    
        text.textContent = message.capitalize();
    
        cont.setAttribute('data-title', `Call Id: ${title}`);
        cont.setAttribute('data-time', time);
        cont.setAttribute('data-x', x);
        cont.setAttribute('data-y', y);
        cont.appendChild(text);
        mainCont.appendChild(cont);
        for (i = 0; i < slides.length; i++) {
            slideNum.textContent = `${currentSlide} /${slides.length}`
        }
    }
}
