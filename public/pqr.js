function updateQRCode() {
    const date=new Date();
    const key=date.getHours()*3600+date.getMinutes()*60+date.getSeconds();
    const randomNumber = "http://localhost:8080/"+data.branch+"/"+data.batch+"/"+data.sec+"/"+data.sub+"/"+key;
    console.log(randomNumber);
    const qrCodeUrl = `https://api.qrserver.com/v1/create-qr-code/?data=${randomNumber}`;

    document.getElementById('qrcode').src = qrCodeUrl;
}
updateQRCode();
setInterval(updateQRCode, 1000);
