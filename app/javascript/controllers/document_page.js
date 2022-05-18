import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        'buttonUnifield', 'buttonSplitView', 'divUnifield', 'divSplitView'
    ];

    connect(){
        this.showUnifield();
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
