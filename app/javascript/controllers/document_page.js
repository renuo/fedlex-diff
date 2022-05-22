import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        'buttonUnifield', 'buttonSplitView', 'divUnifield', 'divSplitView'
    ];

    connect(){
        this.showUnifield();

        // copied from https://stackoverflow.com/questions/43456868/javascript-limit-selected-checkboxes-to-2
        let checkboxes = document.querySelectorAll(".revisionCheckbox");
        let max = 2;
        for (let i = 0; i < checkboxes.length; i++) {
            checkboxes[i].onclick = selectiveCheck;
        }

        function selectiveCheck(event) {
            let checkedCheckboxes = document.querySelectorAll(".revisionCheckbox:checked");
            if (checkedCheckboxes.length >= max + 1)
                return false;
        }
    }

    showUnifield(){
        this.divUnifieldTarget.style.display = 'block';
        this.divSplitViewTarget.style.display = 'none';
    }

    showSplitView(){
        this.divSplitViewTarget.style.display = 'flex';
        this.divUnifieldTarget.style.display = 'none';
    }
}
