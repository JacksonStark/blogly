import { imagesUploadHandler } from '../utils/tinymce_uploader'

export function initTinyMce() {
    tinymce.init({
        selector: '.tinymce',
        height: 350,
        menubar: false,
        plugins: [
            'image',
            'advlist autolink lists link image charmap print preview anchor',
            'searchreplace visualblocks code fullscreen',
            'insertdatetime media table paste code help wordcount'
        ],
        toolbar: 'file edit view insert format tools undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help | image',
        content_style: "body {font-size: 11pt; color: #374151}",
        skin: 'oxide-dark',
        automatic_uploads: true,
        paste_data_images: true,
        images_upload_handler: imagesUploadHandler
    });
}