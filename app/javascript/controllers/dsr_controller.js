import Controller from './loader_controller';

export default class extends Controller {
    static targets = [
        "add_item", "new_project_task", "new_task", "detail_view", "send_detail", "swalModal", "swalText",
        "task", "description", "startTime", "endTime", "newDocument", "documentList"
    ];

    connect(){
        this.addClockPicker();
    }

    addDocument(event) {
        event.preventDefault();
        var content = this.newDocumentTarget.innerHTML.replace(/NEW_DSR_DOCUMENT/g, new Date().valueOf());
        this.documentListTarget.insertAdjacentHTML('beforebegin', content);
    }

    removeDocument(event) {
        event.preventDefault();
        const confirmed = confirm('Are you sure you want to delete this attachment?');
        if (!confirmed) return;
        let item = event.target.closest("div#remove-document-div");
        item.remove()
    }


    add_association(event) {
        event.preventDefault();
        var content = this.new_project_taskTarget.innerHTML.replace(/NEW_PROJECT_TASK/g, new Date().valueOf());
        this.add_itemTarget.insertAdjacentHTML('beforebegin', content);
        this.addClockPicker();
    }

    add_sub_association(event) {
        event.preventDefault();
        var content = this.new_taskTarget.innerHTML.replace(/NEW_TASK/g, new Date().valueOf());
        var elementBody = event.target.closest("table").tBodies;
        elementBody[elementBody.length - 1].insertAdjacentHTML('afterend',content)
        this.addClockPicker();
    }

    remove_association(event) {
        event.preventDefault();
        const confirmed = confirm('Are you sure you want to delete task?');
        if(!confirmed) return;
        let item = event.target.closest("table");
        item.remove()
    }

    remove_sub_association(event) {
        event.preventDefault();
        const confirmed = confirm('Are you sure you want to delete task?');
        if(!confirmed) return;
        let item = event.target.closest(".sub-table-body");
        item.remove()
    }

    fetchSendDsr(event){
        this.fetchDsrDetail(event,"/dsr/fetch_send");
    }

    fetchReceivedDsr(event){
        this.fetchDsrDetail(event,"/dsr/fetch_received");
    }


    fetchDsrDetail(event, url){
        event.preventDefault();
        let _this = this;
        _this.detail_viewTarget.style.display = "block";
        let item = event.target.closest(".dsr-point");
        if(item.classList.contains("active-row")){
            return null;
        }
        _this.startLoader();
        $(".active-row").removeClass("active-row");
        item.classList.add("active-row");
        $.ajax({
            type: "post",
            data: event.params,
            url: url,
            success: function (data) {
                _this.stopLoader();
                _this.detail_viewTarget.innerHTML = data;
            },
            error: function (data) {
                _this.stopLoader();
            }
        })
    }

    toggleDetail(event){
        event.preventDefault();
        if(this.send_detailTarget.style.display === "block"){
            this.send_detailTarget.style.display = "none";
        } else {
            this.send_detailTarget.style.display = "block";
        }
    }

    closeModal(event){
        event.preventDefault();
        var item = event.target.closest("div#comments-modal");
        item.remove();
    }

    addClockPicker = () =>{
        let _this = this;
        $(".timer").clockpicker({
            placement: 'bottom',
            align: 'left',
            autoclose: true,
            default: 'now',
            donetext: "Select"
        });

        $('.end_time').on('change', function (){
            var current_end_time_id = $(this).attr('id');
            var explode_id = current_end_time_id.split('_end_time');
            var current_start_time_id = `${explode_id[0]}_start_time`;
            setTimeout(()=>{
                checkTimeDifference(current_start_time_id, current_end_time_id);
            },50);
        });

        $('.start_time').on('change', function (){
            var current_start_time_id = $(this).attr('id');
            var explode_id = current_start_time_id.split('_start_time');
            var current_end_time_id = `${explode_id[0]}_end_time`;
            setTimeout(()=>{
                checkTimeDifference(current_start_time_id, current_end_time_id);
            },50);
        });
        function checkTimeDifference(current_start_time_id, current_end_time_id){
            let startTimeObj = $(`#${current_start_time_id}`), endTimeObject =  $(`#${current_end_time_id}`);
            var start_time = startTimeObj.val(), end_time = endTimeObject.val();

            if(end_time === '' || !end_time){
                return false
            }
            if(start_time === '' || !start_time){
                _this.setSwalTextAndShow("Please enter start time first");
                endTimeObject.val('');
                return false;
            }
            var timeStart = new Date(`01/01/2007 ${start_time}`);
            var timeEnd = new Date(`01/01/2007 ${end_time}`);
            var seconds = (timeEnd.getTime() - timeStart.getTime()) / 1000;
            var minutes = seconds / 60;
            if(minutes > 60){
                _this.setSwalTextAndShow("Time of one task should not be greater than 1 hour. You can break the task into two or more tasks.");
                endTimeObject.val('');
                return false;
            }
            if(minutes <= 0){
                _this.setSwalTextAndShow("End time should not be less than or equal to start time.");
                endTimeObject.val('');
                return false;
            }
        }
    }

    setSwalTextAndShow(text){
        this.swalTextTarget.innerHTML = text;
        this.swalModalTarget.style.display = "block";
    }

    hideSwalModal(){
        this.swalModalTarget.style.display = "none";
    }

    validate(event){
        let error = false;
        this.descriptionTargets && this.descriptionTargets.map((descriptionTarget)=>{
            if(this.validateError($(descriptionTarget))){
                error = true;
            }
        });
        this.taskTargets && this.taskTargets.map((taskTarget)=>{
            if(this.validateError($(taskTarget))){
                error = true;
            }
        });

        this.startTimeTargets && this.startTimeTargets.map((startTimeTarget)=>{
            if(this.validateError($(startTimeTarget))){
                error = true;
            }
        });

        this.endTimeTargets && this.endTimeTargets.map((endTimeTarget)=>{
            if(this.validateError($(endTimeTarget))){
                error = true;
            }
        });

        if(error){
            event.preventDefault();
        }
    }

    validateValue(event){
        if(event.target.value.trim().length > 0){
            $(event.target).closest("td").children(".text-danger").html("")
        }
    }

    validateError(target){
        let error = false;
        if(target.val().trim().length === 0){
            error = true;
            target.closest("td").children(".text-danger").html("This field is required.")
        } else {
            target.closest("td").children(".text-danger").html("")
        }
        return error;
    }

}