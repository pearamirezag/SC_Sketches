s.boot;

(

SynthDef.new( \truco, {
	arg freq = 220;
	var sig,lfo;
	lfo = Saw.kr(0.5)*10;
	sig = SinOsc.ar([lfo+freq,freq], 0, 0.6);
	Out.ar(0, sig);
}).add;

)


x = Synth.new(\truco);
x.set(\freq, 110);
x.set(\freq, 64.6);
x.free;



(

SynthDef.new( \triqui, {
	arg freq = 220;
	var sig,lfo;
	lfo = Saw.kr(0.5)*10;
	sig = SinOsc.ar([lfo+freq,freq],0,
		mul: EnvGen.kr(
//Envelope is attack, decay, sustain level, release
		Env.adsr(0.001, 0.3, 0.2, 0.0),
			LFNoise0.kr(3)) //gate ;
	);
	Out.ar(0, Pan2.ar(sig,rrand(-1.0, 1.0) ));
}).add;

)


(

SynthDef.new( \truqui, {
	arg freq = 220;
	var sig,lfo;
	lfo = Saw.kr(0.5)*10;
	sig = SinOsc.ar([lfo+freq,freq],0,
		mul: EnvGen.kr(
//Envelope is attack, decay, sustain level, release
		Env.adsr(0.001, 0.3, 0.2, 0.0),
			Dust.kr(3)) //gate ;
	);
	Out.ar(0, Pan2.ar(sig,rrand(-1.0, 1.0) ));
}).add;

)

z = Synth.new(\truqui);
z.set(\freq, 12000);
z.set(\freq, 20000);
z.free;




