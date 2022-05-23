document.addEventListener('turbo:load', () => {
    let form = document.getElementById('filter')
    let max = 2;

    form.addEventListener('keypress', e => {
        if (e.code == 'Enter' && e.target.className == 'revisionCheckbox') {
            let checkedCheckboxes = document.querySelectorAll(".revisionCheckbox:checked");

            e.preventDefault(); if(checkedCheckboxes.length < max) { e.target.checked = !e.target.checked;}
            else{e.target.checked = false;}
        }
    })
})
