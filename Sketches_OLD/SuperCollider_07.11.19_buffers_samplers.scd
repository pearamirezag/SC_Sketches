///////SAMPLES////// BUFFERS



/// https://freesound.org/people/MTG/sounds/355138/


s.boot;

~flautremolo = Buffer.read(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/328727__hellska__flute-note-tremolo.wav");

~flaumala = Buffer.read(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/360256__mtg__flute-c5-bad-richness.wav");

//cada vez que se ejecuta el codigo de arriba, se agregan al buffer
Buffer.freeAll; //limpiar todos los buffers

~flautremolo.play;
~flaumala.play;

b.duration; // how many secs
b.numChannels; // 1 - mono, 2 - stereo
b.sampleRate; //which Sample Rate
b.numFrames; //how many samples

(
x = {
	arg t_trig=1;
	var sig;
	sig = PlayBuf.ar(
		1,
		~flautremolo.bufnum,
		rrand(0.5, 1.5),
		t_trig,
		~flautremolo.numFrames * 0.2,
		doneAction:2;
	);
}.play;
)

// several ill flutes at once

(
15.do({
(
x = {
	arg t_trig=1;
	var sig;
	sig = PlayBuf.ar(
		1,
		~flautremolo.bufnum,
				BufRateScale.kr(~flautremolo) * rrand(-1.0, 2.0).poll,
		t_trig,
		~flautremolo.numFrames * 0.001,
		doneAction:2;
	);
			sig = Splay.ar(sig);
}.play;
)
})
)


// Usar BufRateScale.kr para modificar el Rate de un archivo de audio
//esta funcion se encarga de comparar la frecuencia de muestreo del archivo y del sistema

x.set(\t_trig,1)


(
SynthDef.new(\bufplay, {
	arg buf=0, rate=1,da=2, pan=0, loop=0, amp=1, out=0;
	var sig;
	sig = PlayBuf.ar(
		1,
		buf,
		BufRateScale.kr(buf) * rate,
		loop: loop,
		doneAction: da
	);
	sig = Pan2.ar(sig, pan);
	sig = sig * amp;
	Out.ar(out,sig);
}).add;
)

Synth(\bufplay, [\buf,
