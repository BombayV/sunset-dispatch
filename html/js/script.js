let num = 0
const mainCont = doc.getElementById('main-container')
doc.getElementById('test').addEventListener('click', () => {
    const cont = doc.createElement('div');
    const text = doc.createElement('span');
    const img = doc.createElement('img');
    let time = new Date().toLocaleTimeString()

    cont.classList.add('container-slides');
    text.classList.add('slide-text');
    img.classList.add('slide-img');

    text.innerHTML = "jdoasjdo sajd jso"
    img.src = "./img/adder.png"

    cont.setAttribute('data-time', time)
    cont.id = num++
    cont.appendChild(text);
    cont.appendChild(img);

    mainCont.appendChild(cont);
    for (i = 0; i < slides.length; i++) {
        slideNum.textContent = `${currentSlide} /${slides.length}`
    }
})