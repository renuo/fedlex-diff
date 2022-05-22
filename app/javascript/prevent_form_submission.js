document.addEventListener('turbo:load', () => {
    let form = document.getElementById('filter')
    let max = 2;

    form.addEventListener('keypress', e => {
        if (e.code == 'Enter' && e.target.className == 'revisionCheckbox') {
            let checkedCheckboxes = document.querySelectorAll(".revisionCheckbox:checked");

            if(checkedCheckboxes.length >= max && e.target.checked == false){
                e.preventDefault();
            }

            if(checkedCheckboxes.length >= max && e.target.checked == true){
                e.preventDefault();
                e.target.checked = false;
            }

            if(checkedCheckboxes.length < max && e.target.checked == true){
                e.preventDefault();
                e.target.checked = false;
            }

            if(checkedCheckboxes.length < max && e.target.checked == false){
                e.preventDefault();
                e.target.checked = true;
            }
        }
    })
})
