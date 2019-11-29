

(

SynthDef.new(\holas, {
	arg freq = 440, rate = 6, trigg = 3;
	var sig, lfo;
	lfo = LFNoise0.kr(rate).range(-1, 2);
	sig = SinOsc.ar(freq*lfo, mul: EnvGen.kr(Env.asr(0.01, 0.7, 0.5), Dust.kr(trigg)));
	Out.ar(0, Pan2.ar(sig, LFNoise0.kr(3)));
}).add;

)

s.boot;

x = Synth.new(\holas);
x.set(\rate, 2);
x.set(\trigg, 5);
x.set(\freq, 100);






		