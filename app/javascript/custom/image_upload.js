// 巨大画像のアップロードを防止する
document.addEventListener("turbo:load", () => {
  document.addEventListener("change", (event) => {
    const image_upload = document.querySelector('#micropost_image');
    
    if (!image_upload || image_upload.files.length == 0) return

    if (image_upload.files[0].size/1024/1024 <= 5) return

    alert("Maximum file size is 5MB. Please choose a smaller file.");
    image_upload.value = "";
  });
});
