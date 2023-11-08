import Controller from './loader_controller';
import { useClickOutside } from 'stimulus-use';

export default class extends Controller {

    static classes = ["display"];
    static targets = [ 'dropdown' ];


    connect() {
        useClickOutside(this);
    }


    showUserDropdown(event){
        event.preventDefault();
        this.dropdownTarget.classList.add(this.displayClass);
    }

    hideUserDropdown(event) {
        event.preventDefault();
        this.dropdownTarget.classList.remove(this.displayClass);
    }
}
