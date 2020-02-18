window.onload = function (){
    document.getElementById("calculate").addEventListener("click", calculateClicked);
}

function calculateClicked(){

    var speed = document.getElementById("speed").value;
    var time = document.getElementById("time").value;


    if (time== "" || speed == "") {

        alert("Please enter all of the fields!");
        return;
    }

    speed = parseInt(speed, 10);
    time = parseInt(time, 10);

    alert("You will burn " + time/60 * speed * 100 + " calories");

}
