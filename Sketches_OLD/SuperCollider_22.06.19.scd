

Platform.systemExtensionDir;



s.boot;

(
x = SynthDef.new(\Siril,{
	var sig;

	sig = JPverb.ar( SawDPW.ar(
		{ExpRand(200, 2000)}!8,
		mul: EnvGen.kr(Env.perc(releaseTime:0.2), {Dust.kr(1)}!8)));
	sig = Splay.ar(sig);
	Out.ar(0, sig);

}

).add;
)

// Acá separé el envelope afuera del UGen que producía sonido
(
x = SynthDef.new(\Siril,{

	var sig, amp;

	sig = SawDPW.ar(
		{ExpRand(5000, 16000)}!8);
	amp = EnvGen.kr(Env.perc(releaseTime:0.2), {Dust.kr(1)}!8);
	sig = Splay.ar(sig) * amp;
	sig = JPverb.ar(sig, );
	Out.ar(0, sig);

}

).add;
)

(
x = SynthDef.new(\SirilTri,{
	arg durati = 0.1, cutof = 1000;
	var sig, amp, freqtone;
	freqtone = {ExpRand(50, 2000)}!8;
	sig = SawDPW.ar(
		freqtone);
	amp = EnvGen.kr(Env.sine(dur:durati), Dust.kr({ExpRand(0.1,5)}!8));
	sig = Splay.ar(sig) * amp;
	sig = DFM1.ar(sig, cutof);
	sig = JPverb.ar(sig);
	Out.ar(0, sig);

}

).add;
)

x = Synth.new(\Siril);
y = Synth.new(\SirilTri);
y.set(\durati, 2);
y.set(\cutof, 5000);

Quarks.gui

s.meter;

s.scope;

DFM1.ar
