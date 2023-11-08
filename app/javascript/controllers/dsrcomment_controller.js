import Controller from './loader_controller';

export default class extends Controller {
    static targets = ["currentDiv", "userId", "commentId"];

    connect() {
        let _this = this, userId = $("#current-user-id").val(),
            commentedUserId = this.userIdTarget.value,
            commentId = this.commentIdTarget.value;
        if (userId !== commentedUserId) {
            $(`#comment-dsr-${commentId}`).removeClass("text-right receiver").addClass("text-left sender");
        }
        _this.currentDivTarget.remove()
    }


}