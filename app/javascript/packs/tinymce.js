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
    images_upload_handler: async function(blobInfo, success, failure, progress) {
        // fetch presigned url for direct browser upload to S3
        const res = await fetch('/uploads/presigned_url', {method: 'GET'});
        const { presigned_url, download_url } = await res.json();
    
        // upload the file to S3 using presigned url
        try {
            const file = blobInfo.blob()
            await fetch(presigned_url, {method: 'PUT', body: file});
            success(download_url)
        } catch (err) {
            failure(`Image upload failed: ${err.message}`)
        }
    }
});