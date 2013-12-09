function startup() {

    var click = new Audio("click.wav");
    click.volume = 0.50;

    var clickSound = Elm.fullscreen(Elm.SoundAttempt);

    clickSound.recv('click', function (event){
        if(event.value){
            click.play();
        }
    });
}

window.onload = startup;