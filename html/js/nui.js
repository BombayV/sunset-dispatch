const doc = document

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
