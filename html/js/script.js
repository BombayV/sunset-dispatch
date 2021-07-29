const mainCont = doc.getElementById('main-container')

window.addEventListener('message', (e) => {
    switch (e.data.action) {
        case 'open':
            wrapper.style.display = 'flex';
            break;

        case 'insertData':
            insertNewSlide(e.data.text, e.data.model, e.data.coordsX, e.data.coordsY)
            break;
    }
})

doc.getElementById('test').addEventListener('click', ()=>{
    insertNewSlide('EL mensaje de la persona ira aqui y pues bueno. No se que mas poner para alargar este texto', 'adder', 'verde', 'rojo','10', '10')
})

doc.onkeyup = event => {
    if (event.key == 'Escape') {
        wrapper.style.display = 'none';
        fetchNUI('close', 'cb');
    }
}

function insertNewSlide(message, model, primary, secondary, x, y) {
    const cont = doc.createElement('div');
    const text = doc.createElement('span');
    const vehText = doc.createElement('span')
    const img = doc.createElement('img');
    let time = new Date().toLocaleTimeString()

    cont.classList.add('container-slides');
    text.classList.add('slide-text');
    vehText.classList.add('slide-text');
    img.classList.add('slide-img');

    text.textContent = message
    vehText.textContent = 'El vehiculo era de color ' + primary + ' y ' + secondary
    img.src = `./img/${model}.webp`

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
}