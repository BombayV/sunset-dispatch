const mainCont = doc.getElementById('main-container')

doc.getElementById('test').addEventListener('click', () => {
    const cont = doc.createElement('div');
    const text = doc.createElement('span');
    const img = doc.createElement('img');

    cont.classList.add('container-slides');
    text.classList.add('slide-text');
    img.classList.add('slide-img');

    text.innerHTML = "Test"
    img.src = "./img/adder.png"

    img.appendChild(cont);
    text.appendChild(cont);

    cont.appendChild(mainCont)
})