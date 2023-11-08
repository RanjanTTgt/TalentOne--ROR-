import Controller from './loader_controller';

export default class extends Controller {

    static targets = ["currentPassword", "currentPasswordSpan", "newPassword", "newPasswordSpan", "confirmPassword", "confirmPasswordSpan"]

    validate(event) {
        let currentPassword = this.currentPasswordTarget.value,
            newPassword = this.newPasswordTarget.value,
            confirmPassword = this.confirmPasswordTarget.value,
            error = false;

        this.currentPasswordSpanTarget.textContent = "";
        this.newPasswordSpanTarget.textContent = "";
        this.confirmPasswordSpanTarget.textContent = "";

        if (currentPassword.length === 0) {
            this.currentPasswordSpanTarget.textContent = "Current Password is required.";
            error = true;
        }
        if (newPassword.length === 0) {
            this.newPasswordSpanTarget.textContent = "New Password is required.";
            error = true;
        } else if (newPassword.length < 8 || newPassword.length > 16) {
            this.newPasswordSpanTarget.textContent = "Password should be more than 8 character and less than 16 character";
            error = true;
        } else if (currentPassword === newPassword) {
            this.newPasswordSpanTarget.textContent = "Current and New Password should not be same.";
            error = true;
        }
        if (confirmPassword.length === 0) {
            this.confirmPasswordSpanTarget.textContent = "Confirm Password is required.";
            error = true;
        } else if (newPassword !== confirmPassword) {
            this.confirmPasswordSpanTarget.textContent = "New and Confirm Password should not be matched.";
            error = true;
        }

        if (error) {
            event.preventDefault();
        }
    }
}