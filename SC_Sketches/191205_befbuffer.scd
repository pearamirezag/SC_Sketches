b = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/328727__hellska__flute-note-tremolo.wav");  //Cargar el sample

b = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/355941__mtg__violin-e6-bad-timbre.wav");  //Cargar el sample

b.duration;
b.numChannels;
b.play;
b.free;

b.bufnum.postln;

s.boot;
p = ProxySpace.push(s); //iniciar la arquitectura proxy


(
SynthDef(\bplaym,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
		var sig,env ;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;
) //Ugen de sampler

p.clear;
s.plotTree; //ver los sintes activos

(
	~wey = (
		Pbind(
			\instrument, \bplaym,
			\buf, 5,
			\rate, Prand([-2, -1, -0.5,-0.25,0.25, 0.5, 1, 2], inf),
			\pan, Pwhite(-1,1,inf),
		    \rel, 15
			)
		)
)


~wey.set(\pos,1.0.rand);
~wey.set(\dur,0.5);
~wey.set(\rel,2.0.rand);
~wey.play;
~wey.fadeTime = 15;
//~wey.set(\rate, );

5.0.rand;