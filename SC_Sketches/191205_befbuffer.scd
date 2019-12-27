a = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/goodsounds/328727__hellska__flute-note-tremolo.wav");  //Cargar el sample

b  = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/goodsounds/355941__mtg__violin-e6-bad-timbre.wav");  //Cargar el sample

c = Buffer.read(s,"C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/goodsounds/360244__mtg__sax-baritone-e3.wav");

b.duration;
b.numChannels;
b.play;
b.free;
c.free;

c.duration;
c.play;
c.bufnum.postln;

b.bufnum.postln;

a.bufnum.postln;

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
			\buf, Prand([0,1,2],inf),
			\rate, Prand([-2, -1, -0.5,-0.25,0.25, 0.5, 1, 2], inf),
			\pan, Pwhite(-1,1,inf),
		    \rel, 15,
			\dur, 0.25
			)
		)
)

x = Synth.new(\bplaym, [\buf,1]);

~wey.clear;
~wey.set(\pos,1.0.rand);
~wey.set(\dur,0.8);
~wey.set(\rel,2.0.rand);
~wey.play;
~wey.fadeTime = 15;
~wey.set(\rate, 2);

~lfo ={LFNoise0.kr(5)};
~lfo.fadeTime = 15;
~lfo.plot;

//~wey.set(\rate, );
s.plotTree;
5.0.rand;

Quarks.gui;
