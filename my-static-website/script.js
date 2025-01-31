// script.js
document.addEventListener("DOMContentLoaded", function () {
    const demoButton = document.getElementById("demoButton");
    const message = document.getElementById("message");
  
    demoButton.addEventListener("click", function () {
      message.textContent = "Hello from JavaScript! Your button click works!";
      demoButton.disabled = true;
      demoButton.textContent = "Clicked!";
    });
  });
  