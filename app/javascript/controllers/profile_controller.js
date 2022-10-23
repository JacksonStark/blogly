import { Controller } from "@hotwired/stimulus";
import { imagesUploadHandler } from "../utils/uploader";

export default class extends Controller {
    connect() {
        document.querySelector(".profile-image-uploader").onchange = function (e) {
            const file = e.target.files[0];

            imagesUploadHandler(file, (download_url) => { // success callback
                document.getElementById('profile_image_url').value = download_url
                document.getElementById("profile_image_tag").src = download_url
            });
        };
    }
}
