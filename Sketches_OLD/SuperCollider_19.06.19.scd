s.boot;

(
	SynthDef.new(\azucar, {
		arg dens = 3, freq = 880, dcy = 0.2;
		var sig, lfo;
		lfo = SinOsc.kr(WhiteNoise.kr());
	sig = SinOsc.ar(freq*lfo,2pi/4, mul: EnvGen.kr( Env.perc(releaseTime: dcy), Dust.kr(dens), doneAction: 0));
		Out.ar(0, Pan2.ar(sig, Dust2.kr(2)))
	}).add;
)

s.scope;
y = Synth.new(\azucar);
y.set(\dens, 15);
y.set(\dcy, 0.05);
y.set(\freq, 8000);