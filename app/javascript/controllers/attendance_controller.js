import Controller from './loader_controller';

export default class extends Controller {
    static values = {
        interval: { default: 500, type: Number },
        locale: { default: 'en-GB', type: String },
        from: String,
    };

    static targets = [
        'timer',
        'attendance',
    ];

    static classes = ["display"];

    timeIn(){
        var _this = this;
        this.startLoader();
        $.ajax({
            type: "post",
            url: '/attendance/time_in',
            success: function (data) {
                _this.stopLoader();
            },
            error: function (data) {
                _this.stopLoader();
                alert('Error: no Category match this ID')
            }
        })
    }

    timeOut(){
        const confirmed = confirm('Are you sure you want to time out ?');
        if(!confirmed) return;
        var _this = this;
        _this.startLoader();
        $.ajax({
            type: "post",
            url: '/attendance/time_out',
            success: function (data) {
                _this.stopLoader();
            },
            error: function (data) {
                _this.stopLoader();
                alert('Error: no Category match this ID')
            }
        })
    }


    connect() {
        $("#loader-body").css("display", "none")
        this._timer = setInterval(()=> {
            this.setTimeValues();
        }, this.intervalValue)
        this.setTimeValues();
    }

    setTimeValues() {
        const timeIn = this.hasFromValue && new Date(this.fromValue);
        if (!timeIn) return;
        const now = new Date();
        this.timerTargets.forEach((element) => {
            element.innerText = this.convertHMS((now - timeIn)/1000);
        });
    }

    convertHMS = (value) => {
        const sec = parseInt(value, 10);
        let hours   = Math.floor(sec / 3600);
        let minutes = Math.floor((sec - (hours * 3600)) / 60);
        let seconds = sec - (hours * 3600) - (minutes * 60);
        // add 0 if value < 10; Example: 2 => 02
        if (hours   < 10) {hours   = "0"+hours;}
        if (minutes < 10) {minutes = "0"+minutes;}
        if (seconds < 10) {seconds = "0"+seconds;}
        return hours+':'+minutes+':'+seconds; // Return is HH : MM : SS
    }

    stopTimer() {
        const timer = this._timer;
        if (!timer) return;
        clearInterval(timer);
    }

    disconnect() {
        // ensure we clean up so the timer is not running if the element gets removed
        this.stopTimer();
    }

}
// const BEFORE = 'BEFORE';
// const DURING = 'DURING';
// const AFTER = 'AFTER';
//
// export default class extends Controller {
//     static values = {
//         interval: { default: 500, type: Number },
//         locale: { default: 'en-GB', type: String },
//         from: String,
//         to: String,
//     };
//
//     static targets = [
//         'before',
//         'during',
//         'after',
//         'fromTime',
//         'toTime',
//         'toTimeRelative',
//     ];
//
//     connect() {
//         this._timer = setInterval(() => {
//             // this.update();
//         }, this.intervalValue);
//
//         // this.setTimeValues();
//         this.update();
//     }
//
//     getTimeData() {
//         const from = this.hasFromValue && new Date(this.fromValue);
//         const to = this.hasToValue && new Date(this.toValue);
//
//         if (!from || !to) return;
//         if (from > to) {
//             throw new Error('From time must be after to time.');
//         }
//
//         const now = new Date();
//
//         const status = (() => {
//             if (now < from) return BEFORE;
//
//             if (now >= from && now <= to) return DURING;
//
//             return AFTER;
//         })();
//
//         return { from, to, now, status };
//     }
//
//     setTimeValues() {
//         const { from, to, now } = this.getTimeData();
//         const locale = this.localeValue;
//
//         const formatter = new Intl.DateTimeFormat(locale, {
//             dateStyle: 'short',
//             timeStyle: 'short',
//         });
//
//         this.fromTimeTargets.forEach((element) => {
//             element.setAttribute('datetime', from);
//             element.innerText = formatter.format(from);
//         });
//
//         this.toTimeTargets.forEach((element) => {
//             element.setAttribute('datetime', to);
//             element.innerText = formatter.format(to);
//         });
//
//         const relativeFormatter = new Intl.RelativeTimeFormat(locale, {
//             numeric: 'auto',
//         });
//
//         this.toTimeRelativeTargets.forEach((element) => {
//             element.setAttribute('datetime', to);
//             element.innerText = relativeFormatter.format(
//                 Math.round((to - now) / 1000),
//                 'seconds'
//             );
//         });
//     }
//
//     update() {
//         const { status } = this.getTimeData();
//
//         [
//             [BEFORE, this.beforeTarget],
//             [DURING, this.duringTarget],
//             [AFTER, this.afterTarget],
//         ].forEach(([key, element]) => {
//             if (key === status) {
//                 element.style.removeProperty('display');
//             } else {
//                 element.style.setProperty('display', 'none');
//             }
//         });
//
//         this.setTimeValues();
//
//         if (status === AFTER) {
//             this.stopTimer();
//         }
//     }
//
//     stopTimer() {
//         const timer = this._timer;
//
//         if (!timer) return;
//
//         clearInterval(timer);
//     }
//
//     disconnect() {
//         // ensure we clean up so the timer is not running if the element gets removed
//         this.stopTimer();
//     }
// }
