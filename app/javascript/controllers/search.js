import { Controller } from "@hotwired/stimulus"

let searchValue =  '';

export default class extends Controller {
    static targets = [
        'options', 'law'
    ];

    searchLaw(e) {
        if (e instanceof InputEvent && e.inputType != 'insertReplacementText') {
            searchValue = this.lawTarget.value
            return
        }

        if (searchValue.length <= 2){
            this.lawTarget.value = searchValue
        }

        if (searchValue.length >= 3){
            let searchParts = this.lawTarget.value.split(/\s*\-\s*/g);
            window.location.href = `/document_page?sr_number=${searchParts[0]}&title=${searchParts[1]}`;
        }
    }
}
