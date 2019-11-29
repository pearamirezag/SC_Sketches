s.meter;
s.boot;
s.plotTree;

(
SynthDef.new(\blip, {
	arg out;
	var freq, trig, sig, decy = 0.2, ata = 0.01;
	freq = LFNoise0.kr(3).exprange(300,1200).round(300);
	sig = SinOsc.ar(freq)* 0.25;
	trig = Dust.kr(5);
	sig = sig * EnvGen.kr(Env.asr(ata, 1, decy), trig);
	Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\delay, {
	arg in, out;
	var sig, dlytime = 0.2, dcytime = 0.1;
	sig = In.ar(in,1);
	sig = CombN.ar(sig, 500, dlytime, dcytime)!2;
	Out.ar(out, sig);
}).add
)


x = Synth.new(\blip);
y = Synth.new(\delay);
x.set(\out, 5);
y.set(\out, 0);
y.set(\in, 5);
y.set(\dlytime, 2);
y.set(\dcytime, 2);
x.set(\decy, 800);
x.set(\ata, 10);

y.free;
x.free;