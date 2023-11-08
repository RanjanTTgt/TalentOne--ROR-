import Controller from './loader_controller';

export default class extends Controller {
    static targets = ["message"];

    connect(){
        setTimeout(()=>{
            this.messageTarget.remove();
        }, 5000)
    }

    remove(){
        this.messageTarget.remove();
    }


}