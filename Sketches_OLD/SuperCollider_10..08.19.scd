s.boot;

~wood = Array.new;
~folder = PathName.new("C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/musicradar-contact-mic-madness-samples/Raw/Marbles");

//LOAD MULTIPLE FILES
(
~folder.entries.do({
	arg path;
	~wood = ~wood.add(Buffer.read(s, path.fullPath));
});
)

~wood.at(0).play;
~wood.at(56).bufnum;

//UGEN BUFFERS

(
SynthDef.new(\playbuf_test, {
	arg amp = 1, out = 0, rate = 1, buf, da=2, loop=0;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, loop: loop, doneAction: da);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)


Synth.new(\playbuf_test, [\buf, 5, \rate, 0.5, \loop, 1]);

7.midiratio;


~bB = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/bus-air-brake-a.wav" );


~bN = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/splash-jumping.wav");

~bB.play;

~bB.numFrames;

~bB.numChannels;

~bB.zero;

~bB.duration;

~bB.read("C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/van-sliding-door.wav");

~bB.bufnum;
~bN.bufnum;

BufRd.ar
Phasor